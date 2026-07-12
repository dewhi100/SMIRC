lorom

;One-room elevators by dewhi100
;Please give credit if you use this.

;With this patch, adding #$1000 to an elevator's "speed" variable will tell the elevator to move between spots in one room, instead of between different rooms.
;Set "Speed 2" to the height you want the elevator to go to.
;Make sure that the starting direction from speed (0 or 1) matches with the speed 2 being lower/higher than the elevator enemy's position.

org $A3952F

JSR heightCheck

org $A3954B	

JSR scrubY

org $A39571

JSR singleRoomCheck

org $A3957C

JSR scrubA

org $A395BF

JSR scrubA

;---;

org !freeA3	;Freespace. You may need to adjust this.

;Because speed is used as an index by the vanilla code, we need to remove the single-room flag before we use it. The "scrubA" and "scrubY" routines do that.

scrubY:

PHA
LDA $0FB4,x
AND #$0002
TAY
PLA
RTS

scrubA:
LDA $0FB4,x
AND #$0002
RTS

;The "singleRoomCheck" routine looks at bit #$2000 in the speed variable and executes the single-room logic instead of usual logic if that bit is set.
;Note: bit #$2000 is checked instead of bit #$0001 because the speed variable in the editor is doubled before it is stored. Use #$1000 in the editor. 

singleRoomCheck:
INC $0E18
LDX $0E54
LDA $0FB4,x
BIT #$2000
BEQ end
BIT #$0002
BEQ +
;if 2, set 0
AND #$2000
BRA ++
+
ORA #$0002
++
STA $0FB4,x 
LDA $0FB6,x
STA $0FA8
LDA $0F7E,x
STA $0FB6,x
INC $0E18
INC $0E18
end:
RTS

;Vanilla SM will let samus use the elevator from ANY 0000 door tiles. This routine lets her use the elvator only if it's the one she is standing on.

heightCheck:

LDX $0E54
LDA $0F7E,x
SEC
SBC $0AFA
BMI +
CMP #$0020
BPL +
LDA $0E16	;Elevator properties
RTS
+
LDA #$0000
STZ $0E16
RTS

!freeA3 #= pc()