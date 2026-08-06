;accel-charge
;----
;includes the PLM
;Write your own messagebox

;The table at AccelCharge_beam and _sba determine the timers


lorom

;increment each time an Accel Charge is picked up.
; Should always be a multiple of 2 (table indexing)
;!AccelChargeCounter = $09F4 ;word SRAM.


;!84Free = $84F800
;!89Free = $899100
;!8BFree = $8BF760
;!90Free = $90F800
;!91Free = $91FFEE


org !free8B	;!8BFree
EndPercent:
.ammoDivisors
;  etanks rtanks missile super pb 
dw $09C4, $09D4, $09C8, $09CC, $09D0, !AccelChargeCounter; RAM addresses to measure
.count
dw $0064, $0064, $0005, $0005, $0005, $0002 ; Divisors

;hijacks
if !PercentTime_FelicityVi == 0
	org $8BE62F : LDX #$000A ;+2 for each address to count, zero indexed
	org $8BE634 : LDA.w EndPercent_ammoDivisors,x : TAY
	org $8BE640 : LDA.w EndPercent_ammoDivisors+(EndPercent_count-EndPercent_ammoDivisors),x : STA $4206
endif

org $90A4F8 : JSR AccelCharge_checkIfCharged ;hijack pseudo screw :: CMP #$003C
org $90A747 : JSR AccelCharge_checkIfCharged ;hijack pseudo screw :: CMP #$003C
org $90B82D : JSR AccelCharge_setup  ;hijack normal hud handler :: LDA $0B5E
org $90B835 : CMP.w AccelCharge_beam,x ;inline overwrite comparison
org $90B846 : CMP.w AccelCharge_sba,x  ;inline overwrite comparison
org $90B85F : CMP.w AccelCharge_beam,x ;inline overwrite comparison
org $90C0B6 : JSR AccelCharge_checkIfCharged ;hijack morph charge bomb spread
org $90C0CA : JMP AccelCharge_checkBombSpreadTimeout ;hijack bomb spread counter
org $90D88D : JMP AccelCharge_fixBombSpread
org $91D755 : JSR AccelCharge91_checkIfCharged ;hijack charge beam palette handling :: CMP #$003C

!free8B #= pc()

org $84DFC7 
;fix chozo burst inst to clear trigger flag
;No need to repoint because there's an unused routine immediately after.
;this overwrites part of an unused instruction list at $DFD7.
dw $86CA       ; Clear pre-instruction
dw $0003, $A2B5
dw $0003, $A2D9
dw $0003, $A2B5
dw $BBDD        ;clear trigger status
dw $8A3A        ; Return

org !free84	;!84Free
;probably want to move the header to a location that
;you're sure will not change while making the hack
;Bc if the header moves then you have to fix all the in-room references.
print pc, " - Plm Header :: Accel Charge Normal Plm Header"
dw $EE64, AccelChargePickup_inst_normal
print pc, " - Plm Header :: Accel Charge Chozo Plm Header"
dw $EE64, AccelChargePickup_inst_chozo
AccelChargePickup:
{ ;shares setup with vanilla 
.rout
..collectAccelCharge
LDA.w !AccelChargeCounter : INC : INC : CMP.w #AccelCharge_sba-AccelCharge_beam : BPL +
	STA !AccelChargeCounter ;cap it at table size.
+

;if !equip_screen_itemstime != 0
;	JSL COLLECTTANK
;endif

;show messagebox
LDA #$0168 : JSL $82E118 ;play room music after fanfare

LDA.w #!AccelChargeMessageIndex

JSL $858080
RTS
.inst
..normal
	dw $8764,AccelChargeGraphics  : db $08,$08,$08,$08,$08,$08,$08,$08                            
	dw $887C, .empty    ; Go to if the room argument item is set          
	...reveal ;label for Chozo Freeup only
	dw $8A24, ...pickup   ; Link instruction = $E0B1                              
	dw $86C1,$DF89        ; Pre-instruction = go to link instruction if triggered  
	...loop                                           
	dw $E04F              ;\animate dynamic item                                   
	dw $E067              ;/   ...it is in conflict with instant pickups.                                               
	dw $8724, ...loop     ; Goto loop                                           
	...pickup                                                
	dw $8899              ; Set the room argument item                             
	dw $8BDD : db $02     ;queue fanfare
	dw .rout_collectAccelCharge
	...empty
	dw $8724,.empty        ; Go to empty item.
..chozo
	dw $8764,AccelChargeGraphics : db $08,$08,$08,$08,$08,$08,$08,$08 ;high priority
	dw $887C,.empty      ; Go to if the room argument item is set
	dw $8A2E,$DFAF                          ; Call $DFAF (item orb)
	dw $8A2E,$DFC7                          ; Call $DFC7 (item orb burst)
	dw $8724, ..normal_reveal
	
.empty
dw $0001,$A2B5
dw $86BC
}

