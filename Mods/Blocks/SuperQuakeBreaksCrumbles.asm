lorom

;manualy break crumbles in a room when supers impact anything. uses room ASM and hardcoded coords

org $8FE99B
LDA $0C18 :  BIT #$0800 : BEQ +
JSL $8483D7
DB $1D : DB $03 : DW $d054
+
RTS
