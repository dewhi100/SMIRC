;;
;; Item percent and game time displayed on equipment screen
;; Ending Totals included (with corrected arithmetic)
;;
;; Modifications and equipment screen by FelicityVi
;; Original ending totals by Scyzer
;;

;!CollectedItems = $7ED86E
;!TotalItems = 100	;TOTAL number if items in the game. This includes ALL items: missiles, upgrades, etc

;!BlankTile = #$2801
;!NumbersStart = $3804
;!PercentSign = #$3802
;!DecimalPoint = #$381C
;!Colon = #$381D

!PercentTilemapAddr = $7E3A46
!TimerTilemapAddr = $7E3B06
;!TimeHours = $09E0
;!TimeMinutes = $09DE
;!TimeSeconds = $09DC
;!TimeFrames = $09DA


lorom

;org $B68000
;	incbin itemstime-includes/pausemap.gfx	SMART already has this

if !EquipScreenDisassembly_Tundain == 0
	org $B6E800
		incbin itemstime-includes/equip-screen.ttb
endif
;;
;; a few tweaks to stop the game from drawing the reserve text, number, and bar on the equipment screen
;;
org $828D2C		;load pause screen tilemaps
	JSR continueLoadingHijack

org $828F6B					;reserve number
	NOP : NOP : NOP
org $8291B1					;load equipment screen routine
	JSR itemsTimeHijack
	
org $82A14B					;normally JSR $A27E (copy $16 bytes from [X] to [$00])
	NOP : NOP : NOP		;used to write reserve tank text
org $82A167
	NOP : NOP : NOP		;same ^^^

org $82AC82 : NOP #3	;dewhi addition. skips the reserves arrow coloration which is not noticeable in the base aptch but is visible because I altered the equip screen ttb

if !MapOverhaul_Mfreak == 0
	org $82AB59					;equipment - set up reserve mode and determine initial selection
		BRA $3A					;always assume no reserve tanks
	org $82ABB0
		BRA $08
endif

	org $82AC18
		BRA $06

	;org $82B43F					;code to move to reserve tank selection
	;	JSR $B456
	;	RTS
	
org $82B037
	NOP : NOP : NOP		;remove call to move to reserve tanks from beams

org $82B26A		;draw item selector
	LDA $09A4	;collected items
	AND #$3FFF	;Mask grapple and X-ray bits (they arent on item screen)
	ORA $09A8	;collected beams

org !free82 ;$82FF00					;these 7 bytes of code are just to ensure that the %/time is drawn during fade-in
	itemsTimeHijack:
	JSR $AB47
	JSR $B2A2
	RTS

	continueLoadingHijack:
	JSR $9009
	JSR $B2A2
	RTS

!free82 #= pc()

;;
;; Scyzer's endingtotals.asm
;;

org $84889F
	JSL COLLECTTANK
	
org !free84	;$84EFE0
COLLECTTANK:
	PHA
	LDA !CollectedItems
	INC A
	STA !CollectedItems
	PLA
	JSL $80818E
	RTL

!free84 #= pc()
	
org $8BE627
	PHP
	PHB
	PHK
	PLB
	REP #$30
	PHX
	PHY
	JSL CALC_PERCENT

ENDING_HUNDREDS:
	LDA $12						;Load hundreds value
	BEQ ENDING_TENS				;If 0, don't draw hundreds digit
	ASL A : ASL A
	TAY
	LDA $E741,y
	STA $7E339A
	LDA $E743,y
	STA $7E33DA
ENDING_TENS:
	LDA $14						;Load tens value
	BNE ENDING_DRAW_TENS		;If more than 0, draw tens digit
	LDA $12						;If 0, load hundreds value
	BEQ ENDING_ONES				;If hundreds is 0, don't draw tens digit
	LDA $14
ENDING_DRAW_TENS:
	ASL A : ASL A
	TAY
	LDA $E741,y
	STA $7E339C
	LDA $E743,y
	STA $7E33DC
ENDING_ONES:
	LDA $16						;load ones value
	ASL A : ASL A
	TAY
	LDA $E741,y
	STA $7E339E
	LDA $E743,y
	STA $7E33DE
	LDA #$385A			;Load decimal point sign
	STA $7E33E0
	LDA $18						;load one/tenths value
	ASL A : ASL A
	TAY
	LDA $E741,y
	STA $7E33A2
	LDA $E743,y
	STA $7E33E2
	LDA #$386A			;draw percentage sign
	STA $7E33A4
	LDA #$387A
	STA $7E33E4
	PLY
	PLX
	PLB
	PLP
	RTS

