lorom

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; By PBase and Phospho, cleaned by Benox50
;;; Chain Sparking ;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Now SM can have the swag of GBA and Dread
;;;;;;;;;;;;;;;;;;;;;;;;;;; Hold direction on slopes while in shine to resume speed boosting
{
;HIJACKS
{
;;; Align Samus Y with non-square slope ;;;
org $9487F4
; ...
org $948884
	JSR ChainSpark
	STA $0DBA
; ...	
}



; FREE SPACE
{
org !free94		;$94B1F0
ChainSpark:
;Interestingly & Luckily really small and simple code for the amount of cool
;Check if currently ShineSpark right or left
	LDA $0A1C ;Current pose
	CMP #$00C9 : BEQ ChainSpark_R
	CMP #$00CA : BEQ ChainSpark_L
;Neither, Get out of here stalker
ChainSpark_Out:
	TDC : INC ;Put dis back
	RTS


;;; Shining right
ChainSpark_R:
	LDA $8B : BIT $09B0 : BNE + ;Pressed right?
	BRA ChainSpark_Out
+
	LDA #$0009 : STA $0A28 ;New pose to set
	BRA ChainSpark2


;;; Shining left
ChainSpark_L:	
	LDA $8B : BIT $09AE : BNE + ;Pressed left?
	BRA ChainSpark_Out
+
	LDA #$000A : STA $0A28 ;New pose to set


;;; Set some stuff to convert from shine to speed
ChainSpark2:
	LDA #$0009 : STA $0B42 ;PBase famous "slope speed" cause max run speed is actually 7
	TDC : INC : STA $0A1F ;Samus is running now
	STA $0A6E : STA $0B3C ;Set run is pressed + contact dmg to speed
	LDA #$0402 : STA $0B3E ;Set magic frames to full
	STZ $0B36 ;Samus is on ground
	LDA #$A337 : STA $0A58 ;Default samus gameplay state
	LDA #$E913 : STA $0A60 ;Default samus gameplay inputs
	RTS
}
}
!free94 #= pc()
