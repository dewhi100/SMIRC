lorom
; The planet does't explode, by Tundain
;this patch will prevent the planet from blowing up when you leave it at the end of the game

; this version also adds some explosions on the surface of the planet before samus's ship appears (as to simulate that just the place you escaped blew up, not the entire planet)
;uses no freespace, but overwrites a lot of now unused code to place the new routines/instructions
;don't forget to credit!

org $8BDE28 ;when about to write message, delete stars first 
JSR deletesprites

if !AreaDoesExplode != 0
org $8BEEAD;change stars instruction list to diff one to make space
DW starinst
endif

org $8BD98D ; remove the spawning of now unused sprite objects
LDY #$EEA9 : JSR $938A; generate stars sprite object (will be spawned at index $001E, seems to only work with this index for ??? reason)
LDA #$0000 : STA $12
LDY #$EE9D : JSR $93A2; generate planet sprite object at index $0000 (that way it doesn't block out the text)
NOP #7 ; don't generate the planet's cracks and the outline


;----Instrcution list of planet
org $8BEB0F; 
DW $94D6,$0002 ; timer = 2
DW $000D,$A396
DW $000D,$A3AC
DW $000D,$A3C2
DW $000D,$A3D8
DW $94C3,$EB13; if timer is 0, stop looping
DW $F32B ; trigger ship appearance
here_NonExplosivePlanet:
DW $000D,$A396
DW $000D,$A3AC
DW $000D,$A3C2
DW $000D,$A3D8
DW $94BC,here_NonExplosivePlanet ; keep animating

if !AreaDoesExplode != 0
starinst: ; new location of stars inst list
DW $0010,$A28B
DW $94BC,starinst

instlist:; this gives us space to put the explosion inst list
DW $0003,smallexpl
DW $0003,mediumexpl
DW $0003,normal
DW spawnnext
DW $0003,big
DW $9438
endif

warnpc $8BEB69

org $8BF32B; don't set a bunch of palettes to white, instead just set the cinematic function, and set the timer
PHY
if !AreaDoesExplode != 0
LDA #$0004
LDY #explheader : JSR $938A
LDA #$0025 : JSL $8090B7
endif
LDA #$DB9E : STA $1F51
LDA #$0078 : STA $1A49
PLY : RTS
;frees up space for this routine
deletesprites:
LDX #$001E : STZ $1A5D,x : STZ $1B1D,x; clear stars sprite
LDY #$EEC7
RTS

warnpc $8BF35A

org $8BDBE1 ; shorten cinematic function to make space for extra routine (removed white flash effect and palette afterglow for ship and explosion)
STZ $58 : STZ $5D 
REP #$20
LDA #$0038 : STA $80
LDA #$0018 : STA $82
LDA #$FFB8 : STA $1993
LDA #$FF98 : STA $1997
LDA #$0C00 : STA $198F
LDA #$FF90 : STA $198D
LDA #$0001 : STA $1A49
LDA #$00C0 : STA $1A4B
STZ $1A4D
LDA #$DCA5 : STA $1F51
RTS
if !AreaDoesExplode != 0
spawnnext: ; instruction to spawn next explosion
LDA $1B9D : DEC : BMI +
LDY #explheader : JSR $938A
LDA #$0025 : JSL $8090A3
+
RTS	
explheader: ; definition of explosion sprite object
DW init_explosion,$93D9,instlist
endif
warnpc $8BDC4C

if !AreaDoesExplode != 0
org $8BF2B7 ; unused instruction that we overwrite
init_explosion: ; init code of explosion, sets up the correct x/y pos based of explosion index
LDA $1B9D : ASL #2 : TAX
LDA positions,x : STA $1A7D,y  ;xpos
LDA positions+2,x : STA $1A9D,y ; ypos
LDA #$0A00 : STA $1ABD,y ;set palette
RTS	
positions: ;positions, x, then y (goes from right to left when spawning explosions)
DW $007E,$007D,$0082,$007E,$007E,$0080,$0082,$0082,$0080,$0080
warnpc $8BF2FA

org $8CA5E2 ;explosion spritemaps, these overwrite the last "supernova spritemap"
smallexpl:
DW $0004
DB $F8,$01,$F8,$89,$30
DB $00,$00,$F8,$89,$70
DB $00,$00,$00,$89,$F0
DB $F8,$01,$00,$89,$B0
mediumexpl:
DW $0004
DB $F8,$01,$F8,$8A,$30
DB $00,$00,$F8,$8A,$70
DB $00,$00,$00,$8A,$F0
DB $F8,$01,$00,$8A,$B0
normal:
DW $0004
DB $F8,$01,$F8,$8B,$30
DB $00,$00,$F8,$8B,$70
DB $00,$00,$00,$8B,$F0
DB $F8,$01,$00,$8B,$B0
big:
DW $0004
DB $F8,$01,$F8,$8C,$30
DB $00,$00,$F8,$8C,$70
DB $00,$00,$00,$8C,$F0
DB $F8,$01,$00,$8C,$B0
endif