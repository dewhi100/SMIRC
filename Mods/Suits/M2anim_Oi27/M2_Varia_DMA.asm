;M2_Varia
;----------------
;Saving xkas output with command line:
;xkas Code.asm ROM.smc > output.txt 

;To use: put enemy $F7D3 somewhere offscreen in the same room as the Varia pickup.
;Make sure it's first in the enemies allowed list and is enemy $00 in the room.

;!GFXbankS = $B8
!GFXbankS = !freeB8/$10000
!GFXbank = !freeB8/$100
!GFXaddress = !freeB8%$8000+$8000
;!GFXaddress = $8000
;!GFXaddrFULL = !GFXbank*$100+!GFXaddress

;print hex(!GFXbankS)
;print hex(!GFXbank)
;print hex(!GFXaddress)

!animSpeed = $0004
!soundFX = #$0028	;28 is wave SBA
;!GFXaddrFULL = $B88000
;!GFXbank = $B800



!WRAMa = $7E9000	;WRAM to put tiles. $9000 is also used by dust enemies.
!D0Index = $0FAA	;Pointer to the instruction list we're using on the D0 Table
!TileLine = $0FAC	;Counter for how many times to loop STZ in WRAM
!GFXpoint = $0FAE	;Index for current 4-tile GFX offset being sent to WRAM
!D0tilecount = $0FB0;index into table that points to DMA instruction entries; specifies how many tiles to xfer WRAM -> VRAM
!outputFlags = $0FB2; AABB; BB used by main AI to reset time; AA set when animation is done.
!GFXsize = $0220

lorom
;varia inst are at $E2A1
org $84E2C3 ;Hijack Varia Instruction List. Has some free space after this.
DW $8724, NEW_INST

;Varia - Chozo Orb
org $84E720
DW $8724, NEW_INST

org !free84 ;$84EFD3	;Free space $84
NEW_INST:
DW SUMMON_ENEMY
if !InstantPickups_Oi27 == 0
DW $8BDD : DB $02                            ; Clear music queue and queue item fanfare music track
endif
DW $E29D                               ; Clear charge beam counter
;DW $88F3, $0001 : DB $07                       ; Pick up equipment 1 and display message box 7
;^Picking up the equip is what turns Samus orange
;^Have the enemy give the equip, unlock Samus
DW MESSAGEBOX
DW $870B : DL $91D4E4                        ; Call function $91:D4E4
DW $8724, $DFA9                          ; Go to $DFA9

SUMMON_ENEMY:
;spawning it didn't work.... how about just bring it from offscreen?
;Must be enemy $00
;Snap Samus to PLM block first
;;;;print pc, " - SUMMON ENEMY"
PHX : PHY
JSL $848290 ;Calc PLM coords, adjust Samus Position to item.
LDA $1C29 : ASL : ASL : ASL : ASL : CLC : ADC #$0008 : STA $0AF6 : STA $0F7A
LDA $1C2B : ASL : ASL : ASL : ASL : SEC : SBC #$0005 : STA $0AFA : STA $0F7E
PLY : PLX
RTS
MESSAGEBOX:
LDA #$0168 : JSL $82E118	;play room music after 6 seconds
LDA #$0007 : JSL $858080	;Display Varia message box
RTS

!free84 #= pc()

org $91D4E4
;;; $D4E4: Varia suit pick up ;;;
;Overwrites vanilla Varia routine.
PHP
PHB
PHK
PLB
SEP #$30
LDA #$30
STA $0DF0  
LDA #$50
STA $0DF1  
LDA #$80
STA $0DF2  
STZ $0DF3  
REP #$30
JSL $91DE53  ; Cancel speed boosting
STZ $0B42    ;\
STZ $0B44    ;} Samus X extra run speed = 0.0
STZ $0B46    ;\
STZ $0B48    ;} Samus X base speed = 0.0
STZ $0B2C    ;\
STZ $0B2E    ;} Samus Y speed = 0.0
STZ $0B36    ; Samus Y direction = none
STZ $0B20  
STZ $0B4A    ; Samus X acceleration mode = accelerating
STZ $0E18  
STZ $0DEC  
STZ $0DEE  
LDA #$0100
STA $0DDC  
LDX #$01FE
LDA #$00FF

STA $7E9800,x
DEX
DEX
BPL $F8    
LDA $0A1F	;samus movement type  
AND #$00FF
CMP #$0003	;spinjumping
BEQ $05    
CMP #$0014	;walljumping??
BNE $07    

