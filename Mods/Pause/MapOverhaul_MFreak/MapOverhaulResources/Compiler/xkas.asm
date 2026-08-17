
;---------------------------------------------------------------------------------------------------
;|x|                                    XKAS                                                     |x|
;---------------------------------------------------------------------------------------------------
{
ORG $8292B0
PauseRoutineIndex:
	DW $9120, $9142, $9156, $91AB, $9231, $9186, $91D7, $9200	;same as $9110
	DW $9156, MapSwitchConstruct, $9200		;fade out / map construction / fade in


CheckForSelectPress:
	JSR $A5B7							;check for START press
	LDA $0998 : CMP #$000F : BNE +		;check if still in game state "paused"
	LDA $8F : BIT #$2000 : BEQ +		;check for SELECT press
	JSR NextAvailableAreaFinder : BCC +	;check if next area is valid to be loaded
	LDA #$0037 : JSL $809049			;play sound "move cursor"
	LDA #$0001 : STA $0723 : STA $0725	;set fading flag
	STZ $0751					;zero shoulder button pressed highlight
	LDA #$0016 : STA $0729		;set sprite timer
	LDA #$0008 : STA $0727		;set pause index to 8: show next area - fading out
+ : RTS


DrawSelectButtonSprite:
	LDA $0727 : CMP #$0008 : BNE +		;check if currently in "switch map area - fading out"
	LDA $0729 : BEQ +					;draw sprite timer zero?
	DEC $0729 : STZ $03
	LDY #$00D0 : LDX #$0070 : LDA #$000C : JSL $81891F	;draw sprite; [A] = sprite index; [X] = sprite X position; [Y] = sprite Y position
+ : JSL $82BB30 : RTS					;draw map elevator destination

WARNPC $829324



ORG $829446
LoadSourceMapData:
	PHB : PHK : PLB
	LDA $079F : ASL : CLC : ADC $079F : TAX
	LDA.w !MapDataTablePointer,x : STA $00 : LDA.w !MapDataTablePointer+2,x : STA $02
	PLB : RTL
}
