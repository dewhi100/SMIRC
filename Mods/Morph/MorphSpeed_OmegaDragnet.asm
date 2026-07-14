;--------------Morph Speed------------------
;-------------OmegaDragnet9-----------------
;---Based off the hex tweak by Kejardon-----

;Allows you to run in morph ball form, but this time not limited to
;having Springball equipped.

;The original hex tweak cleverly allowed the movement type 
;to branch based off not just running type 01, but Springball On Ground 11 as well
;by causing the routine to branch anytime Byte $01 was used.
;This version takes that concept but adds several checks.

;I could save space by keeping the AND #$000F from Kejardon's tweak
;but I am uncertain as to what that would do to movement type 14, walljumping.

lorom

org $908558
BRANCH1:

org $90977F
BRANCH2:

org $90854A
JMP FREESPACE1

org $909771
JMP FREESPACE2

org !free90

FREESPACE1:

LDA $0A1F  
AND #$00FF             
CMP #$0001             ;Movement Type Running
BEQ JUMP1   
CMP #$0011			   ;Movement Type Springball on Ground
BEQ JUMP1
CMP #$0004			   ;Movement Type Morphball
BEQ JUMP1
JMP $85DA  

JUMP1:
JMP BRANCH1

FREESPACE2:

LDA $0A1F  
AND #$00FF             
CMP #$0001             ;Movement Type Running
BEQ JUMP2    
CMP #$0011			   ;Movement Type Springball on Ground
BEQ JUMP2
CMP #$0004			   ;Movement Type Morphball
BEQ JUMP2
JMP $9808  

JUMP2:
JMP BRANCH2

!free90 #= pc()