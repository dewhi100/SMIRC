lorom

;Event doors
;by dewhi100

;Think 'Fusion Doors'
;Gray, Blue, Green, Yellow, and Red doors react to event flags now, letting you simulate the security system in Fusion.
;If the event isn't set, they act like a gray door and ignore your shots. 

;red, yellow, green doors react to shooting with anything

;red doors open after 1 shot
!normalShot = $BD0F
org $84C01E	;yellow door left
dw !normalShot	
org $84C081	;yellow door right
dw !normalShot	
org $84C1A6	;green door left
dw !normalShot	
org $84C205	;green door right
dw !normalShot	
org $84C322	;red door left
dw !normalShot	
db $01		
org $84C384	;red door right
dw !normalShot	
db $01

;Grey doors don't flicker blue when unlocked
org $84BE8C
leftGrey:
dw $0001, $A6A7
dw $8724, leftGrey
org $84BEF5
rightGrey:
dw $0001, $A6D7
dw $8724, rightGrey
org $84BF5E 
upGrey:
dw $0001, $A707
dw $8724, upGrey
org $84BFC7
downGrey:
dw $0001, $A737
dw $8724, downGrey

;Doors don't flicker blue when locked and shot

;doors check for events
!blueEvent		= $20
!greenEvent 	= $21
!yellowEvent 	= $22
!redEvent		= $23
org $84C1AE	;green left
dw eventCheck
db !greenEvent
skip 2
dw $8724, $C1AC
org $84C20D	;green right
dw eventCheck
db !greenEvent
skip 2
dw $8724, $C20B
org $84C02A	;yellow left
dw eventCheck
db !yellowEvent
skip 2
dw $8724, $C024
org $84C08D	;yellow right
dw eventCheck
db !yellowEvent
skip 2
dw $8724, $C087
org $84C32A	;red left
dw eventCheck
db !redEvent
skip 2
dw $8724, $C328
org $84C38C	;red right
dw eventCheck
db !redEvent
skip 2
dw $8724, $C38A

;Make blue door caps
org $84F100	;freespace

dw $C7B1, leftMain, leftClose		;F100
dw $C7B1, rightMain, rightClose		;F106

;Blue door cap left
;Close door cap
leftClose:
dw $0002, $A677		;door frame only
dw $0002, $A9D7
dw $8C19 : db $08	;queue "door closed" sfx
dw $0002, $A9CB
dw $0002, $A9BF
dw $0001, $A9B3		;closed
;Main instructions:
leftMain:
dw $8A72, $C4B1		;??? they all do this
dw $8A24, checkOpenLeft	;instruction to jump to if shot
dw $86C1, $BD0F		;jump to instruction if shot (by anything)
dw $0001, $A9B3		;closed door blue left
sleepLeft:
dw $86B4
dw $8724, sleepLeft
checkOpenLeft:
dw eventCheck : db !blueEvent : dw openLeft	;door is unlocked if event is set
dw $0001, $A9B3
dw $8724, checkOpenLeft
openLeft:
dw $8C19 : db $07	;queue "door opened" sound
dw $0004, $A9BF		;begin opening
dw $0004, $A9CB
dw $0004, $A9D7
dw $005C, $A677		;only door frame
dw $86BC  		;delete

;Blue door cap right
;Close door cap
rightClose:
dw $0002, $A683		;door frame only
dw $0002, $AA13
dw $8C19 : db $08	;queue "door closed" sfx
dw $0002, $AA07
dw $0002, $A9FB
dw $0001, $A9EF		;closed
;Main instructions:
rightMain:
dw $8A72, $C4B1		;??? they all do this
dw $8A24, checkOpenRight	;instruction to jump to if shot
dw $86C1, $BD0F		;jump to instruction if shot (by anything)
dw $0001, $A9EF		;closed door blue right
sleepRight:
dw $86B4
dw $8724, sleepRight
checkOpenRight:
dw eventCheck : db !blueEvent : dw openRight	;door is unlocked if event is set
dw $0001, $A9EF
dw $8724, checkOpenRight
openRight:
dw $8C19 : db $07	;queue "door opened" sound
dw $0004, $A9FB		;begin opening
dw $0004, $AA07
dw $0004, $AA13
dw $005C, $A683		;only door frame
dw $86BC  		;delete


eventCheck:
LDA $0000,y
AND #$00FF		;clear high byte
INY			;prepare to go to next instruction
JSL $808233		;carry set if event set
BCC $03
JMP $8724		;go to next instruction
INY
INY
RTS			;pass over next instruction

