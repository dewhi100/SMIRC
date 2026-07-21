; From https://github.com/theonlydude/RandomMetroidSolver/blob/master/patches/common/src/decompression.asm
;$30FF-$3265

;;; Decompression optimization by Kejardon, with fixes by PJBoy and Maddo

;Compression format: One byte(XXX YYYYY) or two byte (111 XXX YY-YYYYYYYY) headers
;XXX = instruction, YYYYYYYYYY = counter

;Modified by Tundain (20/12/2023: DMY)

;changes by Tundain:
;-when checking for overflow, the branch is now taken whenever there is overflow, rather than when there's not
;	because a non-taken branch is 1 cycle cheaper, and this happens more often
;	this leads to a bit more code, but i believe it's worth it (there's some space left before hitting the VRAM decomp routine
;-direct copy has been moved in front of the main loop, because that way a JMP doesn't need to get taken from there.
;-word fill has been modified to go straight into 16-bit mode, to avoid having to load a word whilst in 8-bit mode
;-Because storing happens more often than loading during decompression, DB is now set to the destination bank.
;	this means loading now uses indirect long, and storing indirect short
;	updating source bank is also simpler now


;doesn't change that much, but it is faster!

lorom

org $80B0FF
	
	LDA $02, S
	STA $45
	LDA $01, S
	STA $44		;Address of target address for data into $44
	CLC
	ADC #$0003
	STA $01, S	;Skip target address for RTL
	LDY #$0001
	LDA [$44], Y
	STA $4C
	INY
	LDA [$44], Y
	STA $4D
;80B119 : Later JSL start if 4C (target address) is specified
Start:
	PHP
	PHB
	SEP #$20
;	REP #$10	;This is only POSSIBLY useful from JSL 80B119... Tundain: was unnecessary, so removed
	LDA $4E
	PHA
	PLB
	STZ $50
	LDY #$0000
	JMP NextByte

End:
	PLB
	PLP
	RTL

NextBytecheck:
JSR IncrementBank2 : BRA NextBytereturn

Option0check:
JSR IncrementBank2 : BRA Option0return	
	
	Option0:;this one is here so one of the commands doesn't need a JMP to go back to the start (ugly, but saves those extra 3 cycles)
-

	LDA [$47]	;X = 0: Directly copy Y bytes
	INC $47
	BEQ Option0check
	Option0return:

	STA ($4C), Y
	INY
	DEX

	BNE -

NextByte:
	LDA [$47]
	INC $47
	BEQ NextBytecheck
	NextBytereturn:
	STA $4A
	CMP #$FF
	BEQ End
	CMP #$E0
	BCC ++
	ASL A
	ASL A
	ASL A
	AND #$E0
	STA $00
	LDA $4A
	AND #$03
	XBA

	LDA [$47]
	INC $47
	BEQ .SecondPartCheck
	.SecondPartReturn:
	BRA +++

++

	AND #$E0
	STA $00
	TDC
	LDA $4A
	AND #$1F

+++

	TAX
	INX
	LDA $00

	BMI Option4567

	BEQ Option0

	CMP #$20

	BEQ BRANCH_THETA

	CMP #$40

	BEQ BRANCH_IOTA

;X = 3: Store an ascending number (starting with the value of the next byte) Y times.
	LDA [$47]
	INC $47
	BEQ .Ascendcheck
	.Ascendreturn:

-

	STA ($4C), Y
	INC A
	INY
	DEX

	BNE -

	JMP NextByte
	.Ascendcheck:
	JSR IncrementBank2 : BRA .Ascendreturn
	
	.SecondPartCheck:
	JSR IncrementBank2 : BRA .SecondPartReturn

BRANCH_THETA:
	;X = 1: Copy the next byte Y times.
	LDA [$47]
	INC $47
	BEQ .ByteCopycheck
	.ByteCopyreturn:

-
	STA ($4C), Y
	INY
	DEX

	BNE -

	JMP NextByte
	.ByteCopycheck:
	JSR IncrementBank2 : BRA .ByteCopyreturn

