lorom

!missiledmg = #$0064;default dmg of a missile

org $AAD693;swap around the conditions (dodge supers missiles, grab missiles)
CMP #$0200
BEQ $39
CMP #$0100
BEQ $5A

org $86B31A+$8;change damage to missile
DW !missiledmg|$A000

org $8D8E6B;change spritemaps to use missile gfx
DW $0002, $0000 : DB $FC : DW $2A55, $01F8 : DB $FC : DW $2A54
DW $0003, $0003 : DB $FF : DW $2A58, $01FB : DB $FF : DW $2A57, $01FB : DB $F7 : DW $2A56
DW $0002, $01FC : DB $00 : DW $2A5A, $01FC : DB $F8 : DW $2A59
DW $0003, $01F5 : DB $FF : DW $6A58, $01FD : DB $FF : DW $6A57, $01FD : DB $F7 : DW $6A56
DW $0002, $01F8 : DB $FC : DW $6A55, $0000 : DB $FC : DW $6A54 
DW $0003, $01F5 : DB $F9 : DW $EA58, $01FD : DB $F9 : DW $EA57, $01FD : DB $01 : DW $EA56
DW $0002, $01FC : DB $F8 : DW $AA5A, $01FC : DB $00 : DW $AA59 
DW $0003, $0003 : DB $F9 : DW $AA58, $01FB : DB $F9 : DW $AA57, $01FB : DB $01 : DW $AA56

org $86B2EF;change explosion to missile explosion
DW $8298 : DB $0C,$0C ; X radius = 0Ch, Y radius = 0Ch
DW $816A       ; Clear pre-instruction
DW $8230,$5000  ; Enemy projectile properties |= 5000h
DW $823C,$5FFF  ; Enemy projectile properties &= 5FFFh
DW $8312 : DB $24    ; Queue sound 24h, sound library 2, max queued sounds allowed = 6 (small explosion)
DW $0004,$B023
DW $0004,$B02A
DW $0004,$B040
DW $0004,$B056
DW $0004,$B06C
DW $0004,$B082
DW $8154        ; Delete