LDA #$0032   ;\
JSL $80902B  ;} Queue sound 32h, sound library 1, max queued sounds allowed = 9 (spin jump end)
  
LDA #$0000
STA $0A1C  

JSL $91F433 ;Update Samus Palette
JSL $91FB08  ; Set Samus animation frame if pose changed. 
;LDA #$0015	;LDA $15 here is what cause the Death graphic handler to be set in $0A5C
;JSL $90F084
JSL $91E3F6	;make samus face forward
PLB
PLP
RTL


org !freeA0 ;$A0F7D3 ;Enemy header
print "M2 Varia Enemy: ", pc
;          Palette         Damage       Y Radius      Hurt AI Time  Boss Value             Number of parts  Main AI              Hurt AI        Xray AI      Unused         PB AI        Unused       Touch AI      Unused             Layer Priority    Weakness Pointer
;GFX Size    |       Health  |   X Radius  |       AI Bank |     Hurt SFX  |  Setup AI           |   Unused    |         Grapple AI |  Frozen AI  | Death Anim. |   Unused    |   Unknown   |   Unused    |   Shot AI   |  GFX Address          | Drops Pointer |   Name Pointer
;  |         |        |      |      |      |          |    |        |      |      |              |      |      |             |      |      |      |      |      |      |      |      |      |      |      |      |      |          |            |        |      |      |
DW !GFXsize, VAR_PAL, $0300, $0038, $0008, $0010 : DB $A3, $00 : DW $005B, $0000, VARIA_setupai, $0001, $0000, VARIA_mainai, $804C, $804C, $804C, $0000, $0004, $0000, $0000, $804C, $0000, $0000, $0000, $804C, $804C, $0000 : DL VAR_GFX : DB $00 : DW $8B69, $E233, $8A1F

!freeA0 #= pc()

org !freeA3 ;$A3F1AB	;"freespace" overwriting "unused" metroid electricity... huh. anyway, its the last data before freespace so it can bleed right into it. ;Freespace in AI bank
VARIA:
.setupai
LDX $0E54
LDA.w #.anim1 : STA $0F92,x
;This doesn't work on Quickmet because the setup runs before Samus loads 100%...
;Shouldn't be an issue on spawning it into the room.
;LDA $0AF6 : DEC A : DEC A : DEC A : STA $0F7A,x
;LDA $0AFA : DEC A : STA $0F7E,x
RTL
.mainai
LDA !outputFlags : AND #$00FF : BEQ +
	LDA #$0001 : STA $0F94 : STZ !outputFlags : RTL
+
LDA !outputFlags : AND #$FF00 : BEQ +	;If finished animating, then store enemy offscreen and unlock Samus.
STZ !outputFlags
LDA #.anim2 : STA $0F92	;Set instruction list to finish
+						
RTL

;Varia Suit Animation Instruction List
.anim1
DW $0020, $804D	;Draw nothing for some frames
DW .dmaSetup
.animloop
DW !animSpeed, .s48
DW .dmaAnimate	;Integrate the playsound with this function
DW $80ED, .animloop	;loop
;Exit loop with main AI when fully animated.


;print pc, " - anim2"
.anim2	;Linger for some frames, then unlock Samus. Delete enemy.
DW $0040, .s48	
DW .giveEquip
DW $807C	

.giveEquip
PHX : PHY
LDA #$E695 : STA $0A42	;\-Unlock Samus.
LDA #$E725 : STA $0A44	;|
LDA $09A4 : ORA #$0001 : STA $09A4	;Collect Item
LDA $09A2 : ORA #$0001 : AND #$FFDF : STA $09A2	;Equip Var, unequip Grav.
LDA #$009B : STA $0A1C : JSL $91FB08;Varia Elevator pose
LDA $0A1E : AND #$00FF : STA $0A1E
JSL $91DEBA	;update palette
PLY : PLX
RTL

;print pc, " - spritemap start"
.s48	;spritemap
DW $0014
DB $F3,$01,$0C,$00,$21
DB $FB,$01,$0C,$01,$21
DB $04,$00,$0C,$00,$61
DB $FC,$01,$0C,$01,$61
DB $F3,$01,$FD,$03,$21
DB $FB,$01,$FD,$04,$21
DB $03,$00,$FD,$05,$21
DB $FB,$01,$F5,$07,$21
DB $F3,$01,$F5,$06,$21
DB $03,$00,$F5,$08,$21
DB $F3,$01,$ED,$09,$21
DB $FB,$01,$ED,$0A,$21
DB $03,$00,$ED,$0B,$21
DB $03,$00,$E5,$0F,$21
DB $0B,$00,$ED,$0C,$21
DB $FB,$01,$E5,$0E,$21
DB $F3,$01,$E5,$0D,$21
DB $0B,$00,$E5,$10,$21
DB $F7,$01,$05,$02,$21
DB $00,$00,$05,$02,$61

