lorom

;Credit: Nodever2, Oi27, Omegadragnet, Scyzer

; ASM to keep running speed while landing. This is more effective than simply changing the pose table,
; as you can have variables, and doesn't move you forward a pixel.

; By default, this patch only lets you speedkeep if you have speed booster equipped, are holding run,
; and are spin jumping. It is very easy to configure this patch to change all three of those things though.
; Please read the further comments for instructions.

;  Update 5-14-2022 by Nodever2 (rev1): Fix issue where if you use scyzer's suggested method of speedkeep with spin
;  jump, samus becomes much slipperier when turning around on the groung while running.
;  fixed by checking samus' last movement type instead and removing the BRA entirely.
;  I also changed the hijack point slightly, and fixed an issue with all speedkeep patches where
;  samus' palette is sometimes wrong for a couple frames when landing from screw attacking and speed boosting with speedkeep.

;  Update 6-26-2023 by OmegaDragnet7 (rev2): Fix a glitch where Samus becomes stuck midair when grappling a grappleable enemy.

;	update 7-28-2026 by oi
;	-Add run repress requirement & run frame counter

;!90Free = $90F7A0

!frames_run_held = $0785 ;address of new timer
!const_landWindow = 5 ;frames Run can be repressed before landing.

org $90EACF : JSR SpeedKeep_RunHoldTimer ;hijack auto jump handler
org $90A3CA : JMP Landy ; hijack landing
SLOWDOWN: ; return point

org !free90	;!90Free ; $90F63A			; Repointable free space usage in $90
Landy:
{
	LDA $09A2 : AND #$2000 : BEQ SLOW ; If speed booster not equipped, goto SLOW
	LDA $8B : AND $09B6 : BEQ SLOW ; If run not held, goto SLOW
	LDA.w !frames_run_held : BEQ SLOW
	CMP.w #!const_landWindow : BPL SLOW
	;   Grapple Fix by OmegaDragnet7
	;      check list of poses & resets
	LDA $0A1C : AND #$00AA : BEQ SLOW : AND #$00AB : BEQ SLOW 
	AND #$00B6 : BEQ SLOW : AND #$00B7 : BEQ SLOW : AND #$00A9 : BEQ SLOW
	
	; if last movement was normal jump/falling/spinjump, speedkeep
	LDA $0A27 : AND #$00FF
	CMP #$0002 : BEQ SPEEDKEEP
	CMP #$0006 : BEQ SPEEDKEEP 
	CMP #$0003 : BEQ SPEEDKEEP
}
SLOW: ; reset X speed
	JSR $9348 ; code that was replaced by hijack
	JMP SLOWDOWN
SPEEDKEEP:
	LDA $0B40 : BEQ + 
		LDA #$0003 : JSL $80914D ; resume speed booster sfx if needed
	+
	; next two lines of code are mostly only needed because of a dumb vanilla bug with $91DA74
	LDA #$0001 : STA $0AD0 ; update samus palette next frame
	LDA #$0004 : STA $0ACE ; reset samus speed booster/screw attack palette index
	PLP : RTS

SpeedKeep_RunHoldTimer:
;count if held or previously held, else zero
{
	;[A] = $8B :: current input
	BIT $09B6 : BEQ .zero
	LDA $0DFE : BIT $09B6 : BEQ .zero
		INC.w !frames_run_held
		BRA .merge
	.zero
		STZ.w !frames_run_held
	.merge
	LDA $8B
	STA $0DFE ;hijack code :: update previously-held input
	RTS
}

!free90 #= pc()