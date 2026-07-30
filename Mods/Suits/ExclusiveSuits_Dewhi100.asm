LoROM

;Meant to be used with further changes to suits, since normally gravity suit does everything the varia suit does.
;not included: item pickup logic to turn off whatever suit yo

!variaTilemap = $C076
!gravityTilemap = $C078

!suit1 = $0001	;varia suit
!suit2 = $0020	;gravity suit

org $82B0CD
JSR toggle_suits	;was JSR $B568 (normal button handling)

org !free82
toggle_suits:
LDA $09A2									;item flags
STA $24										;the plasma-spazer check uses this RAM. probably it is just as safe to use for this.
JSR $B568									;handle button press (item turns on/off)
LDA $09A2 : EOR $24							;was any item toggled?
BEQ ++										;if not, skip everything else
AND $09A2									;if item was turned on, A = item bit. if item was turned off, A = 0
BIT #!suit1 : BEQ +							;check the suit1 bit
LDA $09A2 : AND #$FFFF^!suit2 : STA $09A2	;if set, turn off suit2
LDA !gravityTilemap : STA $00				;prepare to toggle palette
BRA +++
+
BIT #!suit2 : BEQ ++						;check the suit2 bit
LDA $09A2 : AND #$FFFF^!suit1 : STA $09A2	;if set, turn off suit1
LDA !variaTilemap : STA $00					;prepare to toggle palette
+++
LDA #$0C00									;palette ("disabled" colors)
STA $12										;
LDA #$0012									;how many tiles to set the palette on (well, times 2. meaning $12 is actually 9 tiles)
STA $16										;
JSR $A29D									;set palette to [$12] for [$16] tiles at tilemap offset [$00]
++
RTS