.dmaSetup			;^Initialize to graphic address so we can count from there.
					;^it's the currently-working-on row, starting from the bottom, times 2.
;Give $0FAA the intial point of the table to start animating from
;Also 00 out the enemy graphics
PHX : PHY
;Using the D0 table is needed here because a regular DMA will not update tiles shared between VRAM and ??? another location.
LDY $0330
LDA #!GFXbank : STA $00D3,y	;|-Actually! Take these 00's from $87:AA04 instead.
LDA #(!GFXaddress+!GFXsize) : STA $00D2,y	;/Or have them fill in from one byte.
LDA #$7000 : STA $00D5,y	;After the bitplanes are taken care of.
LDA #!GFXsize : STA $00D0,y
TYA			;Y is still the VRAM stack pointer, transfer to A
CLC			
ADC #$0007	;\
TAY			;|
STY $0330  	;overwrite VRAM stack pointer to account for new table size
LDA #$0000	;
STA $00D0,y	;Place the 0000 table terminator at the end of our entries

LDA #DMAINSTRUCTION : STA !D0Index 
STZ !D0tilecount
LDA #!GFXaddress : STA !GFXpoint	;set this up so we can add to it later on.
LDA #$0007 : STA !TileLine
LDA #$0028 : JSL $809021	;Lib 1 sound, #$0028 Wave SBA is current winner
PLY : PLX
RTL
;;print pc, " - DMA-Animate"
.dmaAnimate
;We'll be DMAing, at most, 4 8x8's at a time. #$0080 bytes.
;Can xfer to wram, modify, and put in VRAM all in one routine since code pauses while DMA happens.
;First, arrange what tiles to xfer
PHX : PHY
LDA !D0tilecount : CMP #$000C : BMI +	;Stop when the animation finishes.
LDA #$8000 : STA !outputFlags								;Could put a flag here so we know when it's done.
PLY : PLX
RTL	;stop this routine when it reaches the end of the table.
+
.dma2wram
PHP						;\
SEP #$20				;|8-bit [A] with 16-bit [X] [Y]
LDX !GFXpoint : STX $4302;|
LDA #!GFXbankS : STA $4304	;|one-byte bank number.
LDX #$0080 : STX $4305  ;|
LDX #!WRAMa : STX $2181  ;|-DMA TRANSFER TO WRAM
LDA #$7E : STA $2183    ;| USING CHANNEL 0
LDA #$80 : STA $4301    ;|
STZ $4300               ;|
LDA #$01 : STA $420B    ;|
PLP						;/

;if the 8th row of the tile isn't getting drawn, that means this loop is overwriting it every time
;each line is 2 bytes starting at !WRAMa...
;It's indexed by !TileLine*2...
;Y - X
;8 - $10 - It overwrites the start of the next tile.
;7 - $0E - It edits the final row of the tile.
;6 - $0C - Next row up
;...
;1 - $02 - Edits second row
;0 - $00 - Edits the first row
;FFFF - FFFE - Would break the game to STZ this index. Special exception to show full tile, reset.
;;print pc, " - Deletion Loop"
LDY !TileLine : CPY #$FFFF : BEQ +
TYA : ASL : TAX
LDA #$0000
-
STA !WRAMa,x : STA !WRAMa+$10,x	;!wram and !wram+$10, STZ first tile
STA !WRAMa+$20,x : STA !WRAMa+$30,x
STA !WRAMa+$40,x : STA !WRAMa+$50,x
STA !WRAMa+$60,x : STA !WRAMa+$70,x
DEX : DEX
DEY
CPY #$FFFF : BNE -	;Has to be FFFF to hit !WRAMa,0