BRANCH_IOTA:
	REP #$20 : TXA : LSR : TAX; : SEP #$20 ; PJ: X /= 2 and set carry if X was odd Tundain: removed SEP #$20, stay in 16-bit mode for faster writing

	LDA [$47]	;X = 2: Copy the next two bytes, one at a time, for the next Y bytes.
	INC $47
	BNE +
	SEP #$20;edge case where the word is sitting just on the edge of two banks, this is probably insanely rare, i bet
	DEC $48;bc 16-bit mode was used, decrement high byte so can still call Incrementbank
	JSR IncrementBank2
	XBA : LDA [$47] : XBA ;get the second half from the other bank
	REP #$20
+
	INC $47
	BEQ .incbank	

;	INX ; Test if X = 0 without overwriting carry
;	DEX
;	BEQ ++  ; If X = 0 then skip the loop (otherwise X would underflow and the loop would run $10000 times)
;	REP #$20
	;unnecessary, because this would happen if this command said: copy this word 0 times, which, if would happen, would indicate a faulty compressor

	.WordCopyreturn:
-
	STA ($4C), Y
	INY
	INY
	DEX
	BNE -
;++
	SEP #$20


	BCC + : STA ($4C), Y : INY : + ; PJ: If carry was set, store that last byte 

	JMP NextByte
	.incbank:
	STA $00; need to store A bc Incrementbank overwrites half of A
	INC $49 : LDA #$8000 : STA $47 : LDA $00 : BRA .WordCopyreturn;<--fixed an error here (07/02/2024)DMY

Option4567:

	CMP #$C0

	AND #$20	;X = 4: Copy Y bytes starting from a given address in the decompressed data.
	STA $4F  	;X = 5: Copy and invert (EOR #$FF) Y bytes starting from a given address in the decompressed data.

	BCS +++	;X = 6 or 7 branch

	LDA [$47]
	INC $47
	BEQ .Option45Check
	.Option45return:

	XBA
	LDA [$47]
	INC $47
	BEQ .Option45Check2
	.Option45return2:

	XBA
	REP #$21
	ADC $4C
	STY $44
	SEC
--
	SBC $44
	STA $44
	SEP #$20

;XBA : XBA : REP : ADC dp : STY dp : SEC : SBC dp : STA dp : SEP. 3+3+3+4+4+2+4+4+3 = 30
;STA dp : STA dp : REP : TYA : EOR : INC : ADC dp : CLC : ADC dp : STA dp : SEP. 3+3+3+2+3+2+4+2+4+4+3 = 33

;--
	LDA $4E
	BCS +
	DEC
+
	STA $46
+
	LDA $4F
	BNE +	;Inverted

-
	LDA [$44], Y;
	STA ($4C), Y
	INY
	DEX

	BNE -
	JMP NextByte

+
-
	LDA [$44], Y;
	EOR #$FF
	STA ($4C), Y
	INY
	DEX

	BNE -
	JMP NextByte
	
	.Option45Check:
	JSR IncrementBank2 : BRA .Option45return
	.Option45Check2:
	JSR IncrementBank2 : BRA .Option45return2

+++

	;X = 6: Copy Y bytes starting from a given number of bytes ago in the decompressed data.
	;X = 7: Copy and invert (EOR #$FF) Y bytes starting from a given number of bytes ago in the decompressed data.

	TDC

	LDA [$47]
	INC $47
	BEQ .Option67Check
	.Option67return:

	REP #$20;fixed an issue here that would cause a miscalculation if bank has overflown just before
	STA $44
	LDA $4C
;	SEC	;I think I can get away without this :D
;	SBC $4A
;	STA $44
;	SEP #$20

	BRA --
	
.Option67Check:
	JSR IncrementBank2 : BRA .Option67return


IncrementBank2:
print "inc: $",pc
	INC $48 : BEQ +; a branch not taken is 1 cyle cheaper than a taken one (and not taking the branch happens more often)
	RTS
+
	PHA ; after much trial and error, seems like stack usage is unavoidable 27/03/2024 (DMY)
	INC $49
	LDA #$80
	STA $48
	PLA
	RTS
	
	

warnpc $80B266

  

