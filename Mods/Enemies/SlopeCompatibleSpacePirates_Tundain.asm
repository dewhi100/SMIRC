lorom
;Slope-compatible space pirates
;this simple patch will make space pirates walk up and down slopes, made by Tundain

;Important: with this change, pirates will walk off any edge, so make sure you set the distance parameter correctly
;(unless you want your pirate to walk off a ledge, of course)

;!BankB2Freespace = $B2FEB0;find $08 bytes in bank $B2,should be easy

;------Moving right-----------
org $B2FE09; delete stupid horizontal re-alignment
NOP : NOP : NOP

org $B2FE23
NOP : NOP; no more turning around when encountering air at an edge
LDA #$3800
STA $12
LDA #$0000
STA $14
JSL $A0C6A4;use slope-processing movement routie
BCS $08
JSR slope;go to realignment routine

;----Moving left---------
;(same thing everywhere)
org $B2FD7F
NOP : NOP : NOP

org $B2FD99
NOP : NOP

org $B2FDB3
JSL $A0C6A4
BCS $08
JSR slope

org !freeB2;realign pirate
slope:
  JSL $A0C8AD
  LDA $0F7A,x
  RTS

!freeB2 #= pc()