DEC !TileLine ;DEC this for the next time the routine is called
BRA NEWTILESKIP	;skip over the next set of opcodes
+
LDA #$0007 : STA !TileLine	;why do the rest of the graphics pop in after it gets here?
;PLY : PLX
;RTL	;skip the rest of the things. Fixed the issue where it flashes the wrong gfx.
;So, for the complete graphics to pop in, the routine has to be getting this far 
;after it finishes a row on reset.
;This happens on the frame that TileLine is reduced to 0?
;Actually, this doesn't matter because it's only noticible if the graphics didn't come in all the way.
;Okay, so why are the top two rows of each tile not drawing in?
NEWTILESKIP:
LDX !D0Index
LDY $0330  	;VRAM write table stack pointer
LDA #$7E00	
STA $00D3,y	;DMA Source $A300, entry 1. Bank $A3. This works because $D0,x+2 will be read nn NN BB for address $BBNNnn
STA $00DA,y	;DMA Source $A300, entry 2
STA $00E1,y	;entry 3
STA $00E8,y	;entry 4. If unused, these extra ones don't break anything.
;ENTRY-1---------
;;print pc
-
LDA $0000,x	;Load the first pointer in the instruction list
BEQ INST_TERMINATED
STA $00D2,y	;DMA Source address of tiles in $B0, first tile to update.
LDA DMADEST-DMAINSTRUCTION,x	;VRAM destination pointer
STA $00D5,y	;/Enemy $00 begins at 7000
LDA #$0020	;Size is one 8x8 tile, $20 bytes.
STA $00D0,y	;|
TYA : CLC : ADC #$0007 : TAY	;Y is still the VRAM stack pointer, transfer to A and expand D0 table.
INX : INX
BRA -
INST_TERMINATED:
STY $0330  	;overwrite VRAM stack pointer to account for new table size
LDA #$0000	;
STA $00D0,y	;Place the 0000 table terminator at the end of our entries
;TXA			;X is still the pointer to the instruction list in $A6, transfer to A
;CLC
;ADC #$0004		;Add 6 because that's how big the instruction list is wide
;STA !D0Index	;This increase in the instruction list is handled when it starts to draw a new tile.
LDA !TileLine : CMP #$0007 : BNE +
INC !D0tilecount : INC !D0tilecount	;small numbers; index into table for how many tiles in each row of 8x8
LDX !D0tilecount
LDA DMAINSTRUCTION_tilecount,x : STA !D0Index
LDA !GFXpoint : CLC : ADC DMAINSTRUCTION_gfxinc,x : STA !GFXpoint
INC !outputFlags
CPX #$000C : BPL +
LDA !soundFX : JSL $809021
+
PLY : PLX
RTL	



;;;print pc, " - Inst1"
;How many tiles get transfered to every row of 8x8?
;Howww to handle that tile at the end that isn't aligned with the rest?

;We'll have each entry in the current DMAinstrucion list read into the D0 table until it encounters a $0000
DMAINSTRUCTION:
.r1
dw !WRAMa, !WRAMa+$20, $0000	;Tile number times $20 byte/tile. Source Addresses.
.r2
dw !WRAMa, $0000
.r3
dw !WRAMa, !WRAMa+$20, !WRAMa+$40, $0000
.r4
dw !WRAMa, !WRAMa+$20, !WRAMa+$40, $0000
.r5
dw !WRAMa, !WRAMa+$20, !WRAMa+$40, !WRAMa+$60, $0000
.r6
dw !WRAMa, !WRAMa+$20, !WRAMa+$40, !WRAMa+$60, $0000

.tilecount
dw .r1, .r2, .r3, .r4, .r5, .r6
.gfxinc
dw $0000, $0040, $0020, $0060, $0060, $0080, $0080	;this last entry won't get used? nothing will happen after we get to r6.
DMADEST:	;These destinations arrange the graphics in VRAM
dw $7000, $7010, $0000;The same way they're laid out in the preview window.
dw $7020, $0000				;Has to have $0000 terminators in it too so it mirrors the source table.
dw $7030, $7040, $7050, $0000
dw $7060, $7070, $7080, $0000
dw $7090, $70A0, $70B0, $70C0, $0000
dw $70D0, $70E0, $70F0, $7100, $0000


dw #$0000



;print pc, " - Palette"
VAR_PAL:
incbin var_pal.bin

!freeA3 #= pc()

org !freeB8	;Graphic Location
;This can be moved now that it's smaller!
;Includes the graphics as well as $200 continuous bytes of $00 to make DMA easier.
;00's end up at $B0EA00
;print pc, " - Graphics"
VAR_GFX:
incbin !M2Anim_GFX_Path
;incbin varia_DMA_final.bin
;;;;;print pc, " - Graphics End"

!freeB8 #= pc()