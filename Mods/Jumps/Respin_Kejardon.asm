LoROM

;Respin has been developed multiple times by multiple people, but Kejardon's transition table has been foundational in developing them.
;This code has been passed through multiple hands, including Scyzer and PJ. I don't know who exactly came up with it.
;The routines at bank 90 freespace and $91FC99 are present as far back as the instance in Scyzer's tank.
;Scyzer's Tank: http://sadiztyk.metroidconstruction.com/patches.php

;This version lets you space jump when triggering respin (one button press), rather than making you trigger respin, and then space jump (two button presses)

org !free90
	handle_spinjump:
	LDA $09A2 				;Equipped items
	BIT #$0200				;Space Jump
	BNE ++
	LDA $0A23				;previous movement type (one byte)
	AND #$00FF
	CMP #$0002 : BEQ +		;normal jumping
	CMP #$0003 : BEQ +		;spinjumping
	CMP #$0006 : BEQ +		;falling
	CMP #$000E : BEQ +++	;turning, on ground
	CMP #$0014 : BEQ +		;wall jumping	
	++
	LDA $0A1C				;samus pose
	EOR $0A20				;old pose
	BIT #$0001				;did pose change due to turning around
	BNE +
	+++
	JSL $9098BC				;make samus jump
	+
	RTL

!free90 #= pc()

org $91FC99			;note: this frees up a small space in bank 91.
	JSL handle_spinjump
	RTS

;Reminder: transition table entries are formatted as
;DW newly pressed inputs, held inputs, pose to transition to
if !SparkBounce_Kejardon == 0 && !SamusMasterDisassembly_Crashtour99 == 0
	org !transitionTable91
	incsrc "../SamusGfx/TransitionTable_Kejardon.asm"
	warnpc !transitionTableEnd
	!transitionTable91 #= pc()
endif