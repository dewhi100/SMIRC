lorom

;Downsparking, grants samus the ability to perform shinsparks downwards, vertically and diagonally, made by Tundain
;credit please!

;Thx to Scyzer for a collision fix
;and Smiley for how to flip the samus sprite

;To spark downwards, hold (angle) down when performing a regular shinespark, and it'll be downwards instead.
;(Disclaimer: the timing is pretty finnicky)

;12/4/2025 (DMY): fixed controls, now they're more intuitive, also improved general behavior

;!Bank81Freespace = $81F198;large size
;!Bank90Freespace = $90FD00;medium size
;!Bank94FreeSpace = $94B1A0;small size 


org $92808D
SamusSpritesTable:



;-Bank $90---------------
;hijacks
org $90D29F
JSR checkreversed : NOP

org $90D280
JSR setdirection : NOP

org !free90	;!Bank90Freespace
checkreversed:;inverts the shinespark speed
LDA $0B36 : CMP #$0002 : BNE +
LDA #$0003 : STA $0B02
LDA $12 : EOR #$FFFF : STA $12;flip speed
LDA $14 : EOR #$FFFF : INC : STA $14 : BNE +
INC $12
+
JSL $949763
RTS

setdirection:;sets the correct collision direction while shinesparking down
LDA $0B36 : CMP #$0002 : BNE +
LDA #$0003 : STA $0B02
+
JSL $A0A8F0
RTS

!free90 #= pc()

org $90D30C
NOP #3;remove setting her y direction to 0 (this allows the correct spritemap to be drawn whilst samus is in "shinespark crash" state


;bank $90-----------
;handling pose setup
org $91F55F
JMP alsodown

org $9181A1
JSR extra : RTS

org !unused91;replace unused code
;this code sets allows enrering the shinespark windup state even if you're golding angle down when jumping
alsodown:
CMP #$006B : BEQ +
CMP #$006C : BEQ ++
CMP #$0059 : BEQ +
CMP #$005A : BEQ ++
CMP #$0069 : JMP $F562
+
JMP $F564
++
JMP $F571

;some extra code attached to the input handler when shinesparking
;this is a bit ugly, but it's easier than including the entire transition table in this patch
extra:
JSR $81A9
JSL extra_long
RTS

warnpc !unused91End
!unused91 #= pc()

org !freeB8
extra_long:
LDA $0A1C;are you in the windup state?
CMP #$00C7 : BEQ +
CMP #$00C8 : BEQ ++
RTL
+
LDA $8B : BIT $09BC : BEQ +;facing right + angle down = diagonal downspark down
LDA #$00CD : BRA +++
RTL
+
LDA $8B : BIT $09BE : BNE +;if not holding angle up, and do holding down, then spark down facing right
BIT $09AC : BEQ +
LDA #$00CB : BRA +++
+
RTL
++
LDA $8B : BIT $09BC : BEQ +;facing left + angle down = diagonal downspark down
LDA #$00CE : BRA +++
+
LDA $8B : BIT $09BE : BNE +;if not holding angle up, and do holding down, then spark down facing left
BIT $09AC : BEQ +
LDA #$00CC : BRA +++
+
RTL
+++
STA $0A28
LDA #$0002 : STA $0B36
RTL

!freeB8 #= pc()



;Bank $81--------------------------
org $8189AE;changing the samus spritemap drawing routine to flip samus if it's a downwards vertical shinespark
AddSamusSpritemap:
PHB
PEA $9200 : PLB : PLB        
STY $12    
STX $14    
ASL : TAX  
LDY.w SamusSpritesTable,x : LDA $0000,y : BEQ .Return   
STA $18 : INY #2       
LDX $0590
CLC

.Loop:
LDA $0000,y : ADC $14 : STA $0370,x
AND #$0100 : BEQ .X_high_clear    
LDA $0000,y : BPL +    
LDA $81859F,x : STA $16 : LDA ($16) : ORA $8185A1,x : STA ($16) 
BRA .Merge 
+          
LDA $81859F,x : STA $16 : LDA ($16) : ORA $81839F,x : STA ($16)  
BRA .Merge  
           
.X_high_clear: 
LDA $0000,y : BPL .Merge
LDA $81859F,x : STA $16 : LDA ($16) : ORA $8183A1,x : STA ($16)  

.Merge 
JSR checkflip;hijack which sets the y pos and properties
TYA : CLC : ADC #$0005 : TAY 
TXA : ADC #$0004 : AND #$01FF : TAX        
DEC $18 : BNE .Loop    
STX $0590  
.Return:
PLB : RTL

org !free81	;!Bank81Freespace
checkflip:
LDA $0B36 : CMP #$0002 : BNE +  ;make sure it's down
LDA $0A1C : AND #$00FF;make sure it's a vertical shinespark
CMP #$00CB : BEQ doflip
CMP #$00CC : BEQ doflip
+
LDA $0002,y : CLC : ADC $12 : STA $0371,x : LDA $0003,y : STA $0372,x;set ypos and properties normally
RTS
doflip:
LDA $0000,y : BMI +;the small tiles need a different offset
LDA #$0000 : BRA ++
+
LDA #$00F8
++
STA $00
LDA #$00F8 : SEC : SBC $0002,y : CLC : ADC $00;flip position
CLC : ADC $12 : STA $0371,x
LDA $0003,y : EOR #$8000 : STA $0372,x;flip gfx
RTS

!free81 #= pc()

org $948FBB : JSR SparkCheck;thx to scyzer for this, this fixes an issue with diagonal sparks

org !free94	;!Bank94FreeSpace ;if sparking downward and hitting a slope horizontally, stop shinesparking (otherwise you softlock in slopes)
SparkCheck:
    LDA $0A6E : CMP #$0002 : BNE +
    LDA $0B36 : CMP #$0002 : BEQ ++
    +    LDX $0DC4 : RTS
    ++    PLA : SEC : RTS

!free94 #= pc()