;;
;; Equipment screen hijack to draw in item % and game time
;; x,y location on screen that these are drawn to can be changed if you want
;; !PercentTilemapAddr for where the hundreds digit will draw, !TimerTilemapAddr for
;; where the tens digit of the hours in the timer will draw
;;
;; To move them up or down 1 row, subtract or add $40 to the address (respectively)
;; To move them left or right 1 tile, subtract or add $2
;;

org $82B2A2					;normally calls the function to draw reserves
	JSL DRAW_TIME_PERCENT
;	JSR $82B2AA				;might use this later (draws reserve tank bar)
	RTS

org !free89	;$89B000					;can change this to whatever you want
DRAW_TIME_PERCENT:
	PHP
	REP #$30
	PHX
	PHY
	JSL CALC_PERCENT
	CLC

HUNDREDS:
	LDA $12						;Load hundredths value
	BEQ HU_blank				;If 0, don't draw hundredths digit
	LDA !NumbersStart+1
	STA !PercentTilemapAddr
	BRA TENS
HU_blank:
	LDA !BlankTile
	STA !PercentTilemapAddr

TENS:
	LDA $14						;Load tenths value
	BNE DRAWTENS					;If more than 0, draw tenths digit
	LDA $12						;If 0, load hundredths value
	BNE DRAWTENS					;If hundredths is 0, don't draw tenths digit

	LDA !BlankTile
	LDX #$0002
	STA !PercentTilemapAddr,x
	BRA ONES
DRAWTENS:
	LDA !NumbersStart
	ADC $14
	LDX #$0002
	STA !PercentTilemapAddr,x

ONES:
	LDA !NumbersStart
	ADC $16
	LDX #$0004
	STA !PercentTilemapAddr,x

	LDA !DecimalPoint
	INX : INX
	STA !PercentTilemapAddr,x

TENTHS:
	LDA !NumbersStart
	ADC $18
	INX : INX
	STA !PercentTilemapAddr,x
	
HUNDREDTHS:
	LDA !NumbersStart
	ADC $10
	INX : INX
	STA !PercentTilemapAddr,x
	
	LDA !PercentSign
	INX : INX
	STA !PercentTilemapAddr,x

;; ----FINISHED DRAWING ITEM PERCENT----

DRAW_TIME:
	STZ $10

HANDLE_HOURS:
	LDA !TimeHours
	BNE DRAW_HOURS

	LDA !BlankTile
	LDX #$0000
	STA !TimerTilemapAddr,x
	INX : INX
	STA !TimerTilemapAddr,x
	INX : INX
	STA !TimerTilemapAddr,x
	BRA HANDLE_MINUTES
DRAW_HOURS:
	STA $4204
	SEP #$20
	LDA #$0A
	STA $4206
	NOP : NOP : NOP : NOP : NOP : NOP : NOP
	REP #$20
	LDA $4216
	PHA
	
	LDA $4214
	BNE H_DRAW1

	LDA !BlankTile
	STA !TimerTilemapAddr
	BRA H_DRAW2
H_DRAW1:
	ADC !NumbersStart
	STA !TimerTilemapAddr
H_DRAW2:
	PLA
	ADC !NumbersStart
	LDX #$0002
	STA !TimerTilemapAddr,x
	INX : INX
	LDA !Colon
	STA !TimerTilemapAddr,x
	LDA #$0001					;set a flag that indicates TimeHours is nonzero
	STA $10

HANDLE_MINUTES:
	LDA !TimeMinutes
	BNE DRAW_MINUTES

	LDA $10
	BNE ZERO_MINUTES

	LDA !BlankTile
	LDX #$0006
	STA !TimerTilemapAddr,x
	INX : INX
	LDA !NumbersStart
	STA !TimerTilemapAddr,x
	INX : INX
	LDA !Colon
	STA !TimerTilemapAddr,x
	BRA HANDLE_SECONDS
ZERO_MINUTES:
	LDA !NumbersStart
	LDX #$0006
	STA !TimerTilemapAddr,x
	INX : INX
	STA !TimerTilemapAddr,x
	BRA HANDLE_SECONDS
DRAW_MINUTES:
	STA $4204
	SEP #$20
	LDA #$0A
	STA $4206
	NOP : NOP : NOP : NOP : NOP : NOP : NOP
	REP #$20
	LDA $4216
	PHA					; +1
	
	LDA $4214
	BNE M_DRAW1			; -1 = 0

	LDA !BlankTile
	PHA					; + 1 = 2
	LDA $10
	BEQ SINGLE_MINUTES
	PLA					;whoops, this was missing in the original for some reason and causes a stack desync (pushes 3 times puls twice)
	LDA !NumbersStart
	PHA
