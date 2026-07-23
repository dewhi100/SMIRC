lorom

;IMPORTANT NOTE: This expects there to be extra room for messagebox text.
;There is a minipatch at the bottom of this file to allow more messageboxes. If you have another messagebox expansion patch, the bottom of
;this file should be deleted/commented out. If another patch is used, the 'Messagebox data' section should be moved to where the other
;messagebox expansion patch expects it.

incsrc SparkBounceCustomizeOptions.asm



org $840000+!SparkbounceItem
PLMHeaderSparkBounce:
	DW $EE64, PLMInstructionsSparkBounce ;Default set up shootable item block (EE64)
PLMInstructionsSparkBounce:
	DW $8764 : DW !SparkbounceGraphic : DB $00,$00,$00,$00,$00,$00,$00,$00
	DW $887C : DW $DFA9 ;If already collected, go to common remove-block-kill-PLM code.
	DW $8A2E : DW $DFAF ;Set up shot detection and animate until interrupted.
	DW $8A2E : DW $DFC7 ;Animate opening the block.
	DW $8A24 : DW PickupTriggerSparkBounce ;Set Samus detection / pickup trigger
	DW $8724 : DW $E569	;Using Charge beam's instructions to animate the pickup until interrupted.
PickupTriggerSparkBounce:
	DW $8899 ;Mark this item as collected so 887C skips it in the future.
	DW $8BDD : DB $02 ;Pickup sound.
	DW $88F3 : DW !SparkbounceEquipmentSlot : DB !SparkbounceMessageIndex	;Message box
	DW $8724 : DW $DFA9 ;go to common remove-block-kill-PLM code.
;print "Sparkbounce PLM ends before ",pc


;Messagebox data
org !Bank85FreeSpace  ;This is not the address to use unless you use the expand-message box patch at the bottom of this file.
;If you have a different messagebox patch, you will probably want to copy the below 5 lines to the messagebox patch instead, somewhere in bank 85.
;SparkBounceMessageBox does not need to be immediately after the first line, but it should be somewhere in bank 85 still.
	DW $8436 : DW $8289 : DW SparkBounceMessageBox
SparkBounceMessageBox:
	DW $000E, $000E, $000E, $000E, $000E, $000E ;Empty tiles left of message
	DW $284E, $284E, $284E, $28F2, $28EF, $28E0, $28F1, $28EA, $284E, $28E1, $28EE, $28F4, $28ED, $28E2, $28E4, $284E, $284E, $284E, $284E ;   SPARK BOUNCE    
	DW $000E, $000E, $000E, $000E, $000E, $000E, $000E ;Empty tiles right of message
;End of Messagebox data


;Everything below this line is for a simple expand-messagebox minipatch. Note that this is compiled to immediately after Messagebox data by default.
Fix1C1F:
	LDA $1C1F
	CMP #$001D
	BPL +
	RTS
+
	ADC #$027F
	RTS
FixSize:
	CMP #$9643
	BPL +
	LDA $86A5,X
	RTS
+
	PLA
	ADC #$0002
	PHA
	LDA #$0040
	RTS

org $858243
	JSR Fix1C1F
org $8582E5
	JSR Fix1C1F
org $8582F6
	JSR FixSize