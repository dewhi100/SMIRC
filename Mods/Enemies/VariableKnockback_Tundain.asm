lorom

;variable knockback time, by Tundain
;use the unused paramter 16h in each enemy header to determine how long samus gets knocked back when hurt
;with SMART, it's Unused_1 that you want to change
;keep in mind that as long as samus gets knocked back, she can backflip
;have fun


org $A0A562
LDY $0E54;micro-optimization here to save one byte of space for the LDA
LDX $0F78,y
LDA $A00006,x
JSL $A0A45E
JSL $91DF51
LDA #$0060
STA $18A8
LDA $A00016,x; now we have one extra byte of space, we can squeeze in a long LDA 
STA $18AA