!free84 #= pc()

org !free89	;!89Free
AccelChargeGraphics:
incbin "accel-charge.gfx"
!free89 #= pc()

org !free90	;!90Free
AccelCharge:
{
;vanilla charged beam is $3C (60f) frames to charge
;SBA is $78 (120f)
;Charge should scale down to half time
;SBA should scale down to nothing & fire instantly when you have all of them.

;hijack to load [X] with !AccelChargeCounter at top of BRANCH_CHARGE
;then inline replace the CMPs with CMP table,x
;if on HUD 3 && have all charges, don't fire a beam on key down.


.setup ;from hijack BRANCH_CHARGE of $90B80D
LDX.w !AccelChargeCounter
;CPX.w #.sba-.beam-2 : BNE +
;;special behavior for very fast SBA
;;without this it fires a shot & the SBA noticibly deletes it.
;;This is not a problem in vanilla bc it takes so long to use.
;;this code becomes useful at SBA charges lower than 20 frames
;	LDA $09D2 : CMP #$0003 : BNE +
;	LDA $8B : AND $09B2 : BEQ + ;if holding shot
;		PLA ;tidy stack to jump out
;		;got all charges in the table && on HUD 3 so jump directly to SBA
;		LDA $0CD0 : CMP.w .sba,x : BMI ++
;			JMP $B876
;		++
;		INC $0CD0 
;		PLP 
;		RTS ;return from HUD handler
;+
LDA $0B5E ;hijack code
RTS
;zero index is default, each accel charge pickup advances to the next value.
.beam ;target charge values
dw  60,  50,  40,  30,  20
.sba ;must be larger than the Charge values.
dw 120, 100,  80,  60,  40
.bombSpread
dw 190, 170, 150, 130, 110

.checkIfCharged
;jump to from all the points that LDA $0CD0 : CMP #$003C
LDX.w !AccelChargeCounter
LDA $0CD0 : CMP .beam,x 
RTS
.checkBombSpreadTimeout
;input [A] bomb charge amount
;it kicks you out of bomb spread earlier
;but doesn't reach "max charge" because 
;the velocity of the bombs is a function of the timer value itself.
;look at $90D88D for a fix
LDX.w !AccelChargeCounter
AND .bombSpread,x : CMP .bombSpread,x
JMP $C0D0

.fixBombSpread
;needs to work off of % charged, not the timer directly.
;vanilla: Bomb Y velocity = -([$D8E3 + [Y]] + [bomb spread charge timeout counter] / 40h % 4)
;vanilla full charge release is $C0 frames
;this is integrated with the velocity code bc it expects the timer to be a power of 2 on each increase of the bomb velocity
;goal: increase the Y velocity by 1px for every quarter for the max timer.
PHX
LDX.w !AccelChargeCounter
LDA .bombSpread,x : LSR : LSR ;/4
TAX
LDA $0CD4 : STA $4204
SEP #$30
STX $4206 ;timer / (target/4)
REP #$30
NOP #7 ;wait for division
PLX
LDA $4214 ;number of px to increase velocity
JMP $D896 ;return velocity to add to bomb, positive number
}

!free90 #= pc()

org !free91 ;!91Free
AccelCharge91:
.checkIfCharged
;jump to from all the points that LDA $0CD0 : CMP #$003C
LDX.w !AccelChargeCounter
LDA $0CD0 : CMP.l AccelCharge_beam,x 
RTS

!free91 #= pc()