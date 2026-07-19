lorom

;flipped bt statue, made by tundain

org $8D8DFB ; flipping the projectile's spritemap
DW $0001,$C208 : DB $F8 : DW $6EE0
DW $0001,$C208 : DB $F8 : DW $6EE2
DW $0001,$C208 : DB $F8 : DW $6EE4
DW $0001,$C208 : DB $F8 : DW $6EE6
DW $0001,$C208 : DB $F8 : DW $6EE8
DW $0001,$C208 : DB $F8 : DW $6EEA
DW $0001,$C208 : DB $F8 : DW $6EEC
DW $0001,$C208 : DB $F8 : DW $6EEE


org $86A77C ; flipping the x pos of every projectile
SBC $A7CB,x

org $849877 ; flipping the statue plm's tilemap
DW $0002,$8465,$8464
DB $FF,$00
DW $0001,$8466
DB $FF,$FF
DW $0002,$8446,$8445
DB $FF,$01
DW $0003,$8449,$8448,$8447
DW $0000

;here's something that might be usefull
org $AAC95F
DW $00DB ; bt's x position in the room
org $AAC963
DW $00B3 ; bt's y position