SINGLE_MINUTES:
	PLA
	LDX #$0006
	STA !TimerTilemapAddr,x
	BRA M_DRAW2
M_DRAW1:
	ADC !NumbersStart
	LDX #$0006
	STA !TimerTilemapAddr,x
M_DRAW2:
	PLA
	ADC !NumbersStart
	LDX #$0008
	STA !TimerTilemapAddr,x
	INX : INX

HANDLE_SECONDS:
	LDX #$000A

	LDA !Colon
	STA !TimerTilemapAddr,x

	LDA !TimeSeconds
	BNE DRAW_SECONDS
	
	LDA !NumbersStart
	LDX #$000C
	STA !TimerTilemapAddr,x
	INX : INX
	STA !TimerTilemapAddr,x
	BRA BRANCH_RETURN
DRAW_SECONDS:
	STA $4204
	SEP #$20
	LDA #$0A
	STA $4206
	NOP : NOP : NOP : NOP : NOP : NOP : NOP
	REP #$20
	LDA $4214
	ADC !NumbersStart
	LDX #$000C
	STA !TimerTilemapAddr,x
	INX : INX
	LDA $4216
	ADC !NumbersStart
	STA !TimerTilemapAddr,x

BRANCH_RETURN:
	PLY
	PLX
	PLP
	RTL
	
;;
;; General use percentage calculating function
;; Places the hundreds digit in $12, tens in $14, ones in $16, tenths in $18, and hundredths in $10
;;	

CALC_PERCENT:
	PHP
	REP #$30
	PHA
	PHX
	PHY
	
	SEP #$20
	STZ $03
	STZ $12
	LDA !CollectedItems				;Load number of collected items in the game
	STA $4202
	LDA #$64					;Load #100 decimal
	STA $4203
	NOP : NOP : NOP : NOP : NOP : NOP : NOP
	REP #$20
	LDA $4216					;Load number of (collected items * 100)
	STA $4204					;Store to devisor A
	SEP #$20
	LDA #!TotalItems					;Load total number of game items
	STA $4206					;Store to devisor B
	NOP : NOP : NOP : NOP : NOP : NOP : NOP
	REP #$20
	LDA $4214					;Load ((collected items * 100)/Total items) ie Item percent
	STA $4204
	LDA $4216					;Load remainder
	PHA

	SEP #$20
	LDA #$0A
	STA $4206
	NOP : NOP : NOP : NOP : NOP : NOP : NOP		;Calculate percentage / 10
	REP #$20
	LDA $4214					;Load tenths of percentage / 10 (eg, if 78, load 7, if 53, load 5)
	STA $4204					;Store value to devisor A
	LDA $4216					;Load remainder of percentage / 10 (eg, if 78, load 8, if 53, load 3)
	STA $16						;Store to $16. oneths of percentage. if 78, = 8, if 100, = 0
	SEP #$20
	LDA #$0A
	STA $4206					
	NOP : NOP : NOP : NOP : NOP : NOP : NOP		;Divide percentage by 10 again
	REP #$20
	LDA $4214					;If 100%, this will be 1
	STA $12						;Store to $12. Contains 100th of percentage. WIll only be 1 if 100% achieved
	LDA $4216					;Load remainder, which will be 0 if 100% achieved
	STA $14						;Store to $14

;; ----CALCULATE TENTHS DECIMAL----

	PLA
	;AND #$00FF
	SEP #$20
	STA $4202
	LDA #$0A
	STA $4203										;Multiply remainder by 10 before dividing it by total number of items
	NOP : NOP : NOP : NOP : NOP : NOP : NOP
	REP #$20
	LDA $4216
	
	STA $4204
	SEP #$20
	LDA #!TotalItems
	STA $4206					
	NOP : NOP : NOP : NOP : NOP : NOP : NOP		;Divide remainder by TotalItems
	REP #$20
	LDA $4214					;load value
	STA $18
	
;; ----CALCULATE HUNDREDTHS DECIMAL----
	
	LDA $4216
	;AND #$00FF
	SEP #$20
	STA $4202
	LDA #$0A
	STA $4203										;Multiply remainder by 10 before dividing it by total number of items
	NOP : NOP : NOP : NOP : NOP : NOP : NOP
	REP #$20
	LDA $4216
	
	STA $4204
	SEP #$20
	LDA #!TotalItems
	STA $4206					
	NOP : NOP : NOP : NOP : NOP : NOP : NOP		;Divide remainder by TotalItems
	REP #$20
	LDA $4214					;load value
	STA $10
	
	PLY
	PLX
	PLA
	PLP
	RTL

!free89 #= pc()