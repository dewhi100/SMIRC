lorom 

;Samus animations master disassembly;


					;$91:8000 checks movement type, and goes to 91:(8014,X), X being 2x movement type.
;ORG $918014			;optimizing transition routine pointer table for extra space
ORG !disassemblyFreespace ;optimizing transition routine pointer table for extra space
	DW MT_00, MT_01, MT_02, MT_03, MT_04, MT_05, MT_06, MT_07, MT_08, MT_09, MT_0A
	DW MT_0B, MT_0C, MT_0D, MT_0E, MT_0F, MT_10, MT_11, MT_12, MT_13, MT_14, MT_15
	DW MT_16, MT_17, MT_18, MT_19, MT_1A, MT_1B
	
MT_00:		;standing
	PHP : REP #$30 : LDA $0A1C : BEQ +
	CMP #$009B : BEQ +
	BRA ++
+
	LDA $0E18 : BNE +++
++
	JSR $81A9
+++
	PLP : RTS
MT_01:		;Walking/running
MT_02:		;normal jump
MT_03:		;spin jump
MT_04:		;morph ball on ground
MT_05:		;crouch
MT_06:		;falling
MT_08:		;morph ball in air
MT_0A:		;Hurt
MT_10:		;moonwalking
MT_11:		;spring ball on ground
MT_12:		;spring ball in air
MT_13:		;falling with spring ball
MT_14:		;wall jump
MT_15:		;Ran into a wall
MT_16:		;Grappling
MT_19:		;Spin back
MT_1A:		;Grabbed by Draygon
MT_1B:		;Superjump / Drained by Metroid / Damaged by MB's attacks / CF
	PHP : REP #$30 
	if !Downsparking_Tundain == 0
	JSR $81A9
	else
	JSR extra_downspark
	endif
	PLP
MT_07:		;Glitchy (morph ball/spinjump), unused?
MT_09:		;Glitchy morph ball, unused?
MT_0B:		;Can fire grapple beam, not moving. (unused?)
MT_0C:		;Can fire grapple beam and change pose, no MT_ment. (unused?)
MT_0D:		;Can change pose, no MT_ment or firing. (unused?)
MT_0F:		;Standing/crouching, and crouching/morphball
	RTS
MT_0E:		;turning around
MT_17:		;turning in air (jumping)
MT_18:		;turning while falling
	JSR $81A9 : RTS

warnpc $9181A9
!disassemblyFreespace #= pc()
;	PadByte $FF : Pad $9181A9  ;$138 bytes of freespace now

;----------------------------------------------------------------------------------------------------------

org $919EE2	;original transition table disassembly by Kej
	DW T00,T01,T02,T03,T04,T05,T06,T07,T08,T09,T0A,T0B,T0C,T0D,T0E,T0F
	DW T10,T11,T12,T13,T14,T15,T16,T17,T18,T19,T1A,T1B,T1C,T1D,T1E,T1F
	DW T20,T21,T22,T23,T24,T25,T26,T27,T28,T29,T2A,T2B,T2C,T2D,T2E,T2F
	DW T30,T31,T32,T33,T34,T35,T36,T37,T38,T39,T3A,T3B,T3C,T3D,T3E,T3F
	DW T40,T41,T42,T43,T44,T45,T46,T47,T48,T49,T4A,T4B,T4C,T4D,T4E,T4F
	DW T50,T51,T52,T53,T54,T55,T56,T57,T58,T59,T5A,T5B,T5C,T5D,T5E,T5F
	DW T60,T61,T62,T63,T64,T65,T66,T67,T68,T69,T6A,T6B,T6C,T6D,T6E,T6F
	DW T70,T71,T72,T73,T74,T75,T76,T77,T78,T79,T7A,T7B,T7C,T7D,T7E,T7F
	DW T80,T81,T82,T83,T84,T85,T86,T87,T88,T89,T8A,T8B,T8C,T8D,T8E,T8F
	DW T90,T91,T92,T93,T94,T95,T96,T97,T98,T99,T9A,T9B,T9C,T9D,T9E,T9F
	DW TA0,TA1,TA2,TA3,TA4,TA5,TA6,TA7,TA8,TA9,TAA,TAB,TAC,TAD,TAE,TAF
	DW TB0,TB1,TB2,TB3,TB4,TB5,TB6,TB7,TB8,TB9,TBA,TBB,TBC,TBD,TBE,TBF
	DW TC0,TC1,TC2,TC3,TC4,TC5,TC6,TC7,TC8,TC9,TCA,TCB,TCC,TCD,TCE,TCF
	DW TD0,TD1,TD2,TD3,TD4,TD5,TD6,TD7,TD8,TD9,TDA,TDB,TDC,TDD,TDE,TDF
	DW TE0,TE1,TE2,TE3,TE4,TE5,TE6,TE7,TE8,TE9,TEA,TEB,TEC,TED,TEE,TEF
	DW TF0,TF1,TF2,TF3,TF4,TF5,TF6,TF7,TF8,TF9,TFA,TFB,TFC

T00:		;00:;Facing forward, ala Elevator pose (power suit)
T9B:		;9B:;Facing forward, ala Elevator pose (Varia and/or Gravity Suit)
DW $0000,$0100,$0026
DW $0000,$0200,$0025
DW $FFFF

T01:		;01:;Facing right, normal
T03:		;03:;Facing right, aiming up
T05:		;05:;Facing right, aiming upright
T07:		;07:;Facing right, aiming Downright
TA4:		;A4:;Landing from normal jump, facing right
TA6:		;A6:;Landing from spin jump, facing right
TE0:		;E0:;Landing from normal jump, facing right and aiming up
TE2:		;E2:;Landing from normal jump, facing right and aiming upright
TE4:		;E4:;Landing from normal jump, facing right and aiming Downright
TE6:		;E6:;Landing from normal jump, facing right, firing
DW $0080,$0800,$0055
DW $0080,$0010,$0057
DW $0080,$0020,$0059
DW $0080,$0000,$004B
DW $0400,$0030,$00F1
DW $0400,$0010,$00F3
DW $0400,$0020,$00F5
DW $0400,$0000,$0035
DW $0000,$0260,$0078
DW $0000,$0250,$0076
DW $0000,$0230,$0025
DW $0000,$0030,$0003
DW $0000,$0110,$000F
DW $0000,$0120,$0011
DW $0000,$0900,$000F
DW $0000,$0500,$0011
DW $0000,$0240,$004A
DW $0000,$0200,$0025
DW $0000,$0800,$0003
DW $0000,$0010,$0005
DW $0000,$0020,$0007
DW $0000,$0100,$0009
DW $FFFF

T02:		;02:;Facing left, normal
T04:		;04:;Facing left, aiming up
T06:		;06:;Facing left, aiming upleft
T08:		;08:;Facing left, aiming Downleft
TA5:		;A5:;Landing from normal jump, facing left
TA7:		;A7:;Landing from spin jump, facing left
TE1:		;E1:;Landing from normal jump, facing left and aiming up
TE3:		;E3:;Landing from normal jump, facing left and aiming upleft
TE5:		;E5:;Landing from normal jump, facing left and aiming Downleft
TE7:		;E7:;Landing from normal jump, facing left, firing
DW $0080,$0800,$0056
DW $0080,$0010,$0058
DW $0080,$0020,$005A
DW $0080,$0000,$004C
DW $0400,$0030,$00F2
DW $0400,$0010,$00F4
DW $0400,$0020,$00F6
DW $0400,$0000,$0036
DW $0000,$0160,$0077
DW $0000,$0150,$0075
DW $0000,$0140,$0049
DW $0000,$0100,$0026
DW $0000,$0030,$0004
DW $0000,$0210,$0010
DW $0000,$0220,$0012
DW $0000,$0A00,$0010
DW $0000,$0600,$0012
DW $0000,$0800,$0004
DW $0000,$0010,$0006
DW $0000,$0020,$0008
DW $0000,$0200,$000A
DW $FFFF

T09:		;09:;Moving right, not aiming
T0D:		;0D:;Moving right, aiming straight up (unused?)
T0F:		;0F:;Moving right, aiming upright
T11:		;11:;Moving right, aiming Downright
DW $0400,$0000,$0035
DW $0080,$0000,$0019
DW $0000,$0110,$000F
DW $0000,$0120,$0011
DW $0000,$0900,$000F
DW $0000,$0500,$0011
DW $0000,$0140,$000B
DW $0000,$0100,$0009
DW $0000,$0200,$0025
DW $0000,$0800,$0003
DW $0000,$0010,$0005
DW $0000,$0020,$0007
DW $FFFF

T0A:		;0A:;Moving left, not aiming
T0E:		;0E:;Moving left, aiming straight up (unused?)
T10:		;10:;Moving left, aiming upleft
T12:		;12:;Moving left, aiming Downleft
DW $0400,$0000,$0036
DW $0080,$0000,$001A
DW $0000,$0210,$0010
DW $0000,$0220,$0012
DW $0000,$0A00,$0010
DW $0000,$0600,$0012
DW $0000,$0240,$000C
DW $0000,$0200,$000A
DW $0000,$0100,$0026
DW $0000,$0800,$0004
DW $0000,$0010,$0006
DW $0000,$0020,$0008
DW $FFFF

T0B:		;0B:;Moving right, gun extended forward (not aiming)
DW $0400,$0000,$0035
DW $0080,$0000,$0019
DW $0000,$0110,$000F
DW $0000,$0120,$0011
DW $0000,$0900,$000F
DW $0000,$0500,$0011
DW $0000,$0100,$000B
DW $0000,$0200,$0025
DW $0000,$0800,$0003
DW $0000,$0010,$0005
DW $0000,$0020,$0007
DW $FFFF

T0C:		;0C:;Moving left, gun extended forward (not aiming)
DW $0400,$0000,$0036
DW $0080,$0000,$001A
DW $0000,$0210,$0010
DW $0000,$0220,$0012
DW $0000,$0A00,$0010
DW $0000,$0600,$0012
DW $0000,$0200,$000C
DW $0000,$0100,$0026
DW $0000,$0800,$0004
DW $0000,$0010,$0006
DW $0000,$0020,$0008
DW $FFFF

T13:		;13:;Normal jump facing right, gun extended, not aiming or moving
DW $0000,$0900,$0069
DW $0000,$0500,$006B
DW $0000,$0190,$0069
DW $0000,$01A0,$006B
DW $0000,$0200,$002F
DW $0000,$0800,$0015
DW $0000,$0400,$0017
DW $0000,$0010,$0069
DW $0000,$0020,$006B
DW $0000,$0100,$0051
DW $0000,$0040,$0013
DW $FFFF

T14:		;14:;Normal jump facing left, gun extended, not aiming or moving
DW $0000,$0A00,$006A
DW $0000,$0600,$006C
DW $0000,$0290,$006A
DW $0000,$02A0,$006C
DW $0000,$0100,$0030
DW $0000,$0800,$0016
DW $0000,$0400,$0018
DW $0000,$0010,$006A
DW $0000,$0020,$006C
DW $0000,$0200,$0052
DW $0000,$0040,$0014
DW $FFFF

T15:		;15:;Normal jump facing right, aiming up
T4D:		;4D:;Normal jump facing right, gun not extended, not aiming, not moving
T51:		;51:;Normal jump facing right, moving forward (gun extended)
T69:		;69:;Normal jump facing right, aiming upright. Moving optional
T6B:		;6B:;Normal jump facing right, aiming Downright. Moving optional
DW $0000,$0900,$0069
DW $0000,$0500,$006B
DW $0000,$0190,$0069
DW $0000,$01A0,$006B
DW $0000,$0200,$002F
DW $0000,$0800,$0015
DW $0000,$0400,$0017
DW $0000,$0010,$0069
DW $0000,$0020,$006B
DW $0000,$0100,$0051
DW $0000,$00C0,$0013
DW $0000,$0080,$004D
DW $0000,$0040,$0013
DW $FFFF

T16:		;16:;Normal jump facing left, aiming up
T4E:		;4E:;Normal jump facing left, gun not extended, not aiming, not moving
T52:		;52:;Normal jump facing left, moving forward (gun extended)
T6A:		;6A:;Normal jump facing left, aiming upleft. Moving optional
T6C:		;6C:;Normal jump facing left, aiming Downleft. Moving optional
DW $0000,$0A00,$006A
DW $0000,$0600,$006C
DW $0000,$0290,$006A
DW $0000,$02A0,$006C
DW $0000,$0100,$0030
DW $0000,$0800,$0016
DW $0000,$0400,$0018
DW $0000,$0010,$006A
DW $0000,$0020,$006C
DW $0000,$0200,$0052
DW $0000,$00C0,$0014
DW $0000,$0080,$004E
DW $0000,$0040,$0014
DW $FFFF

T17:		;17:;Normal jump facing right, aiming Down
DW $0400,$0000,$0037
DW $0000,$0900,$0069
DW $0000,$0500,$006B
DW $0000,$0190,$0069
DW $0000,$01A0,$006B
DW $0000,$0200,$002F
DW $0000,$0800,$0015
DW $0000,$0400,$0017
DW $0000,$0010,$0069
DW $0000,$0020,$006B
DW $0000,$0100,$0051
DW $0000,$00C0,$0013
DW $0000,$0080,$0017
DW $0000,$0040,$0013
DW $FFFF

T18:		;18:;Normal jump facing left, aiming Down
DW $0400,$0000,$0038
DW $0000,$0A00,$006A
DW $0000,$0600,$006C
DW $0000,$0290,$006A
DW $0000,$02A0,$006C
DW $0000,$0100,$0030
DW $0000,$0800,$0016
DW $0000,$0400,$0018
DW $0000,$0010,$006A
DW $0000,$0020,$006C
DW $0000,$0200,$0052
DW $0000,$00C0,$0014
DW $0000,$0080,$0018
DW $0000,$0040,$0014
DW $FFFF

T19:		;19:;Spin jump right
DW $0040,$0000,$0013
DW $0000,$0840,$0015
DW $0000,$0440,$0017
DW $0000,$0050,$0069
DW $0000,$0060,$006B
DW $0000,$0180,$0019
DW $0000,$0800,$0015
DW $0000,$0010,$0069
DW $0000,$0020,$006B
DW $0000,$0400,$0017
DW $0000,$0100,$0019
DW $0000,$0200,$001A
DW $FFFF

T1A:		;1A:;Spin jump left
DW $0040,$0000,$0014
DW $0000,$0840,$0016
DW $0000,$0440,$0018
DW $0000,$0050,$006A
DW $0000,$0060,$006C
DW $0000,$0280,$001A
DW $0000,$0800,$0016
DW $0000,$0010,$006A
DW $0000,$0020,$006C
DW $0000,$0400,$0018
DW $0000,$0200,$001A
DW $0000,$0100,$0019
DW $FFFF

T1B:		;1B:;Space jump right
DW $0040,$0000,$0013
DW $0000,$0840,$0015
DW $0000,$0440,$0017
DW $0000,$0050,$0069
DW $0000,$0060,$006B
DW $0000,$0180,$001B
DW $0000,$0800,$0015
DW $0000,$0010,$0069
DW $0000,$0020,$006B
DW $0000,$0400,$0017
DW $0000,$0100,$001B
DW $0000,$0200,$001C
DW $FFFF

T1C:		;1C:;Space jump left
DW $0040,$0000,$0014
DW $0000,$0840,$0016
DW $0000,$0440,$0018
DW $0000,$0050,$006A
DW $0000,$0060,$006C
DW $0000,$0280,$001C
DW $0000,$0800,$0016
DW $0000,$0010,$006A
DW $0000,$0020,$006C
DW $0000,$0400,$0018
DW $0000,$0200,$001C
DW $0000,$0100,$001B
DW $FFFF

T1D:		;1D:;Facing right as morphball, no springball
T1E:		;1E:;Moving right as a morphball on ground without springball
DW $0800,$0000,$003D
DW $0080,$0000,$003D

T1F:		;1F:;Moving left as a morphball on ground without springball
T41:		;41:;Staying still with morphball, facing left, no springball
DW $0800,$0000,$003E
DW $0080,$0000,$003E
DW $0000,$0100,$001E
DW $0000,$0200,$001F
DW $FFFF

T20:		;20:;Spinjump right. Unused?
T21:		;21:;Spinjump right. Unused?
T22:		;22:;Spinjump right. Unused?
T23:		;23:;Spinjump right. Unused?
T24:		;24:;Spinjump right. Unused?
T2F:		;2F:;starting with normal jump facing right, turning left
T30:		;30:;starting with normal jump facing left, turning right
T33:		;33:;Spinjump right. Unused?
T34:		;34:;Spinjump right. Unused?
T35:		;35:;Crouch transition, facing right
T36:		;36:;Crouch transition, facing left
T37:		;37:;Morphing into ball, facing right. Ground and mid-air
T38:		;38:;Morphing into ball, facing left. Ground and mid-air
T39:		;39:;Midair morphing into ball, facing right? May be unused
T3A:		;3A:;Midair morphing into ball, facing left? May be unused
T3B:		;3B:;Standing from crouching, facing right
T3C:		;3C:;Standing from crouching, facing left
T3D:		;3D:;Demorph while facing right. Mid-air and on ground
T3E:		;3E:;Demorph while facing left. Mid-air and on ground
T3F:		;3F:;Some transition with morphball, facing right. Maybe unused
T40:		;40:;Some transition with morphball, facing left. Maybe unused
T42:		;42:;Spinjump right. Unused?
T43:		;43:;starting from crouching right, turning left
T44:		;44:;starting from crouching left, turning right
T47:		;47:;Standing, facing right. Unused?
T48:		;48:;Standing, facing left. Unused?
T4B:		;4B:;Normal jump transition from ground(standing or crouching), facing right
T4C:		;4C:;Normal jump transition from ground(standing or crouching), facing left
T55:		;55:;Normal jump transition from ground, facing right and aiming up
T56:		;56:;Normal jump transition from ground, facing left and aiming up
T57:		;57:;Normal jump transition from ground, facing right and aiming upright
T58:		;58:;Normal jump transition from ground, facing left and aiming upleft
T59:		;59:;Normal jump transition from ground, facing right and aiming Downright
T5A:		;5A:;Normal jump transition from ground, facing left and aiming Downleft
T5B:		;5B:;Something for grapple (wall jump?), probably unused
T5C:		;5C:;Something for grapple (wall jump?), probably unused
T5D:		;5D:;Broken grapple? Facing clockwise, maybe unused
T5E:		;5E:;Broken grapple? Facing clockwise, maybe unused
T5F:		;5F:;Broken grapple? Facing clockwise, maybe unused
T60:		;60:;Better broken grapple. Facing clockwise, maybe unused
T61:		;61:;Nearly normal grapple. Facing clockwise, maybe unused
T62:		;62:;Nearly normal grapple. Facing counterclockwise, maybe unused
T63:		;63:;Facing left on grapple blocks, ready to jump. Unused?
T64:		;64:;Facing right on grapple blocks, ready to jump. Unused?
T65:		;65:;Glitchy jump, facing left. Used by unused grapple jump?
T66:		;66:;Glitchy jump, facing right. Used by unused grapple jump?
T87:		;87:;Turning from right to left while falling
T88:		;88:;Turning from left to right while falling
T8F:		;8F:;Turning around from right to left while aiming straight up in midair
T90:		;90:;Turning around from left to right while aiming straight up in midair
T91:		;91:;Turning around from right to left while aiming Down or diagonal Down in midair
T92:		;92:;Turning around from left to right while aiming Down or diagonal Down in midair
T93:		;93:;Turning around from right to left while aiming straight up while falling
T94:		;94:;Turning around from left to right while aiming straight up while falling
T95:		;95:;Turning around from right to left while aiming Down or diagonal Down while falling
T96:		;96:;Turning around from left to right while aiming Down or diagonal Down while falling
T97:		;97:;Turning around from right to left while aiming straight up while crouching
T98:		;98:;Turning around from left to right while aiming straight up while crouching
T99:		;99:;Turning around from right to left while aiming diagonal Down while crouching
T9A:		;9A:;Turning around from left to right while aiming diagonal Down while crouching
T9C:		;9C:;Turning around from right to left while aiming diagonal up while standing
T9D:		;9D:;Turning around from left to right while aiming diagonal up while standing
T9E:		;9E:;Turning around from right to left while aiming diagonal up in midair
T9F:		;9F:;Turning around from left to right while aiming diagonal up in midair
TA0:		;A0:;Turning around from right to left while aiming diagonal up while falling
TA1:		;A1:;Turning around from left to right while aiming diagonal up while falling
TA2:		;A2:;Turn around from right to left while aiming diagonal up while crouching
TA3:		;A3:;Turn around from left to right while aiming diagonal up while crouching
TA8:		;A8:;Just standing, facing right. Unused? (Grapple movement)
TA9:		;A9:;Just standing, facing left. Unused? (Grapple movement)
TAA:		;AA:;Just standing, facing right aiming Downright. Unused? (Grapple movement)
TAB:		;AB:;Just standing, facing left aiming Downleft. Unused? (Grapple movement)
TAC:		;AC:;jumping, facing right, gun extended. Unused? (Grapple movement)
TAD:		;AD:;jumping, facing left, gun extended. Unused? (Grapple movement)
TAE:		;AE:;jumping, facing right, aiming Down. Unused? (Grapple movement)
TAF:		;AF:;jumping, facing left, aiming Down. Unused? (Grapple movement)
TB0:		;B0:;jumping, facing right, aiming Downright. Unused? (Grapple movement)
TB1:		;B1:;jumping, facing left, aiming Downleft. Unused? (Grapple movement)
TB2:		;B2:;Grapple, facing clockwise
TB3:		;B3:;Grapple, facing counterclockwise
TB4:		;B4:;Crouching, facing right. Unused? (Grapple movement)
TB5:		;B5:;Crouching, facing left. Unused? (Grapple movement)
TB6:		;B6:;Crouching, facing right, aiming Downright. Unused? (Grapple movement)
TB7:		;B7:;Crouching, facing left, aiming Downleft. Unused? (Grapple movement)
TB8:		;B8:;Grapple, attached to a wall on right, facing left
TB9:		;B9:;Grapple, attached to a wall on left, facing right
TC5:		;C5:;Morph ball, facing right. Unused? (Grabbed by Draygon movement)
TC6:		;C6:;Morph ball, facing left. Unused? (Grabbed by Draygon movement)
TC9:		;C9:;Horizontal super jump, right
TCA:		;CA:;Horizontal super jump, left
TCB:		;CB:;Vertical super jump, facing right
TCC:		;CC:;Vertical super jump, facing left
TCD:		;CD:;Diagonal super jump, right
TCE:		;CE:;Diagonal super jump, left
TD3:		;D3:;Crystal flash, facing right
TD4:		;D4:;Crystal flash, facing left
TD5:		;D5:;X-raying right, standing
TD6:		;D6:;X-raying left, standing
TD7:		;D7:;Crystal flash ending, facing right
TD8:		;D8:;Crystal flash ending, facing left
TD9:		;D9:;X-raying right, crouching
TDA:		;DA:;X-raying left, crouching
TDB:		;DB:;Standing transition to morphball, facing right? Unused?
TDC:		;DC:;Standing transition to morphball, facing left? Unused?
TDD:		;DD:;Morphball transition to standing, facing right? Unused?
TDE:		;DE:;Morphball transition to standing, facing left? Unused?
TE8:		;E8:;Samus exhausted(Metroid drain, MB attack), facing right
TE9:		;E9:;Samus exhausted(Metroid drain, MB attack), facing left
TEA:		;EA:;Samus exhausted, looking up to watch Metroid attack MB, facing right
TEB:		;EB:;Samus exhausted, looking up to watch Metroid attack MB, facing left
TF1:		;F1:;Crouch transition, facing right and aiming up
TF2:		;F2:;Crouch transition, facing left and aiming up
TF3:		;F3:;Crouch transition, facing right and aiming upright
TF4:		;F4:;Crouch transition, facing left and aiming upleft
TF5:		;F5:;Crouch transition, facing right and aiming Downright
TF6:		;F6:;Crouch transition, facing left and aiming Downleft
TF7:		;F7:;Crouching to standing, facing right and aiming up
TF8:		;F8:;Crouching to standing, facing left and aiming up
TF9:		;F9:;Crouching to standing, facing right and aiming upright
TFA:		;FA:;Crouching to standing, facing left and aiming upleft
TFB:		;FB:;Crouching to standing, facing right and aiming Downright
TFC:		;FC:;Crouching to standing, facing left and aiming Downleft
DW $FFFF

T25:		;25:;starting standing right, turning left
DW $0000,$0280,$001A
DW $0080,$0000,$004C
DW $0000,$0200,$0025
DW $FFFF

T26:		;26:;starting standing left, turning right
DW $0000,$0180,$0019
DW $0080,$0000,$004B
DW $0000,$0100,$0026
DW $FFFF

T27:		;27:;Crouching, facing right
T71:		;71:;Standing to crouching, facing right and aiming upright
T73:		;73:;Standing to crouching, facing right and aiming Downright
T85:		;85:;Crouching, facing right aiming up
DW $0800,$0030,$00F7
DW $0800,$0010,$00F9
DW $0800,$0020,$00FB
DW $0800,$0000,$003B
DW $0200,$0000,$0043
DW $0400,$0000,$0037
DW $0080,$0000,$004B
DW $0000,$0030,$0085
DW $0000,$0100,$0001
DW $0000,$0010,$0071
DW $0000,$0020,$0073
DW $FFFF

T28:		;28:;Crouching, facing left
T72:		;72:;Standing to crouching, facing left and aiming upleft
T74:		;74:;Standing to crouching, facing left and aiming Downleft
T86:		;86:;Crouching, facing left aiming up
DW $0800,$0030,$00F8
DW $0800,$0010,$00FA
DW $0800,$0020,$00FC
DW $0800,$0000,$003C
DW $0100,$0000,$0044
DW $0400,$0000,$0038
DW $0080,$0000,$004C
DW $0000,$0030,$0086
DW $0000,$0200,$0002
DW $0000,$0010,$0072
DW $0000,$0020,$0074
DW $FFFF

T29:		;29:;Falling facing right, normal pose
T2B:		;2B:;Falling facing right, aiming up
T6D:		;6D:;Falling facing right, aiming upright
T6F:		;6F:;Falling facing right, aiming Downright
DW $0000,$0900,$006D
DW $0000,$0500,$006F
DW $0000,$0200,$0087
DW $0000,$0800,$002B
DW $0000,$0400,$002D
DW $0000,$0010,$006D
DW $0000,$0020,$006F
DW $0000,$0040,$0067
DW $0000,$0100,$0029
DW $FFFF

T2A:		;2A:;Falling facing left, normal pose
T2C:		;2C:;Falling facing left, aiming up
T6E:		;6E:;Falling facing left, aiming upleft
T70:		;70:;Falling facing left, aiming Downleft
DW $0000,$0A00,$006E
DW $0000,$0600,$0070
DW $0000,$0100,$0088
DW $0000,$0800,$002C
DW $0000,$0400,$002E
DW $0000,$0010,$006E
DW $0000,$0020,$0070
DW $0000,$0040,$0068
DW $0000,$0200,$002A
DW $FFFF

T2D:		;2D:;Falling facing right, aiming Down
DW $0400,$0000,$0037
DW $0000,$0900,$006D
DW $0000,$0500,$006F
DW $0000,$0800,$002B
DW $0000,$0400,$002D
DW $0000,$0200,$0087
DW $0000,$0010,$006D
DW $0000,$0020,$006F
DW $0000,$0040,$0067
DW $0000,$0100,$0029
DW $FFFF

T2E:		;2E:;Falling facing left, aiming Down
DW $0400,$0000,$0038
DW $0000,$0A00,$006E
DW $0000,$0600,$0070
DW $0000,$0800,$002C
DW $0000,$0400,$002E
DW $0000,$0100,$0088
DW $0000,$0010,$006E
DW $0000,$0020,$0070
DW $0000,$0040,$0068
DW $0000,$0200,$002A
DW $FFFF

T31:		;31:;Midair morphball facing right without springball
DW $0800,$0000,$003D
DW $0080,$0000,$003D
T32:		;32:;Midair morphball facing left without springball
DW $0800,$0000,$003E
DW $0080,$0000,$003E
DW $0000,$0100,$0031
DW $0000,$0200,$0032
DW $FFFF

T45:		;45:;running, facing right, shooting left. Unused? (Fast moonwalk)
DW $0000,$0240,$0045
DW $0000,$0100,$0009
DW $0000,$0200,$0025
DW $FFFF

T46:		;46:;running, facing left, shooting right. Unused? (Fast moonwalk)
DW $0000,$0140,$0046
DW $0000,$0200,$000A
DW $0000,$0100,$0026
DW $FFFF

T49:		;49:;Moonwalk, facing left
T75:		;75:;Moonwalk, facing left aiming upleft
T77:		;77:;Moonwalk, facing left aiming Downleft
DW $0400,$0000,$0036
DW $0080,$0000,$00C0
DW $0000,$0160,$0077
DW $0000,$0150,$0075
DW $0000,$0140,$0049
DW $0000,$0200,$000A
DW $0000,$0100,$0026
DW $FFFF

T4A:		;4A:;Moonwalk, facing right
T76:		;76:;Moonwalk, facing right aiming upright
T78:		;78:;Moonwalk, facing right aiming Downright
DW $0400,$0000,$0035
DW $0080,$0000,$00BF
DW $0000,$0250,$0076
DW $0000,$0260,$0078
DW $0000,$0240,$004A
DW $0000,$0100,$0009
DW $0000,$0200,$0025
DW $FFFF

T4F:		;4F:;Hurt roll back, moving right/facing left
DW $0000,$0280,$0052
DW $0000,$0180,$004F
DW $0000,$0080,$004E
DW $FFFF

T50:		;50:;Hurt roll back, moving left/facing right
DW $0000,$0280,$0050
DW $0000,$0180,$0051
DW $0000,$0080,$004D
DW $FFFF

T53:		;53:;Hurt, facing right
DW $0000,$0280,$0050
DW $FFFF

T54:		;54:;Hurt, facing left
DW $0000,$0180,$004F
DW $FFFF

T67:		;67:;Facing right, falling, fired a shot
DW $0000,$0900,$006D
DW $0000,$0500,$006F
DW $0000,$0800,$002B
DW $0000,$0400,$002D
DW $0000,$0200,$0087
DW $0000,$0010,$006D
DW $0000,$0020,$006F
DW $0000,$0040,$0067
DW $0000,$0100,$0067
DW $FFFF

T68:		;68:;Facing left, falling, fired a shot
DW $0000,$0A00,$006E
DW $0000,$0600,$0070
DW $0000,$0800,$002C
DW $0000,$0400,$002E
DW $0000,$0100,$0088
DW $0000,$0010,$006E
DW $0000,$0020,$0070
DW $0000,$0040,$0068
DW $0000,$0200,$0068
DW $FFFF

T79:		;79:;Spring ball on ground, facing right
T7B:		;7B:;Spring ball on ground, moving right
DW $0800,$0000,$003D
DW $0080,$0000,$007F
T7A:		;7A:;Spring ball on ground, facing left
T7C:		;7C:;Spring ball on ground, moving left
DW $0800,$0000,$003E
DW $0080,$0000,$0080
DW $0000,$0100,$007B
DW $0000,$0200,$007C
DW $FFFF

T7D:		;7D:;Spring ball falling, facing/moving right
DW $0800,$0000,$003D
T7E:		;7E:;Spring ball falling, facing/moving left
DW $0800,$0000,$003E
DW $0000,$0100,$007D
DW $0000,$0200,$007E
DW $FFFF

T7F:		;7F:;Spring ball jump in air, facing/moving right
DW $0800,$0000,$003D
T80:		;80:;Spring ball jump in air, facing/moving left
DW $0800,$0000,$003E
DW $0000,$0100,$007F
DW $0000,$0200,$0080
DW $FFFF

T81:		;81:;Screw attack right
DW $0040,$0000,$0013
DW $0000,$0840,$0015
DW $0000,$0440,$0017
DW $0000,$0050,$0069
DW $0000,$0060,$006B
DW $0000,$0180,$0081
DW $0000,$0800,$0015
DW $0000,$0010,$0069
DW $0000,$0020,$006B
DW $0000,$0400,$0017
DW $0000,$0100,$0081
DW $0000,$0200,$0082
DW $FFFF

T82:		;82:;Screw attack left
DW $0040,$0000,$0014
DW $0000,$0840,$0016
DW $0000,$0440,$0018
DW $0000,$0050,$006A
DW $0000,$0060,$006C
DW $0000,$0280,$0082
DW $0000,$0800,$0016
DW $0000,$0010,$006A
DW $0000,$0020,$006C
DW $0000,$0400,$0018
DW $0000,$0200,$0082
DW $0000,$0100,$0081
DW $FFFF

T83:		;83:;Walljump right
DW $0400,$0000,$0037
DW $0000,$0200,$001A
DW $0000,$0010,$0069
DW $0000,$0020,$006B
DW $0000,$0040,$0013
DW $0000,$0080,$0083
DW $FFFF

T84:		;84:;Walljump left
DW $0400,$0000,$0038
DW $0000,$0100,$0019
DW $0000,$0010,$006A
DW $0000,$0020,$006C
DW $0000,$0040,$0014
DW $0000,$0080,$0084
DW $FFFF

T89:		;89:;Ran into a wall on right (facing right)
TCF:		;CF:;Samus ran right into a wall, is still holding right and is now aiming diagonal up
TD1:		;D1:;Samus ran right into a wall, is still holding right and is now aiming diagonal Down
DW $0080,$0000,$004B
DW $0000,$0900,$000F
DW $0000,$0500,$0011
DW $0400,$0000,$0035
DW $0000,$0220,$0078
DW $0000,$0210,$0076
DW $0000,$0800,$0003
DW $0000,$0010,$0005
DW $0000,$0020,$0007
DW $0000,$0200,$0025
DW $0000,$0100,$0009
DW $FFFF

T8A:		;8A:;Ran into a wall on left (facing left)
TD0:		;D0:;Samus ran left into a wall, is still holding left and is now aiming diagonal up
TD2:		;D2:;Samus ran left into a wall, is still holding left and is now aiming diagonal Down
DW $0080,$0000,$004C
DW $0000,$0A00,$0010
DW $0000,$0600,$0012
DW $0400,$0000,$0036
DW $0000,$0120,$0077
DW $0000,$0110,$0075
DW $0000,$0800,$0004
DW $0000,$0010,$0006
DW $0000,$0020,$0008
DW $0000,$0100,$0026
DW $0000,$0200,$000A
DW $FFFF

T8B:		;8B:;Turning around from right to left while aiming straight up while standing
T8D:		;8D:;Turn around from right to left while aiming diagonal Down while standing
TBF:		;8F:;Turning around from right to left while aiming straight up in midair
TC1:		;C1:;jump/Turn right to left while moonwalking and aiming diagonal up.
TC3:		;C3:;jump/Turn right to left while moonwalking and aiming diagonal Down.
DW $0080,$0200,$001A
DW $0080,$0000,$004C
DW $FFFF

T8C:		;8C:;Turning around from left to right while aiming straight up while standing
T8E:		;8E:;Turn around from left to right while aiming diagonal Down while standing
TC0:		;C0:;jump/Turn left to right while moonwalking.
TC2:		;C2:;jump/Turn left to right while moonwalking and aiming diagonal up.
TC4:		;C4:;jump/Turn left to right while moonwalking and aiming diagonal Down.
DW $0080,$0100,$0019
DW $0080,$0000,$004B
DW $FFFF

TBA:		;BA:;Grabbed by Draygon, facing left, not moving
TBB:		;BB:;Grabbed by Draygon, facing left aiming upleft, not moving
TBC:		;BC:;Grabbed by Draygon, facing left and firing
TBD:		;BD:;Grabbed by Draygon, facing left aiming Downleft, not moving
TBE:		;BE:;Grabbed by Draygon, facing left, moving
DW $0000,$0A40,$00BB
DW $0000,$0640,$00BD
DW $0000,$0240,$00BC
DW $0000,$0010,$00BB
DW $0000,$0020,$00BD
DW $0000,$0040,$00BC
DW $0000,$0200,$00BE
DW $0000,$0100,$00BE
DW $0000,$0800,$00BE
DW $0000,$0400,$00BE
DW $FFFF

TC7:		;C7:;Super jump windup, facing right
DW $0000,$0880,$00CB
DW $0000,$0090,$00CD
DW $0000,$0180,$00C9
DW $FFFF

TC8:		;C8:;Super jump windup, facing left
DW $0000,$0880,$00CC
DW $0000,$0090,$00CE
DW $0000,$0280,$00CA
DW $FFFF

TDF:		;DF:;Samus is facing left as a morphball. Unused? (Grabbed by Draygon movement)
DW $0800,$0000,$00DE
DW $FFFF

TEC:		;EC:;Grabbed by Draygon, facing right. Not moving
TED:		;ED:;Grabbed by Draygon, facing right aiming upright. Not moving
TEE:		;EE:;Grabbed by Draygon, facing right and firing.
TEF:		;EF:;Grabbed by Draygon, facing right aiming Downright. Not moving
TF0:		;F0:;Grabbed by Draygon, facing right. Moving
DW $0000,$0940,$00ED
DW $0000,$0540,$00EF
DW $0000,$0140,$00EE
DW $0000,$0010,$00ED
DW $0000,$0020,$00EF
DW $0000,$0040,$00EE
DW $0000,$0200,$00F0
DW $0000,$0100,$00F0
DW $0000,$0800,$00F0
DW $0000,$0400,$00F0
DW $FFFF

PadByte $FF : Pad $91B00F		;$46E bytes of freespace now

;Transition Table ends right at start of Animation Frame Timer Table


ORG $91B010		;ANIMATION FRAME TIMER TABLE
;animation frame delays are positive bytes
;negative bytes are used as code indexes, high nybble is ignored, low nybble is routine index
;0-5 all CLC and RTS. (Stop at last frame)
;6 causes heavy breathing(goto next animation loop) when low on health (SEC). Else go back to start of current animation loop
;7 is used only when Samus is exhausted (MB or Metroid attack)(SEC). (Put #$94CB into $0A58, goto next animation loop)
;8 makes a lot of checks: If $0A60 is #$E91D or $0A28 is 4B, 4C, 19, or 1A, do nothing. Else put #$E926 into $0A60 and use the argument 
;		for $0A2C (same as D)
;9 checks Samus's equipment, if a certain item bit isn't equipped(first 2 bytes of argument), use 3rd byte of argument for $0A2C if 
;		Samus is moving vertically, 4th if not, 5th if item is equipped and Samus is moving vertically, 6th if not moving but equipped. 
;		0A32 = #$0003, CLC. Only used by Springball, currently.
;A If Samus isn't falling, use 1st byte of argument for $0A2C, else use second. 0A32 = #$0003, CLC
;B is used by walljumps only, I think. Hardcoded stuff, switches to screw attack, space jump, or spinjump depending on FX3, Gravity Suit, 
;		screw attack, and space jump.
;C checks Samus's equipment, if a certain item bit isn't equipped(first 2 bytes of argument), use 3rd byte of argument for $0A2C, 
;		else use 4th byte of argument for $0A2C. 0A32 = #$0003, CLC. Springball
;D uses the next byte in the animation frame list for $0A2C, 0A32 = #$0003.
;E backtracks by the argument's amount of frames (SEC). A targeted loop, basically. 
;F loops back to frame 0. SEC. Straightforward loop.

DW FD_00, FD_01, FD_02, FD_03, FD_04, FD_05, FD_06, FD_07, FD_08, FD_09, FD_0A, FD_0B, FD_0C, FD_0D, FD_0E, FD_0F
DW FD_10, FD_11, FD_12, FD_13, FD_14, FD_15, FD_16, FD_17, FD_18, FD_19, FD_1A, FD_1B, FD_1C, FD_1D, FD_1E, FD_1F
DW FD_20, FD_21, FD_22, FD_23, FD_24, FD_25, FD_26, FD_27, FD_28, FD_29, FD_2A, FD_2B, FD_2C, FD_2D, FD_2E, FD_2F
DW FD_30, FD_31, FD_32, FD_33, FD_34, FD_35, FD_36, FD_37, FD_38, FD_39, FD_3A, FD_3B, FD_3C, FD_3D, FD_3E, FD_3F
DW FD_40, FD_41, FD_42, FD_43, FD_44, FD_45, FD_46, FD_47, FD_48, FD_49, FD_4A, FD_4B, FD_4C, FD_4D, FD_4E, FD_4F
DW FD_50, FD_51, FD_52, FD_53, FD_54, FD_55, FD_56, FD_57, FD_58, FD_59, FD_5A, FD_5B, FD_5C, FD_5D, FD_5E, FD_5F
DW FD_60, FD_61, FD_62, FD_63, FD_64, FD_65, FD_66, FD_67, FD_68, FD_69, FD_6A, FD_6B, FD_6C, FD_6D, FD_6E, FD_6F
DW FD_70, FD_71, FD_72, FD_73, FD_74, FD_75, FD_76, FD_77, FD_78, FD_79, FD_7A, FD_7B, FD_7C, FD_7D, FD_7E, FD_7F
DW FD_80, FD_81, FD_82, FD_83, FD_84, FD_85, FD_86, FD_87, FD_88, FD_89, FD_8A, FD_8B, FD_8C, FD_8D, FD_8E, FD_8F
DW FD_90, FD_91, FD_92, FD_93, FD_94, FD_95, FD_96, FD_97, FD_98, FD_99, FD_9A, FD_9B, FD_9C, FD_9D, FD_9E, FD_9F
DW FD_A0, FD_A1, FD_A2, FD_A3, FD_A4, FD_A5, FD_A6, FD_A7, FD_A8, FD_A9, FD_AA, FD_AB, FD_AC, FD_AD, FD_AE, FD_AF
DW FD_B0, FD_B1, FD_B2, FD_B3, FD_B4, FD_B5, FD_B6, FD_B7, FD_B8, FD_B9, FD_BA, FD_BB, FD_BC, FD_BD, FD_BE, FD_BF
DW FD_C0, FD_C1, FD_C2, FD_C3, FD_C4, FD_C5, FD_C6, FD_C7, FD_C8, FD_C9, FD_CA, FD_CB, FD_CC, FD_CD, FD_CE, FD_CF
DW FD_D0, FD_D1, FD_D2, FD_D3, FD_D4, FD_D5, FD_D6, FD_D7, FD_D8, FD_D9, FD_DA, FD_DB, FD_DC, FD_DD, FD_DE, FD_DF
DW FD_E0, FD_E1, FD_E2, FD_E3, FD_E4, FD_E5, FD_E6, FD_E7, FD_E8, FD_E9, FD_EA, FD_EB, FD_EC, FD_ED, FD_EE, FD_EF
DW FD_F0, FD_F1, FD_F2, FD_F3, FD_F4, FD_F5, FD_F6, FD_F7, FD_F8, FD_F9, FD_FA, FD_FB, FD_FC

;$B20A
FD_09:	;Moving right, not aiming
FD_0A:	;Moving left, not aiming
FD_0B:	;Moving right, gun extended forward (not aiming)
FD_0C:	;Moving left, gun extended forward (not aiming)
FD_0D:	;Moving right, aiming straight up (unused?)
FD_0E:	;Moving left, aiming straight up (unused?)
FD_0F:	;Moving right, aiming upright
FD_10:	;Moving left, aiming upleft
FD_11:	;Moving right, aiming Downright
FD_12:	;Moving left, aiming Downleft
FD_45:	;running, facing right, shooting left. Unused? (Fast moonwalk)
FD_46:	;running, facing left, shooting right. Unused? (Fast moonwalk)
DB $02, $03, $02, $03, $02, $03, $02, $03, $02, $03, $FF
DB $04, $04, $04, $04, $04, $04, $03, $04, $04, $03, $FF
DB $0A, $FF 

;$B222
FD_03:;Facing right, aiming up
FD_04:;Facing left, aiming up
FD_85:;Crouching, facing right aiming up
FD_86:;Crouching, facing left aiming up
DB $02, $10, $FE, $01

;$B226
FD_49:	;Moonwalk, facing left
FD_4A:	;Moonwalk, facing right
FD_75:	;Moonwalk, facing left aiming upleft
FD_76:	;Moonwalk, facing right aiming upright
FD_77:	;Moonwalk, facing left aiming Downleft
FD_78:	;Moonwalk, facing right aiming Downright
DB $10, $10, $10, $10, $10, $10, $FF

;$B22D
FD_A4:	;Landing from normal jump, facing right
FD_E6:	;Landing from normal jump, facing right, firing
DB $05, $02, $F8, $01

;$B231
FD_A5:	;Landing from normal jump, facing left
FD_E7:	;Landing from normal jump, facing left, firing
DB $05, $02, $F8, $02

;$B235
FD_A6:	;Landing from spin jump, facing right
DB $03, $05, $02, $F8, $01

;$B23A
FD_A7:	;Landing from spin jump, facing left
DB $03, $05, $02, $F8, $02

;$B23F
FD_E0:	;Landing from normal jump, facing right and aiming up
DB $05, $02, $F8, $03

;$B243
FD_E1:	;Landing from normal jump, facing left and aiming up
DB $05, $02, $F8, $04

;$B247
FD_E2:	;Landing from normal jump, facing right and aiming upright
DB $05, $02, $F8, $05

;$B24B
FD_E3:	;Landing from normal jump, facing left and aiming upleft
DB $05, $02, $F8, $06

;$B24F
FD_E4:	;Landing from normal jump, facing right and aiming downright
DB $05, $02, $F8, $07

;$B253
FD_E5:	;Landing from normal jump, facing left and aiming downleft
DB $05, $02, $F8, $08

;$B257
FD_E8:	;Samus exhausted(Metroid drain, MB attack), facing right
DB $02, $02, $02, $10, $F7, $01, $FE, $01, $10, $10, $10, $10, $FE, $04, $03, $FD, $01

;$B268
FD_E9:	;Samus exhausted(Metroid drain, MB attack), facing left
DB $02, $02, $10, $F7, $01, $FE, $01, $08, $10, $10, $10, $10, $FE, $04, $10, $10
DB $10, $FD, $02, $10, $10, $10, $10, $10, $FE, $0E, $10, $FE, $11, $10, $FE, $01 

;$B288
FD_EA:	;Samus exhausted, looking up to watch Metroid attack MB, facing right
DB $10, $10, $10, $10, $FF, $03, $FD, $01

;$B290
FD_EB:	;Samus exhausted, looking up to watch Metroid attack MB, facing left
DB $10, $10, $10, $10, $FF, $03, $FD, $02

;$B298
FD_01:	;Facing right, normal
FD_02:	;Facing left, normal
DB $0A, $0A, $0A, $0A, $F6, $08, $08, $08, $08, $FE, $04 

;$B2A3
FD_27:	;Crouching, facing right
FD_28:	;Crouching, facing left
DB $0A, $0A, $0A, $0A, $F6, $08, $08, $08, $08, $FE, $04 

;$B2AE
FD_D5:	;X-raying right, standing
FD_D6:	;X-raying left, standing
FD_D9:	;X-raying right, crouching
FD_DA:	;X-raying left, crouching
DB $0F, $0F, $0F, $0F, $0F, $FF

;$B2B4
FD_05:	;Facing right, aiming upright
FD_06:	;Facing left, aiming upleft
FD_07:	;Facing right, aiming downright
FD_08:	;Facing left, aiming downleft
FD_47:	;Standing, facing right. Unused?
FD_48:	;Standing, facing left. Unused?
FD_71:	;Standing to crouching, facing right and aiming upright
FD_72:	;Standing to crouching, facing left and aiming upleft
FD_73:	;Standing to crouching, facing right and aiming downright
FD_74:	;Standing to crouching, facing left and aiming downleft
FD_89:	;Ran into a wall on right (facing right)
FD_8A:	;Ran into a wall on left (facing left)
FD_B4:	;Crouching, facing right. Unused? (Grapple movement)
FD_B5:	;Crouching, facing left. Unused? (Grapple movement)
FD_B6:	;Crouching, facing right, aiming downright. Unused? (Grapple movement)
FD_B7:	;Crouching, facing left, aiming downleft. Unused? (Grapple movement)
FD_B8:	;Grapple, attached to a wall on right, facing left
FD_B9:	;Grapple, attached to a wall on left, facing right
FD_BA:	;Grabbed by Draygon, facing left, not moving
FD_BB:	;Grabbed by Draygon, facing left aiming upleft, not moving
FD_BC:	;Grabbed by Draygon, facing left and firing
FD_BD:	;Grabbed by Draygon, facing left aiming downleft, not moving
FD_CF:	;Samus ran right into a wall, is still holding right and is now aiming diagonal up
FD_D0:	;Samus ran left into a wall, is still holding left and is now aiming diagonal up
FD_D1:	;Samus ran right into a wall, is still holding right and is now aiming diagonal down
FD_D2:	;Samus ran left into a wall, is still holding left and is now aiming diagonal down
FD_EC:	;Grabbed by Draygon, facing right. Not moving
FD_ED:	;Grabbed by Draygon, facing right aiming upright. Not moving
FD_EE:	;Grabbed by Draygon, facing right and firing.
FD_EF:	;Grabbed by Draygon, facing right aiming downright. Not moving
DB $10, $FF

;$B2B6
FD_A8:	;Just standing, facing right. Unused? (Grapple movement)
FD_A9:	;Just standing, facing left. Unused? (Grapple movement)
FD_AA:	;Just standing, facing right aiming downright. Unused? (Grapple movement)
FD_AB:	;Just standing, facing left aiming downleft. Unused? (Grapple movement)
DB $10, $FF

;$B2B8
FD_AC:	;Jumping, facing right, gun extended. Unused? (Grapple movement)
FD_AD:	;Jumping, facing left, gun extended. Unused? (Grapple movement)
DB $02, $10, $FE, $01

;$B2BC
FD_AE:	;Jumping, facing right, aiming down. Unused? (Grapple movement)
FD_AF:	;Jumping, facing left, aiming down. Unused? (Grapple movement)
DB $02, $10, $FE, $01

;$B2C0
FD_B0:	;Jumping, facing right, aiming downright. Unused? (Grapple movement)
FD_B1:	;Jumping, facing left, aiming downleft. Unused? (Grapple movement)
DB $02, $10, $FE, $01

;$B2C4
FD_B2:	;Grapple, facing clockwise
FD_B3:	;Grapple, facing counterclockwise
DB $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08 
DB $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08 
DB $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08 
DB $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08
DB $08, $08, $FE, $01 

;$B308
FD_4B:	;Normal jump transition from ground(standing or crouching), facing right
DB $01, $FD, $4D 

;$B30B
FD_4C:	;Normal jump transition from ground(standing or crouching), facing left
DB $01, $FD, $4E 

;$B30E
FD_55:	;Normal jump transition from ground, facing right and aiming up
DB $01, $FD, $15, $00 

;$B312
FD_56:	;Normal jump transition from ground, facing left and aiming up
DB $01, $FD, $16, $00 

;$B316
FD_57:	;Normal jump transition from ground, facing right and aiming upright
DB $01, $FD, $69, $00 

;$B31A
FD_58:	;Normal jump transition from ground, facing left and aiming upleft
DB $01, $FD, $6A, $00 

;$B31E
FD_59:	;Normal jump transition from ground, facing right and aiming downright
DB $01, $FD, $6B, $00 

;$B322
FD_5A:	;Normal jump transition from ground, facing left and aiming downleft
DB $01, $FD, $6C, $00 

;$B326
FD_4D:	;Normal jump facing right, gun not extended, not aiming, not moving
FD_4E:	;Normal jump facing left, gun not extended, not aiming, not moving
FD_C7:	;Super jump windup, facing right
FD_C8:	;Super jump windup, facing left
DB $03, $04, $04, $04, $04, $50, $FE, $01 

;$B32E
FD_4F:	;Hurt roll back, moving right/facing left
FD_50:	;Hurt roll back, moving left/facing right
DB $08, $02, $02, $02, $02, $02, $02, $02, $02, $02, $FE, $01 

;$B33A
FD_15:	;Normal jump facing right, aiming up
FD_16:	;Normal jump facing left, aiming up
DB $02, $10, $FE, $01 

;$B33E
FD_17:	;Normal jump facing right, aiming down
FD_18:	;Normal jump facing left, aiming down
DB $02, $10, $FE, $01 

;$B342
FD_51:	;Normal jump facing right, moving forward (gun extended)
FD_52:	;Normal jump facing left, moving forward (gun extended)
DB $02, $03, $FE, $01 

;$B346
FD_13:	;Normal jump facing right, gun extended, not aiming or moving
FD_14:	;Normal jump facing left, gun extended, not aiming or moving
FD_69:	;Normal jump facing right, aiming upright. Moving optional
FD_6A:	;Normal jump facing left, aiming upleft. Moving optional
FD_6B:	;Normal jump facing right, aiming downright. Moving optional
FD_6C:	;Normal jump facing left, aiming downleft. Moving optional
DB $02, $10, $FE, $01 

;$B34A
FD_29:	;Falling facing right, normal pose
FD_2A:	;Falling facing left, normal pose
DB $08, $06, $06, $FE, $01, $08, $10, $FE, $01 

;$B353
FD_67:	;Facing right, falling, fired a shot
FD_68:	;Facing left, falling, fired a shot
DB $08, $06, $06, $FE, $01, $08, $10, $FE, $01 

;$B35C
FD_2B:	;Falling facing right, aiming up
FD_2C:	;Falling facing left, aiming up
DB $02, $10, $10, $FE, $01 

;$B361
FD_6D:	;Falling facing right, aiming upright
FD_6E:	;Falling facing left, aiming upleft
FD_6F:	;Falling facing right, aiming downright
FD_70:	;Falling facing left, aiming downleft
DB $02, $F0, $10, $FE, $01 

;$B366
FD_2D:	;Falling facing right, aiming down
FD_2E:	;Falling facing left, aiming down
DB $02, $10, $FE, $01

;$B36A
FD_53:	;Hurt, facing right
FD_54:	;Hurt, facing left
DB $02, $10, $FE, $01, $06, $06, $06, $08, $FF, $08, $08, $FF, $0A, $FF 

;$B378
FD_1D:	;Facing right as morphball, no springball
FD_1E:	;Moving right as a morphball on ground without springball
FD_1F:	;Moving left as a morphball on ground without springball
FD_20:	;Spinjump right. Unused?
FD_21:	;Spinjump right. Unused?
FD_22:	;Spinjump right. Unused?
FD_23:	;Spinjump right. Unused?
FD_24:	;Spinjump right. Unused?
FD_31:	;Midair morphball facing right without springball
FD_32:	;Midair morphball facing left without springball
FD_33:	;Spinjump right. Unused?
FD_34:	;Spinjump right. Unused?
FD_41:	;Staying still with morphball, facing left, no springball
FD_42:	;Spinjump right. Unused?
FD_5B:	;Something for grapple (wall jump?), probably unused
FD_5C:	;Something for grapple (wall jump?), probably unused
FD_5D:	;Broken grapple? Facing clockwise, maybe unused
FD_5E:	;Broken grapple? Facing clockwise, maybe unused
FD_5F:	;Broken grapple? Facing clockwise, maybe unused
FD_60:	;Better broken grapple. Facing clockwise, maybe unused
FD_61:	;Nearly normal grapple. Facing clockwise, maybe unused
FD_62:	;Nearly normal grapple. Facing counterclockwise, maybe unused
FD_79:	;Spring ball on ground, facing right
FD_7A:	;Spring ball on ground, facing left
FD_7B:	;Spring ball on ground, moving right
FD_7C:	;Spring ball on ground, moving left
FD_7D:	;Spring ball falling, facing/moving right
FD_7E:	;Spring ball falling, facing/moving left
FD_7F:	;Spring ball jump in air, facing/moving right
FD_80:	;Spring ball jump in air, facing/moving left
FD_C5:	;Morph ball, facing right. Unused? (Grabbed by Draygon movement)
FD_DF:	;Samus is facing left as a morphball. Unused? (Grabbed by Draygon movement)
DB $03, $03, $03, $03, $03, $03, $03, $03, $FF, $03, $FE, $0A

;$B384
FD_19:	;Spin Jump right
FD_1A:	;Spin Jump left
DB $04, $03, $02, $03, $02, $03, $02, $03, $02, $FE, $08, $08, $FF 

;$B391
FD_1B:	;Space jump right
FD_1C:	;Space jump left
DB $04, $01, $01, $01, $01, $01, $01, $01, $01, $FE, $08, $08, $FF 

;$B39E
FD_81:	;Screw attack right
FD_82:	;Screw attack left
DB $04, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
DB $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $FE, $18, $08, $FF 

;$B3BB
FD_25:	;Starting standing right, turning left
DB $02, $02, $02, $F8, $02 

;$B3C0
FD_26:	;Starting standing left, turning right
DB $02, $02, $02, $F8, $01 

;$B3C5
FD_2F:	;Starting with normal jump facing right, turning left
DB $02, $02, $02, $F8, $52 

;$B3CA
FD_30:	;Starting with normal jump facing left, turning right
DB $02, $02, $02, $F8, $51 

;$B3CF
FD_43:	;Starting from crouching right, turning left
DB $02, $02, $02, $F8, $28 

;$B3D4
FD_44:	;Starting from crouching left, turning right
DB $02, $02, $02, $F8, $27 

;$B3D9
FD_87:	;Turning from right to left while falling
DB $02, $02, $02, $F8, $2A 

;$B3DE
FD_88:	;Turning from left to right while falling
DB $02, $02, $02, $F8, $29 

;$B3E3
FD_8B:	;Turning around from right to left while aiming straight up while standing
DB $02, $02, $02, $F8, $04 

;$B3E8
FD_8C:	;Turning around from left to right while aiming straight up while standing
DB $02, $02, $02, $F8, $03 

;$B3ED
FD_8D:	;Turn around from right to left while aiming diagonal down while standing
DB $02, $02, $02, $F8, $08 

;$B3F2
FD_8E:	;Turn around from left to right while aiming diagonal down while standing
DB $02, $02, $02, $F8, $07 

;$B3F7
FD_8F:	;Turning around from right to left while aiming straight up in midair
DB $02, $02, $02, $F8, $16 

;$B3FC
FD_90:	;Turning around from left to right while aiming straight up in midair
DB $02, $02, $02, $F8, $15 

;$B401
FD_91:	;Turning around from right to left while aiming down or diagonal down in midair
DB $02, $02, $02, $F8, $18 

;$B406
FD_92:	;Turning around from left to right while aiming down or diagonal down in midair
DB $02, $02, $02, $F8, $17 

;$B40B
FD_93:	;Turning around from right to left while aiming straight up while falling
DB $02, $02, $02, $F8, $2C 

;$B410
FD_94:	;Turning around from left to right while aiming straight up while falling
DB $02, $02, $02, $F8, $2B 

;$B415
FD_95:	;Turning around from right to left while aiming down or diagonal down while falling
DB $02, $02, $02, $F8, $2E 

;$B41A
FD_96:	;Turning around from left to right while aiming down or diagonal down while falling
DB $02, $02, $02, $F8, $2D 

;$B41F
FD_97:	;Turning around from right to left while aiming straight up while crouching
DB $02, $02, $02, $F8, $86 

;$B424
FD_98:	;Turning around from left to right while aiming straight up while crouching
DB $02, $02, $02, $F8, $85 

;$B429
FD_99:	;Turning around from right to left while aiming diagonal down while crouching
DB $02, $02, $02, $F8, $74 

;$B42E
FD_9A:	;Turning around from left to right while aiming diagonal down while crouching
DB $02, $02, $02, $F8, $73 

;$B433 
FD_9C:	;Turning around from right to left while aiming diagonal up while standing
DB $02, $02, $02, $F8, $06 

;$B438
FD_9D:	;Turning around from left to right while aiming diagonal up while standing
DB $02, $02, $02, $F8, $05 

;$B43D
FD_9E:	;Turning around from right to left while aiming diagonal up in midair
DB $02, $02, $02, $F8, $6A 

;$B442 
FD_9F:	;Turning around from left to right while aiming diagonal up in midair
DB $02, $02, $02, $F8, $69 

;$B447
FD_A0:	;Turning around from right to left while aiming diagonal up while falling
DB $02, $02, $02, $F8, $6E 

;$B44C
FD_A1:	;Turning around from left to right while aiming diagonal up while falling
DB $02, $02, $02, $F8, $6D 

;$B451
FD_A2:	;Turn around from right to left while aiming diagonal up while crouching
DB $02, $02, $02, $F8, $72 

;$B456
FD_A3:	;Turn around from left to right while aiming diagonal up while crouching
DB $02, $02, $02, $F8, $71 

;$B45B
FD_BF:	;Jump/Turn right to left while moonwalking.
DB $02, $02, $02, $F8, $1A 

;$B460
FD_C0:	;Jump/Turn left to right while moonwalking.
DB $02, $02, $02, $F8, $19 

;$B465
FD_C1:	;Jump/Turn right to left while moonwalking and aiming diagonal up.
DB $02, $02, $02, $F8, $1A 

;$B46A
FD_C2:	;Jump/Turn left to right while moonwalking and aiming diagonal up.
DB $02, $02, $02, $F8, $19 

;$B46F
FD_C3:	;Jump/Turn right to left while moonwalking and aiming diagonal down.
DB $02, $02, $02, $F8, $1A 

;$B474
FD_C4:	;Jump/Turn left to right while moonwalking and aiming diagonal down.
DB $02, $02, $02, $F8, $19 

;$B479
FD_C6:	;Morph ball, facing left. Unused? (Grabbed by Draygon movement)
DB $02, $02, $02, $FD, $BA 

;$B47E
FD_63:	;Facing left on grapple blocks, ready to jump. Unused?
DB $04, $03, $FE, $01

;$B482
FD_64:	;Facing right on grapple blocks, ready to jump. Unused?
DB $04, $03, $FE, $01

;$B486
FD_65:	;Glitchy jump, facing left. Used by unused grapple jump?
FD_66:	;Glitchy jump, facing right. Used by unused grapple jump?
DB $03, $02, $02, $02, $02, $02, $02, $02, $02, $FE, $08 

;$B491
FD_83:	;Walljump right
FD_84:	;Walljump left
DB $05, $05, $FB, $03, $02, $03, $02, $03, $02, $03, $02, $FE, $08, $02, $01, $02 
DB $01, $02, $01, $02, $01, $FE, $08, $01, $01, $01, $01, $01, $01, $01, $01, $01 
DB $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $FE, $18 

;$B4C2
FD_35:	;Crouch transition, facing right
DB $03, $FD, $27

;$B4C5
FD_36:	;Crouch transition, facing left
DB $03, $FD, $28

;$B4C8
FD_37:	;Morphing into ball, facing right. Ground and mid-air
DB $03, $03, $F9
DW $0002
DB $1D, $31, $79, $7D 

;$B4D1
FD_38:	;Morphing into ball, facing left. Ground and mid-air
DB $03, $03, $F9
DW $0002
DB $41, $32, $7A, $7E 

;$B4DA
FD_39:	;Midair morphing into ball, facing right? May be unused
DB $00, $FD, $20

;$B4DD
FD_3A:	;Midair morphing into ball, facing left? May be unused
DB $00, $FD, $42

;$B4E0
FD_3B:	;Standing from crouching, facing right
DB $03, $FD, $01

;$B4E3
FD_3C:	;Standing from crouching, facing left
DB $03, $FD, $02

;$B4E6
FD_3D:	;Demorph while facing right. Mid-air and on ground
DB $03, $03, $FD, $27

;$B4EA
FD_3E:	;Demorph while facing left. Mid-air and on ground
DB $03, $03, $FD, $28

;$B4EE
FD_3F:	;Some transition with morphball, facing right. Maybe unused
DB $00, $FC
DW $0002
DB $1D, $79 

;$B4F4
FD_40:	;Some transition with morphball, facing left. Maybe unused
DB $00, $FC
DW $0002
DB $41, $7A 

;$B4FA
FD_DB:	;Standing transition to morphball, facing right? Unused?
DB $03, $03, $03, $F9
DW $0002
DB $1D, $31, $79, $7D 

;$B504
FD_DC:	;Standing transition to morphball, facing left? Unused?
DB $03, $03, $03, $F9
DW $0002
DB $DF, $DF, $DF, $DF

;$B50E
FD_DD:	;Morphball transition to standing, facing right? Unused?
DB $03, $03, $03, $FD, $01 

;$B513
FD_DE:	;Morphball transition to standing, facing left? Unused?
DB $03, $03, $03, $FD, $BA

;$B518
FD_F1:	;Crouch transition, facing right and aiming up
DB $03, $FD, $85

;$B51B
FD_F2:	;Crouch transition, facing left and aiming up
DB $03, $FD, $86

;$B51E
FD_F3:	;Crouch transition, facing right and aiming upright
DB $03, $FD, $71

;$B521
FD_F4:	;Crouch transition, facing left and aiming upleft
DB $03, $FD, $72

;$B524
FD_F5:	;Crouch transition, facing right and aiming downright
DB $03, $FD, $73

;$B527
FD_F6:	;Crouch transition, facing left and aiming downleft
DB $03, $FD, $74

;$B52A
FD_F7:	;Crouching to standing, facing right and aiming up
DB $03, $FD, $03

;$B52D
FD_F8:	;Crouching to standing, facing left and aiming up
DB $03, $FD, $04

;$B530
FD_F9:	;Crouching to standing, facing right and aiming upright
DB $03, $FD, $05

;$B533
FD_FA:	;Crouching to standing, facing left and aiming upleft
DB $03, $FD, $06

;$B536
FD_FB:	;Crouching to standing, facing right and aiming downright
DB $03, $FD, $07

;$B539
FD_FC:	;Crouching to standing, facing left and aiming downleft
DB $03, $FD, $08

;$B53C
FD_BE:	;Grabbed by Draygon, facing left, moving
FD_F0:	;Grabbed by Draygon, facing right. Moving
DB $06, $06, $06, $06, $06, $06, $FF 

;$B543
FD_C9:	;Horizontal super jump, right
FD_CA:	;Horizontal super jump, left
FD_CB:	;Vertical super jump, facing right
FD_CC:	;Vertical super jump, facing left
FD_CD:	;Diagonal super jump, right
FD_CE:	;Diagonal super jump, left
DB $08, $FF 

;$B545
FD_D3:	;Crystal flash, facing right
DB $03, $03, $01, $01, $FE, $02, $0C, $0C, $0C, $0C, $FE, $04, $03, $03, $03, $FD, $01 

;$B556
FD_D4:	;Crystal flash, facing left
DB $03, $03, $01, $01, $FE, $02, $0C, $0C, $0C, $0C, $FE, $04, $03, $03, $03, $FD, $02 

;$B567
FD_D7:	;Crystal flash ending, facing right
FD_D8:	;Crystal flash ending, facing left
DB $02, $02, $02, $02, $02, $02, $FE, $01

;$B56F
FD_00:	;Facing forward, ala Elevator pose.
FD_9B:	;Facing forward, ala Elevator pose... with the Varia and/or Gravity Suit.
DB $08, $FF 

;$B571	;FOLLOWING IS APPARENTLY UNUSED?  THIS IS NEVER POINTED TO...
DB $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03 
DB $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03 
DB $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03 
DB $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03 
DB $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03 
DB $03, $03, $03, $03, $03, $03, $03, $03, $03, $33, $02, $02, $02, $30, $FE, $01 


org $91B5D1		;Pointed to by $908517		LDA $91B5D1[$91:B5D1]
				;Pointed to by $908566		LDA $91B5D1[$91:B5D1]
DW $B5D3
;$B5D3			UNKNOWN WHAT ANIMATION THIS IS FOR
DB $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $FF

org $91B5DE		;Pointed to by $90850F		LDA $91B5DE,x[$91:B5DE]
		;used to increase animation speed while running with speedbooster
DW $B5E8, $B5F3, $B5FE, $B609, $B614
org $91B5E8
DB $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $FF
org $91B5F3
DB $02, $03, $02, $03, $02, $03, $02, $03, $02, $03, $FF
org $91B5FE
DB $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $FF
org $91B609
DB $01, $02, $01, $02, $01, $02, $01, $02, $01, $02, $FF
org $91B614
DB $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $FF

org $91B61F		;Pointed to by $9097A2		LDA $91B61F[$91:B61F]
DB $01, $00, $01, $00, $01, $00, $01, $00, $02, $00
;this animation timer bleeds over into the pose definition table...   >.>  
;Animation Frame Timer Table ends right at start of Pose Definiton Table


ORG $91B629		;POSE DEFINITIONS
;First byte is the direction Samus is facing. 
;Second byte is the movement type. They're often used together for simplicity.
;Third byte is used as value for 0A28 if button check reaches an FFFF (see TransitionTable.txt)
;Fourth byte is direction for firing shots.
;Fifth byte is vertical displacement. Samus's hitbox is not affected, but her graphic is, and her shots are displaced as well
;Sixth byte unused. 
;Seventh byte is vertical radius. 
;Eighth byte is unused.
DB $00, $00, $FF, $FF, $08, $00, $18, $00 ;T00:;Facing forward, ala Elevator pose (power suit)
DB $08, $00, $FF, $02, $06, $00, $15, $00 ;T01:;Facing right, normal
DB $04, $00, $FF, $07, $06, $00, $15, $00 ;T02:;Facing left, normal
DB $08, $00, $01, $00, $06, $00, $15, $00 ;T03:;Facing right, aiming up
DB $04, $00, $02, $09, $06, $00, $15, $00 ;T04:;Facing left, aiming up
DB $08, $00, $01, $01, $06, $00, $15, $00 ;T05:;Facing right, aiming upright
DB $04, $00, $02, $08, $06, $00, $15, $00 ;T06:;Facing left, aiming upleft
DB $08, $00, $01, $03, $06, $00, $15, $00 ;T07:;Facing right, aiming Downright
DB $04, $00, $02, $06, $06, $00, $15, $00 ;T08:;Facing left, aiming Downleft
DB $08, $01, $01, $02, $06, $00, $15, $00 ;T09:;Moving right, not aiming
DB $04, $01, $02, $07, $06, $00, $15, $00 ;T0A:;Moving left, not aiming
DB $08, $01, $01, $02, $06, $00, $15, $00 ;T0B:;Moving right, gun extended forward (not aiming)
DB $04, $01, $02, $07, $06, $00, $15, $00 ;T0C:;Moving left, gun extended forward (not aiming)
DB $08, $01, $01, $00, $06, $00, $15, $00 ;T0D:;Moving right, aiming straight up (unused?)
DB $04, $01, $02, $09, $06, $00, $15, $00 ;T0E:;Moving left, aiming straight up (unused?)
DB $08, $01, $01, $01, $06, $00, $15, $00 ;T0F:;Moving right, aiming upright
DB $04, $01, $02, $08, $06, $00, $15, $00 ;T10:;Moving left, aiming upleft
DB $08, $01, $01, $03, $06, $00, $15, $00 ;T11:;Moving right, aiming Downright
DB $04, $01, $02, $06, $06, $00, $15, $00 ;T12:;Moving left, aiming Downleft
DB $08, $02, $FF, $02, $08, $00, $13, $00 ;T13:;Normal jump facing right, gun extended, not aiming or moving
DB $04, $02, $FF, $07, $08, $00, $13, $00 ;T14:;Normal jump facing left, gun extended, not aiming or moving
DB $08, $02, $51, $00, $08, $00, $13, $00 ;T15:;Normal jump facing right, aiming up
DB $04, $02, $52, $09, $08, $00, $13, $00 ;T16:;Normal jump facing left, aiming up
DB $08, $02, $FF, $04, $06, $00, $0A, $00 ;T17:;Normal jump facing right, aiming Down
DB $04, $02, $FF, $05, $06, $00, $0A, $00 ;T18:;Normal jump facing left, aiming Down
DB $08, $03, $FF, $FF, $00, $00, $0C, $00 ;T19:;Spin jump right
DB $04, $03, $FF, $FF, $00, $00, $0C, $00 ;T1A:;Spin jump left
DB $08, $03, $FF, $FF, $00, $00, $0C, $00 ;T1B:;Space jump right
DB $04, $03, $FF, $FF, $00, $00, $0C, $00 ;T1C:;Space jump left
DB $08, $04, $FF, $FF, $00, $00, $07, $00 ;T1D:;Facing right as morphball, no springball
DB $08, $04, $1D, $FF, $00, $00, $07, $00 ;T1E:;Moving right as a morphball on ground without springball
DB $04, $04, $41, $FF, $00, $00, $07, $00 ;T1F:;Moving left as a morphball on ground without springball
DB $08, $07, $FF, $FF, $00, $00, $07, $00 ;T20:;Spinjump right. Unused?
DB $01, $07, $20, $FF, $00, $00, $07, $00 ;T21:;Spinjump right. Unused?
DB $02, $07, $20, $FF, $00, $00, $07, $00 ;T22:;Spinjump right. Unused?
DB $04, $07, $42, $FF, $00, $00, $07, $00 ;T23:;Spinjump right. Unused?
DB $08, $07, $20, $FF, $00, $00, $07, $00 ;T24:;Spinjump right. Unused?
DB $04, $0E, $FF, $FB, $06, $00, $15, $00 ;T25:;starting standing right, turning left
DB $08, $0E, $FF, $FB, $06, $00, $15, $00 ;T26:;starting standing left, turning right
DB $08, $05, $27, $02, $00, $00, $10, $00 ;T27:;Crouching, facing right
DB $04, $05, $28, $07, $00, $00, $10, $00 ;T28:;Crouching, facing left
DB $08, $06, $FF, $02, $08, $00, $13, $00 ;T29:;Falling facing right, normal pose
DB $04, $06, $FF, $07, $08, $00, $13, $00 ;T2A:;Falling facing left, normal pose
DB $08, $06, $29, $00, $08, $00, $13, $00 ;T2B:;Falling facing right, aiming up
DB $04, $06, $2A, $09, $08, $00, $13, $00 ;T2C:;Falling facing left, aiming up
DB $08, $06, $FF, $04, $06, $00, $0A, $00 ;T2D:;Falling facing right, aiming Down
DB $04, $06, $FF, $05, $06, $00, $0A, $00 ;T2E:;Falling facing left, aiming Down
DB $04, $17, $FF, $FB, $08, $00, $13, $00 ;T2F:;starting with normal jump facing right, turning left
DB $08, $17, $FF, $FB, $08, $00, $13, $00 ;T30:;starting with normal jump facing left, turning right
DB $08, $08, $FF, $FF, $00, $00, $07, $00 ;T31:;Midair morphball facing right without springball
DB $04, $08, $FF, $FF, $00, $00, $07, $00 ;T32:;Midair morphball facing left without springball
DB $08, $09, $FF, $FF, $00, $00, $07, $00 ;T33:;Spinjump right. Unused?
DB $04, $09, $FF, $FF, $00, $00, $07, $00 ;T34:;Spinjump right. Unused?
DB $08, $0F, $FF, $02, $00, $00, $10, $00 ;T35:;Crouch transition, facing right
DB $04, $0F, $FF, $07, $00, $00, $10, $00 ;T36:;Crouch transition, facing left
DB $08, $0F, $FF, $FF, $00, $00, $07, $00 ;T37:;Morphing into ball, facing right. Ground and mid-air
DB $04, $0F, $FF, $FF, $00, $00, $07, $00 ;T38:;Morphing into ball, facing left. Ground and mid-air
DB $08, $0F, $FF, $FF, $00, $00, $07, $00 ;T39:;Midair morphing into ball, facing right? May be unused
DB $04, $0F, $FF, $FF, $00, $00, $07, $00 ;T3A:;Midair morphing into ball, facing left? May be unused
DB $08, $0F, $FF, $02, $06, $00, $15, $00 ;T3B:;Standing from crouching, facing right
DB $04, $0F, $FF, $07, $06, $00, $15, $00 ;T3C:;Standing from crouching, facing left
DB $08, $0F, $FF, $FF, $00, $00, $10, $00 ;T3D:;Demorph while facing right. Mid-air and on ground
DB $04, $0F, $FF, $FF, $00, $00, $10, $00 ;T3E:;Demorph while facing left. Mid-air and on ground
DB $08, $0F, $FF, $FF, $00, $00, $07, $00 ;T3F:;Some transition with morphball, facing right. Maybe unused
DB $04, $0F, $FF, $FF, $00, $00, $07, $00 ;T40:;Some transition with morphball, facing left. Maybe unused
DB $04, $04, $FF, $FF, $00, $00, $07, $00 ;T41:;Staying still with morphball, facing left, no springball
DB $04, $07, $FF, $FF, $00, $00, $07, $00 ;T42:;Spinjump right. Unused?
DB $04, $0E, $FF, $FB, $00, $00, $10, $00 ;T43:;starting from crouching right, turning left
DB $08, $0E, $FF, $FB, $00, $00, $10, $00 ;T44:;starting from crouching left, turning right
DB $08, $01, $01, $07, $06, $00, $15, $00 ;T45:;running, facing right, shooting left. Unused? (Fast moonwalk)
DB $04, $01, $02, $02, $06, $00, $15, $00 ;T46:;running, facing left, shooting right. Unused? (Fast moonwalk)
DB $08, $00, $FF, $02, $06, $00, $15, $00 ;T47:;Standing, facing right. Unused?
DB $04, $00, $FF, $07, $06, $00, $15, $00 ;T48:;Standing, facing left. Unused?
DB $08, $10, $02, $07, $06, $00, $15, $00 ;T49:;Moonwalk, facing left
DB $04, $10, $01, $02, $06, $00, $15, $00 ;T4A:;Moonwalk, facing right
DB $08, $02, $FF, $02, $03, $00, $13, $00 ;T4B:;Normal jump transition from ground(standing or crouching), facing right
DB $04, $02, $FF, $07, $03, $00, $13, $00 ;T4C:;Normal jump transition from ground(standing or crouching), facing left
DB $08, $02, $FF, $02, $08, $00, $13, $00 ;T4D:;Normal jump facing right, gun not extended, not aiming, not moving
DB $04, $02, $FF, $07, $08, $00, $13, $00 ;T4E:;Normal jump facing left, gun not extended, not aiming, not moving
DB $08, $19, $4E, $FF, $08, $00, $13, $00 ;T4F:;Hurt roll back, moving right/facing left
DB $04, $19, $4D, $FF, $08, $00, $13, $00 ;T50:;Hurt roll back, moving left/facing right
DB $08, $02, $FF, $02, $08, $00, $13, $00 ;T51:;Normal jump facing right, moving forward (gun extended)
DB $04, $02, $FF, $07, $08, $00, $13, $00 ;T52:;Normal jump facing left, moving forward (gun extended)
DB $08, $0A, $FF, $FF, $06, $00, $15, $00 ;T53:;Hurt, facing right
DB $04, $0A, $FF, $FF, $06, $00, $15, $00 ;T54:;Hurt, facing left
DB $08, $02, $FF, $00, $03, $00, $13, $00 ;T55:;Normal jump transition from ground, facing right and aiming up
DB $04, $02, $FF, $09, $03, $00, $13, $00 ;T56:;Normal jump transition from ground, facing left and aiming up
DB $08, $02, $FF, $01, $03, $00, $13, $00 ;T57:;Normal jump transition from ground, facing right and aiming upright
DB $04, $02, $FF, $08, $03, $00, $13, $00 ;T58:;Normal jump transition from ground, facing left and aiming upleft
DB $08, $02, $FF, $03, $03, $00, $13, $00 ;T59:;Normal jump transition from ground, facing right and aiming Downright
DB $04, $02, $FF, $06, $03, $00, $13, $00 ;T5A:;Normal jump transition from ground, facing left and aiming Downleft
DB $08, $16, $FF, $FF, $10, $00, $10, $00 ;T5B:;Something for grapple (wall jump?), probably unused
DB $04, $16, $FF, $FF, $10, $00, $10, $00 ;T5C:;Something for grapple (wall jump?), probably unused
DB $08, $0B, $5D, $FF, $10, $00, $10, $00 ;T5D:;Broken grapple? Facing clockwise, maybe unused
DB $04, $0B, $5E, $FF, $10, $00, $10, $00 ;T5E:;Broken grapple? Facing clockwise, maybe unused
DB $08, $0B, $5F, $FF, $10, $00, $10, $00 ;T5F:;Broken grapple? Facing clockwise, maybe unused
DB $04, $0B, $60, $FF, $10, $00, $10, $00 ;T60:;Better broken grapple. Facing clockwise, maybe unused
DB $08, $16, $B2, $FF, $10, $00, $10, $00 ;T61:;Nearly normal grapple. Facing clockwise, maybe unused
DB $04, $16, $B3, $FF, $10, $00, $10, $00 ;T62:;Nearly normal grapple. Facing counterclockwise, maybe unused
DB $08, $0D, $FF, $FF, $0C, $00, $0C, $00 ;T63:;Facing left on grapple blocks, ready to jump. Unused?
DB $04, $0D, $FF, $FF, $0C, $00, $0C, $00 ;T64:;Facing right on grapple blocks, ready to jump. Unused?
DB $08, $0D, $29, $FF, $0C, $00, $0C, $00 ;T65:;Glitchy jump, facing left. Used by unused grapple jump?
DB $04, $0D, $2A, $FF, $0C, $00, $0C, $00 ;T66:;Glitchy jump, facing right. Used by unused grapple jump?
DB $08, $06, $FF, $02, $08, $00, $13, $00 ;T67:;Facing right, falling, fired a shot
DB $04, $06, $FF, $07, $08, $00, $13, $00 ;T68:;Facing left, falling, fired a shot
DB $08, $02, $51, $01, $08, $00, $13, $00 ;T69:;Normal jump facing right, aiming upright. Moving optional
DB $04, $02, $52, $08, $08, $00, $13, $00 ;T6A:;Normal jump facing left, aiming upleft. Moving optional
DB $08, $02, $51, $03, $08, $00, $13, $00 ;T6B:;Normal jump facing right, aiming Downright. Moving optional
DB $04, $02, $52, $06, $08, $00, $13, $00 ;T6C:;Normal jump facing left, aiming Downleft. Moving optional
DB $08, $06, $29, $01, $08, $00, $13, $00 ;T6D:;Falling facing right, aiming upright
DB $04, $06, $2A, $08, $08, $00, $13, $00 ;T6E:;Falling facing left, aiming upleft
DB $08, $06, $29, $03, $08, $00, $13, $00 ;T6F:;Falling facing right, aiming Downright
DB $04, $06, $2A, $06, $08, $00, $13, $00 ;T70:;Falling facing left, aiming Downleft
DB $08, $05, $27, $01, $00, $00, $10, $00 ;T71:;Standing to crouching, facing right and aiming upright
DB $04, $05, $28, $08, $00, $00, $10, $00 ;T72:;Standing to crouching, facing left and aiming upleft
DB $08, $05, $27, $03, $00, $00, $10, $00 ;T73:;Standing to crouching, facing right and aiming Downright
DB $04, $05, $28, $06, $00, $00, $10, $00 ;T74:;Standing to crouching, facing left and aiming Downleft
DB $08, $10, $06, $08, $06, $00, $15, $00 ;T75:;Moonwalk, facing left aiming upleft
DB $04, $10, $05, $01, $06, $00, $15, $00 ;T76:;Moonwalk, facing right aiming upright
DB $08, $10, $08, $06, $06, $00, $15, $00 ;T77:;Moonwalk, facing left aiming Downleft
DB $04, $10, $07, $03, $06, $00, $15, $00 ;T78:;Moonwalk, facing right aiming Downright
DB $08, $11, $FF, $FF, $00, $00, $07, $00 ;T79:;Spring ball on ground, facing right
DB $04, $11, $FF, $FF, $00, $00, $07, $00 ;T7A:;Spring ball on ground, facing left
DB $08, $11, $79, $FF, $00, $00, $07, $00 ;T7B:;Spring ball on ground, moving right
DB $04, $11, $7A, $FF, $00, $00, $07, $00 ;T7C:;Spring ball on ground, moving left
DB $08, $13, $FF, $FF, $00, $00, $07, $00 ;T7D:;Spring ball falling, facing/moving right
DB $04, $13, $FF, $FF, $00, $00, $07, $00 ;T7E:;Spring ball falling, facing/moving left
DB $08, $12, $FF, $FF, $00, $00, $07, $00 ;T7F:;Spring ball jump in air, facing/moving right
DB $04, $12, $FF, $FF, $00, $00, $07, $00 ;T80:;Spring ball jump in air, facing/moving left
DB $08, $03, $FF, $FF, $00, $00, $0C, $00 ;T81:;Screw attack right
DB $04, $03, $FF, $FF, $00, $00, $0C, $00 ;T82:;Screw attack left
DB $08, $14, $19, $FF, $08, $00, $13, $00 ;T83:;Walljump right
DB $04, $14, $1A, $FF, $08, $00, $13, $00 ;T84:;Walljump left
DB $08, $05, $27, $00, $00, $00, $10, $00 ;T85:;Crouching, facing right aiming up
DB $04, $05, $28, $09, $00, $00, $10, $00 ;T86:;Crouching, facing left aiming up
DB $04, $18, $FF, $FB, $08, $00, $13, $00 ;T87:;Turning from right to left while falling
DB $08, $18, $FF, $FB, $08, $00, $13, $00 ;T88:;Turning from left to right while falling
DB $08, $15, $FF, $02, $06, $00, $15, $00 ;T89:;Ran into a wall on right (facing right)
DB $04, $15, $FF, $07, $06, $00, $15, $00 ;T8A:;Ran into a wall on left (facing left)
DB $04, $0E, $FF, $FA, $06, $00, $15, $00 ;T8B:;Turning around from right to left while aiming straight up while standing
DB $08, $0E, $FF, $FA, $06, $00, $15, $00 ;T8C:;Turning around from left to right while aiming straight up while standing
DB $04, $0E, $FF, $FC, $06, $00, $15, $00 ;T8D:;Turn around from right to left while aiming diagonal Down while standing
DB $08, $0E, $FF, $FC, $06, $00, $15, $00 ;T8E:;Turn around from left to right while aiming diagonal Down while standing
DB $04, $17, $FF, $FA, $08, $00, $13, $00 ;T8F:;Turning around from right to left while aiming straight up in midair
DB $08, $17, $FF, $FA, $08, $00, $13, $00 ;T90:;Turning around from left to right while aiming straight up in midair
DB $04, $17, $FF, $FC, $08, $00, $13, $00 ;T91:;Turning around from right to left while aiming Down or diagonal Down in midair
DB $08, $17, $FF, $FC, $08, $00, $13, $00 ;T92:;Turning around from left to right while aiming Down or diagonal Down in midair
DB $04, $18, $FF, $FA, $08, $00, $13, $00 ;T93:;Turning around from right to left while aiming straight up while falling
DB $08, $18, $FF, $FA, $08, $00, $13, $00 ;T94:;Turning around from left to right while aiming straight up while falling
DB $04, $18, $FF, $FC, $08, $00, $13, $00 ;T95:;Turning around from right to left while aiming Down or diagonal Down while falling
DB $08, $18, $FF, $FC, $08, $00, $13, $00 ;T96:;Turning around from left to right while aiming Down or diagonal Down while falling
DB $04, $17, $28, $FA, $00, $00, $10, $00 ;T97:;Turning around from right to left while aiming straight up while crouching
DB $08, $17, $28, $FA, $00, $00, $10, $00 ;T98:;Turning around from left to right while aiming straight up while crouching
DB $04, $17, $28, $FC, $00, $00, $10, $00 ;T99:;Turning around from right to left while aiming diagonal Down while crouching
DB $08, $17, $28, $FC, $00, $00, $10, $00 ;T9A:;Turning around from left to right while aiming diagonal Down while crouching
DB $00, $00, $FF, $FF, $08, $00, $18, $00 ;T9B:;Facing forward, ala Elevator pose (Varia and/or Gravity Suit)
DB $04, $0E, $FF, $FA, $06, $00, $15, $00 ;T9C:;Turning around from right to left while aiming diagonal up while standing
DB $08, $0E, $FF, $FA, $06, $00, $15, $00 ;T9D:;Turning around from left to right while aiming diagonal up while standing
DB $04, $17, $FF, $FA, $08, $00, $13, $00 ;T9E:;Turning around from right to left while aiming diagonal up in midair
DB $08, $17, $FF, $FA, $08, $00, $13, $00 ;T9F:;Turning around from left to right while aiming diagonal up in midair
DB $04, $18, $FF, $FA, $08, $00, $13, $00 ;TA0:;Turning around from right to left while aiming diagonal up while falling
DB $08, $18, $FF, $FA, $08, $00, $13, $00 ;TA1:;Turning around from left to right while aiming diagonal up while falling
DB $04, $17, $28, $FA, $00, $00, $10, $00 ;TA2:;Turn around from right to left while aiming diagonal up while crouching
DB $08, $17, $28, $FA, $00, $00, $10, $00 ;TA3:;Turn around from left to right while aiming diagonal up while crouching
DB $08, $00, $FF, $02, $03, $00, $15, $00 ;TA4:;Landing from normal jump, facing right
DB $04, $00, $FF, $07, $03, $00, $15, $00 ;TA5:;Landing from normal jump, facing left
DB $08, $00, $FF, $02, $03, $00, $15, $00 ;TA6:;Landing from spin jump, facing right
DB $04, $00, $FF, $07, $03, $00, $15, $00 ;TA7:;Landing from spin jump, facing left
DB $08, $16, $01, $02, $06, $00, $15, $00 ;TA8:;Just standing, facing right. Unused? (Grapple movement)
DB $04, $16, $02, $07, $06, $00, $15, $00 ;TA9:;Just standing, facing left. Unused? (Grapple movement)
DB $08, $16, $07, $03, $06, $00, $15, $00 ;TAA:;Just standing, facing right aiming Downright. Unused? (Grapple movement)
DB $04, $16, $08, $06, $06, $00, $15, $00 ;TAB:;Just standing, facing left aiming Downleft. Unused? (Grapple movement)
DB $08, $16, $67, $02, $08, $00, $13, $00 ;TAC:;jumping, facing right, gun extended. Unused? (Grapple movement)
DB $04, $16, $68, $07, $08, $00, $13, $00 ;TAD:;jumping, facing left, gun extended. Unused? (Grapple movement)
DB $08, $16, $2D, $04, $06, $00, $0A, $00 ;TAE:;jumping, facing right, aiming Down. Unused? (Grapple movement)
DB $04, $16, $2E, $05, $06, $00, $0A, $00 ;TAF:;jumping, facing left, aiming Down. Unused? (Grapple movement)
DB $08, $16, $6F, $03, $08, $00, $13, $00 ;TB0:;jumping, facing right, aiming Downright. Unused? (Grapple movement)
DB $04, $16, $70, $06, $08, $00, $13, $00 ;TB1:;jumping, facing left, aiming Downleft. Unused? (Grapple movement)
DB $08, $16, $B2, $FF, $10, $00, $11, $00 ;TB2:;Grapple, facing clockwise
DB $04, $16, $B3, $FF, $10, $00, $11, $00 ;TB3:;Grapple, facing counterclockwise
DB $08, $16, $27, $02, $00, $00, $10, $00 ;TB4:;Crouching, facing right. Unused? (Grapple movement)
DB $04, $16, $28, $07, $00, $00, $10, $00 ;TB5:;Crouching, facing left. Unused? (Grapple movement)
DB $08, $16, $27, $03, $00, $00, $10, $00 ;TB6:;Crouching, facing right, aiming Downright. Unused? (Grapple movement)
DB $04, $16, $28, $06, $00, $00, $10, $00 ;TB7:;Crouching, facing left, aiming Downleft. Unused? (Grapple movement)
DB $08, $16, $FF, $03, $00, $00, $10, $00 ;TB8:;Grapple, attached to a wall on right, facing left
DB $04, $16, $FF, $06, $00, $00, $10, $00 ;TB9:;Grapple, attached to a wall on left, facing right
DB $04, $1A, $FF, $07, $06, $00, $15, $00 ;TBA:;Grabbed by Draygon, facing left, not moving
DB $04, $1A, $BA, $08, $06, $00, $15, $00 ;TBB:;Grabbed by Draygon, facing left aiming upleft, not moving
DB $04, $1A, $BA, $07, $06, $00, $15, $00 ;TBC:;Grabbed by Draygon, facing left and firing
DB $04, $1A, $BA, $06, $06, $00, $15, $00 ;TBD:;Grabbed by Draygon, facing left aiming Downleft, not moving
DB $04, $1A, $BA, $FF, $06, $00, $15, $00 ;TBE:;Grabbed by Draygon, facing left, moving
DB $04, $0E, $FF, $FB, $06, $00, $15, $00 ;TBF:;jump/Turn right to left while moonwalking.
DB $08, $0E, $FF, $FB, $06, $00, $15, $00 ;TC0:;jump/Turn left to right while moonwalking.
DB $04, $0E, $FF, $FA, $08, $00, $15, $00 ;TC1:;jump/Turn right to left while moonwalking and aiming diagonal up.
DB $08, $0E, $FF, $FA, $08, $00, $15, $00 ;TC2:;jump/Turn left to right while moonwalking and aiming diagonal up.
DB $04, $0E, $FF, $FC, $08, $00, $15, $00 ;TC3:;jump/Turn right to left while moonwalking and aiming diagonal Down.
DB $08, $0E, $FF, $FC, $08, $00, $15, $00 ;TC4:;jump/Turn left to right while moonwalking and aiming diagonal Down.
DB $04, $1A, $FF, $FF, $00, $00, $07, $00 ;TC5:;Morph ball, facing right. Unused? (Grabbed by Draygon movement)
DB $04, $1A, $FF, $FB, $06, $00, $15, $00 ;TC6:;Morph ball, facing left. Unused? (Grabbed by Draygon movement)
DB $08, $1B, $FF, $FF, $08, $00, $13, $00 ;TC7:;Super jump windup, facing right
DB $04, $1B, $FF, $FF, $08, $00, $13, $00 ;TC8:;Super jump windup, facing left
DB $08, $1B, $FF, $02, $08, $00, $13, $00 ;TC9:;Horizontal super jump, right
DB $04, $1B, $FF, $07, $08, $00, $13, $00 ;TCA:;Horizontal super jump, left
DB $08, $1B, $FF, $00, $08, $00, $13, $00 ;TCB:;Vertical super jump, facing right
DB $04, $1B, $FF, $09, $08, $00, $13, $00 ;TCC:;Vertical super jump, facing left
DB $08, $1B, $FF, $01, $08, $00, $13, $00 ;TCD:;Diagonal super jump, right
DB $04, $1B, $FF, $08, $08, $00, $13, $00 ;TCE:;Diagonal super jump, left
DB $08, $15, $89, $01, $06, $00, $15, $00 ;TCF:;Samus ran right into a wall, is still holding right and is now aiming diagonal up
DB $04, $15, $8A, $08, $06, $00, $15, $00 ;TD0:;Samus ran left into a wall, is still holding left and is now aiming diagonal up
DB $08, $15, $89, $03, $06, $00, $15, $00 ;TD1:;Samus ran right into a wall, is still holding right and is now aiming diagonal Down
DB $04, $15, $8A, $06, $06, $00, $15, $00 ;TD2:;Samus ran left into a wall, is still holding left and is now aiming diagonal Down
DB $08, $1B, $FF, $FF, $06, $00, $15, $00 ;TD3:;Crystal flash, facing right
DB $04, $1B, $FF, $FF, $06, $00, $15, $00 ;TD4:;Crystal flash, facing left
DB $08, $00, $FF, $02, $06, $00, $15, $00 ;TD5:;X-raying right, standing
DB $04, $00, $FF, $07, $06, $00, $15, $00 ;TD6:;X-raying left, standing
DB $08, $0A, $FF, $02, $06, $00, $15, $00 ;TD7:;Crystal flash ending, facing right
DB $04, $0A, $FF, $07, $06, $00, $15, $00 ;TD8:;Crystal flash ending, facing left
DB $08, $05, $FF, $02, $00, $00, $10, $00 ;TD9:;X-raying right, crouching
DB $04, $05, $FF, $07, $00, $00, $10, $00 ;TDA:;X-raying left, crouching
DB $08, $0F, $FF, $FF, $00, $00, $07, $00 ;TDB:;Standing transition to morphball, facing right? Unused?
DB $04, $0F, $FF, $FF, $00, $00, $07, $00 ;TDC:;Standing transition to morphball, facing left? Unused?
DB $08, $0F, $FF, $FF, $06, $00, $15, $00 ;TDD:;Morphball transition to standing, facing right? Unused?
DB $04, $0F, $FF, $FF, $06, $00, $15, $00 ;TDE:;Morphball transition to standing, facing left? Unused?
DB $04, $1A, $FF, $FF, $00, $00, $07, $00 ;TDF:;Samus is facing left as a morphball. Unused? (Grabbed by Draygon movement)
DB $08, $00, $FF, $00, $03, $00, $15, $00 ;TE0:;Landing from normal jump, facing right and aiming up
DB $04, $00, $FF, $09, $03, $00, $15, $00 ;TE1:;Landing from normal jump, facing left and aiming up
DB $08, $00, $FF, $01, $03, $00, $15, $00 ;TE2:;Landing from normal jump, facing right and aiming upright
DB $04, $00, $FF, $08, $03, $00, $15, $00 ;TE3:;Landing from normal jump, facing left and aiming upleft
DB $08, $00, $FF, $03, $03, $00, $15, $00 ;TE4:;Landing from normal jump, facing right and aiming Downright
DB $04, $00, $FF, $06, $03, $00, $15, $00 ;TE5:;Landing from normal jump, facing left and aiming Downleft
DB $08, $00, $FF, $02, $03, $00, $15, $00 ;TE6:;Landing from normal jump, facing right, firing
DB $04, $00, $FF, $07, $03, $00, $15, $00 ;TE7:;Landing from normal jump, facing left, firing
DB $08, $1B, $FF, $FF, $FC, $00, $15, $00 ;TE8:;Samus exhausted(Metroid drain, MB attack), facing right
DB $04, $1B, $FF, $FF, $FC, $00, $15, $00 ;TE9:;Samus exhausted(Metroid drain, MB attack), facing left
DB $08, $1B, $FF, $FF, $FC, $00, $15, $00 ;TEA:;Samus exhausted, looking up to watch Metroid attack MB, facing right
DB $04, $1B, $FF, $FF, $FC, $00, $15, $00 ;TEB:;Samus exhausted, looking up to watch Metroid attack MB, facing left
DB $08, $1A, $FF, $02, $06, $00, $15, $00 ;TEC:;Grabbed by Draygon, facing right. Not moving
DB $08, $1A, $EC, $01, $06, $00, $15, $00 ;TED:;Grabbed by Draygon, facing right aiming upright. Not moving
DB $08, $1A, $EC, $02, $06, $00, $15, $00 ;TEE:;Grabbed by Draygon, facing right and firing.
DB $08, $1A, $EC, $03, $06, $00, $15, $00 ;TEF:;Grabbed by Draygon, facing right aiming Downright. Not moving
DB $08, $1A, $EC, $FF, $06, $00, $15, $00 ;TF0:;Grabbed by Draygon, facing right. Moving
DB $08, $0F, $FF, $00, $08, $00, $10, $00 ;TF1:;Crouch transition, facing right and aiming up
DB $04, $0F, $FF, $09, $08, $00, $10, $00 ;TF2:;Crouch transition, facing left and aiming up
DB $08, $0F, $FF, $01, $08, $00, $10, $00 ;TF3:;Crouch transition, facing right and aiming upright
DB $04, $0F, $FF, $08, $08, $00, $10, $00 ;TF4:;Crouch transition, facing left and aiming upleft
DB $08, $0F, $FF, $03, $08, $00, $10, $00 ;TF5:;Crouch transition, facing right and aiming Downright
DB $04, $0F, $FF, $06, $08, $00, $10, $00 ;TF6:;Crouch transition, facing left and aiming Downleft
DB $08, $0F, $FF, $00, $03, $00, $15, $00 ;TF7:;Crouching to standing, facing right and aiming up
DB $04, $0F, $FF, $09, $03, $00, $15, $00 ;TF8:;Crouching to standing, facing left and aiming up
DB $08, $0F, $FF, $01, $03, $00, $15, $00 ;TF9:;Crouching to standing, facing right and aiming upright
DB $04, $0F, $FF, $08, $03, $00, $15, $00 ;TFA:;Crouching to standing, facing left and aiming upleft
DB $08, $0F, $FF, $03, $03, $00, $15, $00 ;TFB:;Crouching to standing, facing right and aiming Downright
DB $04, $0F, $FF, $06, $03, $00, $15, $00 ;TFC:;Crouching to standing, facing left and aiming Downleft

;Pose Definition Table ends @ $91BE11


;--------------------------------------------------------------------------------------------------


;master tilemap pointer table

ORG $92808D		;these are never pointed to directly?
DW TM_000, TM_001  

;8091
P00_UT:		;00:;Facing forward, ala Elevator pose (power suit)
DW TM_035, $0000, TM_070, TM_06F, TM_071, TM_06F, TM_072, TM_06F  
DW TM_070, TM_06F, TM_071, TM_06F, TM_072, TM_06F, TM_070, TM_06F  
DW TM_071, TM_06F, TM_072, TM_06F, TM_070, TM_06F, TM_071, TM_06F  
DW TM_072, TM_06F, TM_070, TM_06F, TM_071, TM_06F, TM_072, TM_06F  
DW TM_070, TM_06F, TM_071, TM_06F, TM_072, TM_06F, TM_070, TM_06F  
DW TM_071, TM_06F, TM_072, TM_06F, TM_070, TM_06F, TM_071, TM_06F  
DW TM_072, TM_06F, TM_070, TM_06F, TM_071, TM_06F, TM_072, TM_06F  
DW TM_070, TM_06F, TM_071, TM_06F, TM_072, TM_06F, TM_070, TM_06F  
DW TM_071, TM_06F, TM_072, TM_06F, TM_070, TM_06F, TM_071, TM_06F  
DW TM_072, TM_06F, TM_070, TM_06F, TM_071, TM_06F, TM_072, TM_06F  
DW TM_073, TM_06F, TM_074, TM_06F, TM_075, TM_06F, TM_076, TM_06F  
DW TM_077, TM_06F, TM_075, TM_06F, TM_076, TM_06F, TM_077, TM_06F  

;8151
P00_LT:		;00:;Facing forward, ala Elevator pose (power suit)
DW TM_0D4, $0000, TM_106, TM_106, TM_106, TM_106, TM_106, TM_106  
DW TM_106, TM_106, TM_106, TM_106, TM_106, TM_106, TM_106, TM_106  
DW TM_106, TM_106, TM_106, TM_106, TM_106, TM_106, TM_106, TM_106  
DW TM_106, TM_106, TM_106, TM_106, TM_106, TM_106, TM_106, TM_106  
DW TM_106, TM_106, TM_106, TM_106, TM_106, TM_106, TM_106, TM_106  
DW TM_106, TM_106, TM_106, TM_106, TM_106, TM_106, TM_106, TM_106  
DW TM_106, TM_106, TM_106, TM_106, TM_106, TM_106, TM_106, TM_106  
DW TM_106, TM_106, TM_106, TM_106, TM_106, TM_106, TM_106, TM_106  
DW TM_106, TM_106, TM_106, TM_106, TM_106, TM_106, TM_106, TM_106  
DW TM_106, TM_106, TM_106, TM_106, TM_106, TM_106, TM_106, TM_106  
DW TM_106, TM_106, TM_106, TM_106, TM_106, TM_106, TM_106, TM_106  
DW TM_106, TM_106, TM_106, TM_106, TM_106, TM_106, TM_106, TM_106  

;8211
P9B_UT:		;Facing forward, ala Elevator pose (Varia and/or Gravity Suit)
DW TM_029, $0000, TM_070, TM_06F, TM_071, TM_06F, TM_072, TM_06F  
DW TM_070, TM_06F, TM_071, TM_06F, TM_072, TM_06F, TM_070, TM_06F  
DW TM_071, TM_06F, TM_072, TM_06F, TM_070, TM_06F, TM_071, TM_06F  
DW TM_072, TM_06F, TM_070, TM_06F, TM_071, TM_06F, TM_072, TM_06F  
DW TM_070, TM_06F, TM_071, TM_06F, TM_072, TM_06F, TM_070, TM_06F  
DW TM_071, TM_06F, TM_072, TM_06F, TM_070, TM_06F, TM_071, TM_06F  
DW TM_072, TM_06F, TM_070, TM_06F, TM_071, TM_06F, TM_072, TM_06F  
DW TM_070, TM_06F, TM_071, TM_06F, TM_072, TM_06F, TM_070, TM_06F  
DW TM_071, TM_06F, TM_072, TM_06F, TM_070, TM_06F, TM_071, TM_06F  
DW TM_072, TM_06F, TM_070, TM_06F, TM_071, TM_06F, TM_072, TM_06F  
DW TM_073, TM_06F, TM_074, TM_06F, TM_075, TM_06F, TM_076, TM_06F  
DW TM_077, TM_06F, TM_075, TM_06F, TM_076, TM_06F, TM_077, TM_06F  

;82D1
P9B_LT:		;Facing forward, ala Elevator pose (Varia and/or Gravity Suit)
DW TM_0D5, $0000, TM_107, TM_107, TM_107, TM_107, TM_107, TM_107  
DW TM_107, TM_107, TM_107, TM_107, TM_107, TM_107, TM_107, TM_107  
DW TM_107, TM_107, TM_107, TM_107, TM_107, TM_107, TM_107, TM_107  
DW TM_107, TM_107, TM_107, TM_107, TM_107, TM_107, TM_107, TM_107  
DW TM_107, TM_107, TM_107, TM_107, TM_107, TM_107, TM_107, TM_107  
DW TM_107, TM_107, TM_107, TM_107, TM_107, TM_107, TM_107, TM_107  
DW TM_107, TM_107, TM_107, TM_107, TM_107, TM_107, TM_107, TM_107  
DW TM_107, TM_107, TM_107, TM_107, TM_107, TM_107, TM_107, TM_107  
DW TM_107, TM_107, TM_107, TM_107, TM_107, TM_107, TM_107, TM_107  
DW TM_107, TM_107, TM_107, TM_107, TM_107, TM_107, TM_107, TM_107  
DW TM_107, TM_107, TM_107, TM_107, TM_107, TM_107, TM_107, TM_107  
DW TM_107, TM_107, TM_107, TM_107, TM_107, TM_107, TM_107, TM_107  
DW TM_002, TM_003, TM_004, TM_005, TM_1C1, TM_1C2, TM_1C3, TM_1C4  
DW TM_1C5, TM_1C6, TM_1C7, TM_1C8, TM_1C9, TM_1CA, TM_1CB, TM_1CC  
DW TM_1CD, TM_1CE, TM_1CF, TM_1D0, TM_1D1, TM_1D2, TM_006, TM_006  

;83C1
P01_UT:		;Facing right, normal
P47_UT:		;Standing, facing right. Unused?
P89_UT:		;Ran into a wall on right (facing right)
PA8_UT:		;Just standing, facing right. Unused? (Grapple movement)
DW TM_067, TM_068, TM_069, TM_068, $0000, TM_067, TM_068, TM_06D, TM_068  

;83D3
P02_UT:		;Facing left, normal
P48_UT:		;Standing, facing left. Unused?
P8A_UT:		;Ran into a wall on left (facing left)
PA9_UT:		;Just standing, facing left. Unused? (Grapple movement)
DW TM_06A, TM_06B, TM_06C, TM_06B, $0000, TM_06A, TM_06B, TM_06E, TM_06B, TM_006  

;83E7
P03_UT:		;Facing right, aiming up
DW TM_018, TM_01C  

;83EB
P04_UT:		;Facing left, aiming up
DW TM_019, TM_01D  

;83EF
P05_UT:		;Facing right, aiming upright
P57_UT:		;Normal jump transition from ground, facing right and aiming upright
PCF_UT:		;Samus ran right into a wall, is still holding right and is now aiming diagonal up
PE2_UT:		;Landing from normal jump, facing right and aiming upright
PF3_UT:		;Crouch transition, facing right and aiming upright
PF9_UT:		;Crouching to standing, facing right and aiming upright
DW TM_018, TM_018  

;83F3
P06_UT:		;Facing left, aiming upleft
P58_UT:		;Normal jump transition from ground, facing left and aiming upleft
PD0_UT:		;Samus ran left into a wall, is still holding left and is now aiming diagonal up
PE3_UT:		;Landing from normal jump, facing left and aiming upleft
PF4_UT:		;Crouch transition, facing left and aiming upleft
PFA_UT:		;Crouching to standing, facing left and aiming upleft
DW TM_019, TM_019  

;83F7
P07_UT:		;Facing right, aiming Downright
P59_UT:		;Normal jump transition from ground, facing right and aiming Downright
PAA_UT:		;Just standing, facing right aiming Downright. Unused? (Grapple movement)
PD1_UT:		;Samus ran right into a wall, is still holding right and is now aiming diagonal Down
PE4_UT:		;Landing from normal jump, facing right and aiming Downright
PF5_UT:		;Crouch transition, facing right and aiming Downright
PFB_UT:		;Crouching to standing, facing right and aiming Downright
DW TM_014, TM_014  

;83FB
P08_UT:		;Facing left, aiming Downleft
P5A_UT:		;Normal jump transition from ground, facing left and aiming Downleft
PAB_UT:		;Just standing, facing left aiming Downleft. Unused? (Grapple movement)
PD2_UT:		;Samus ran left into a wall, is still holding left and is now aiming diagonal Down
PE5_UT:		;Landing from normal jump, facing left and aiming Downleft
PF6_UT:		;Crouch transition, facing left and aiming Downleft
PFC_UT:		;Crouching to standing, facing left and aiming Downleft
DW TM_015, TM_015  

;83FF
PA4_UT:		;Landing from normal jump, facing right
DW TM_040, TM_043  

;8403
PA5_UT:		;Landing from normal jump, facing left
DW TM_041, TM_044  

;8407
PA6_UT:		;Landing from spin jump, facing right
DW TM_043, TM_040, TM_043  

;840d
PA7_UT:		;Landing from spin jump, facing left
DW TM_044, TM_041, TM_044  

;8413
PD5_UT:		;X-raying right, standing
PD9_UT:		;X-raying right, crouching
DW TM_048, TM_047, TM_016, TM_049, TM_04A  

;841d
PD6_UT:		;X-raying left, standing
PDA_UT:		;X-raying left, crouching
DW TM_04C, TM_04B, TM_017, TM_04D, TM_04E  

;8427
P55_UT:		;55: Normal jump transition from ground, facing right and aiming up
PE0_UT:		;E0: Landing from normal jump, facing right and aiming up
PF1_UT:		;F1: Crouch transition, facing right and aiming up
PF7_UT:		;F7: Crouching to standing, facing right and aiming up
DW TM_01C, TM_01C  

;842b
P56_UT:		;56: Normal jump transition from ground, facing left and aiming up
PE1_UT:		;E1: Landing from normal jump, facing left and aiming up
PF2_UT:		;F2: Crouch transition, facing left and aiming up
PF8_UT:		;F8: Crouching to standing, facing left and aiming up
DW TM_01D, TM_01D  

;842f
PE6_UT:		;E6: Landing from normal jump, facing right, firing
DW TM_016, TM_016  

;8433
PE7_UT:		;E7: Landing from normal jump, facing left, firing
DW TM_017, TM_017  

;8437
P49_UT:		;49: Moonwalk, facing left
DW TM_017, TM_056, TM_056, TM_017, TM_056, TM_056  

;8443
P4A_UT:		;4A: Moonwalk, facing right
DW TM_016, TM_055, TM_055, TM_016, TM_055, TM_055  

;844f
P75_UT:		;75: Moonwalk, facing left aiming upleft
DW TM_021, TM_050, TM_050, TM_021, TM_050, TM_050  

;845b
P76_UT:		;76: Moonwalk, facing right aiming upright
DW TM_020, TM_04F, TM_04F, TM_020, TM_04F, TM_04F  

;8467
P77_UT:		;77: Moonwalk, facing left aiming Downleft
DW TM_013, TM_046, TM_046, TM_013, TM_046, TM_046  

;8473
P78_UT:		;78: Moonwalk, facing right aiming Downright
DW TM_012, TM_045, TM_045, TM_012, TM_045, TM_045  

;847f
P09_UT:		;09: Moving right, not aiming
DW TM_006, TM_031, TM_008, TM_009, TM_007, TM_006, TM_032, TM_00B, TM_01E, TM_00A  

;8493
P0A_UT:		;0A: Moving left, not aiming
DW TM_00C, TM_033, TM_00E, TM_00F, TM_00D, TM_00C, TM_034, TM_011, TM_01F, TM_010  

;84a7
P0B_UT:		;0B: Moving right, gun extended forward (not aiming)
DW TM_078, TM_086, TM_07A, TM_07B, TM_079, TM_078, TM_07C, TM_07D, TM_084, TM_07C  

;84bb
P0C_UT:		;0C: Moving left, gun extended forward (not aiming)
DW TM_07E, TM_087, TM_081, TM_080, TM_07F, TM_07E, TM_082, TM_085, TM_083, TM_082  

;84cf
P0D_UT:		;0D: Moving right, aiming straight up (unused?)
DW TM_01C, TM_01C, TM_04D, TM_059, TM_04D, TM_01C, TM_01C, TM_04D, TM_059, TM_04D  

;84e3
P0E_UT:		;0E: Moving left, aiming straight up (unused?)
DW TM_01D, TM_01D, TM_04E, TM_05A, TM_04E, TM_01D, TM_01D, TM_04E, TM_05A, TM_04E  

;84f7
P0F_UT:		;0F: Moving right, aiming upright
DW TM_020, TM_020, TM_04F, TM_051, TM_04F, TM_020, TM_020, TM_04F, TM_051, TM_04F  

;850b
P10_UT:		;10: Moving left, aiming upleft
DW TM_021, TM_021, TM_050, TM_052, TM_050, TM_021, TM_021, TM_050, TM_052, TM_050  

;851f
P11_UT:		;11: Moving right, aiming Downright
DW TM_012, TM_012, TM_045, TM_053, TM_045, TM_012, TM_012, TM_045, TM_053, TM_045  

;8533
P12_UT:		;12: Moving left, aiming Downleft
DW TM_013, TM_013, TM_046, TM_054, TM_046, TM_013, TM_013, TM_046, TM_054, TM_046  

;8547
P45_UT:		;45: running, facing right, shooting left. Unused? (Fast moonwalk)
DW TM_01B, TM_01B, TM_04C, TM_058, TM_04C, TM_01B, TM_01B, TM_04C, TM_058, TM_04C  

;855b
P46_UT:		;46: running, facing left, shooting right. Unused? (Fast moonwalk)
DW TM_01A, TM_01A, TM_04B, TM_057, TM_04B, TM_01A, TM_01A, TM_04B, TM_057, TM_04B  

;856f
P17_UT:		;17: Normal jump facing right, aiming Down
PAE_UT:		;AE: jumping, facing right, aiming Down. Unused? (Grapple movement)
DW TM_012, TM_03C  

;8573
P18_UT:		;18: Normal jump facing left, aiming Down
PAF_UT:		;AF: jumping, facing left, aiming Down. Unused? (Grapple movement)
DW TM_013, TM_03D  

;8577
P13_UT:		;13: Normal jump facing right, gun extended, not aiming or moving
PAC_UT:		;AC: jumping, facing right, gun extended. Unused? (Grapple movement)
DW TM_016, TM_016  

;857b
P14_UT:		;14: Normal jump facing left, gun extended, not aiming or moving
PAD_UT:		;AD: jumping, facing left, gun extended. Unused? (Grapple movement)
DW TM_017, TM_017  

;857f
P15_UT:		;15: Normal jump facing right, aiming up
DW TM_018, TM_01C  

;8583
P16_UT:		;16: Normal jump facing left, aiming up
DW TM_019, TM_01D  

;8587
P69_UT:		;69: Normal jump facing right, aiming upright. Moving optional
DW TM_020, TM_020  

;858b
P6A_UT:		;6A: Normal jump facing left, aiming upleft. Moving optional
DW TM_021, TM_021  

;858f
P6B_UT:		;6B: Normal jump facing right, aiming Downright. Moving optional
PB0_UT:		;B0: jumping, facing right, aiming Downright. Unused? (Grapple movement)
DW TM_012, TM_012  

;8593
P6C_UT:		;6C: Normal jump facing left, aiming Downleft. Moving optional
PB1_UT:		;B1: jumping, facing left, aiming Downleft. Unused? (Grapple movement)
DW TM_013, TM_013  

;8597
P51_UT:		;51: Normal jump facing right, moving forward (gun extended)
DW TM_016, TM_016  

;859b
P52_UT:		;52: Normal jump facing left, moving forward (gun extended)
DW TM_017, TM_017  

;859f
P4B_UT:		;4B: Normal jump transition from ground(standing or crouching), facing right
DW TM_040

;85a1
P4C_UT:		;4C: Normal jump transition from ground(standing or crouching), facing left
DW TM_041

;85a3
P4D_UT:		;4D: Normal jump facing right, gun not extended, not aiming, not moving
PC7_UT:		;C7: Super jump windup, facing right
DW TM_00A, TM_00B, TM_00A, TM_006, TM_007, TM_01A  

;85af
P4E_UT:		;4E: Normal jump facing left, gun not extended, not aiming, not moving
PC8_UT:		;C8: Super jump windup, facing left
DW TM_010, TM_011, TM_010, TM_00C, TM_00D, TM_01B  

;85bb
P4F_UT:		;4F: Hurt roll back, moving right/facing left
DW TM_044, TM_044, TM_17C, TM_17B, TM_17A, TM_179, TM_178, TM_177, TM_176, TM_05A  

;85cf
P50_UT:		;50: Hurt roll back, moving left/facing right
DW TM_043, TM_043, TM_18E, TM_18D, TM_18C, TM_18B, TM_18A, TM_189, TM_188, TM_058  

;85e3
P63_UT:		;63: Facing left on grapple blocks, ready to jump. Unused?
DW TM_038, TM_030  

;85e7
P64_UT:		;64: Facing right on grapple blocks, ready to jump. Unused?
DW TM_039, TM_02F  

;85eb
P65_UT:		;65: Glitchy jump, facing left. Used by unused grapple jump?
DW TM_036, TM_187, TM_188, TM_189, TM_18A, TM_18B, TM_18C, TM_18D, TM_18E  

;85fd
P66_UT:		;66: Glitchy jump, facing right. Used by unused grapple jump?
DW TM_037, TM_175, TM_176, TM_177, TM_178, TM_179, TM_17A, TM_17B, TM_17C  

;860f
P83_UT:		;83: Walljump right
DW TM_036, TM_043, $0000, TM_187, TM_188, TM_189, TM_18A, TM_18B  
DW TM_18C, TM_18D, TM_18E, $0000, $0000, TM_193, TM_193, TM_193  
DW TM_193, TM_193, TM_193, TM_193, TM_193, $0000, $0000, TM_18F  
DW TM_18F, TM_18F, TM_193, TM_193, TM_193, TM_190, TM_190, TM_190  
DW TM_193, TM_193, TM_193, TM_191, TM_191, TM_191, TM_193, TM_193  
DW TM_193, TM_192, TM_192, TM_192, TM_193, TM_193, TM_193  

;866d
P84_UT:		;84: Walljump left
DW TM_037, TM_044, $0000, TM_175, TM_176, TM_177, TM_178, TM_179  
DW TM_17A, TM_17B, TM_17C, $0000, $0000, TM_181, TM_181, TM_181  
DW TM_181, TM_181, TM_181, TM_181, TM_181, $0000, $0000, TM_17D  
DW TM_17D, TM_17D, TM_181, TM_181, TM_181, TM_17E, TM_17E, TM_17E  
DW TM_181, TM_181, TM_181, TM_17F, TM_17F, TM_17F, TM_181, TM_181  
DW TM_181, TM_180, TM_180, TM_180, TM_181, TM_181, TM_181  

;86cb
P53_UT:		;53: Hurt, facing right
DW TM_023, TM_023  

;86cf
P54_UT:		;54: Hurt, facing left
DW TM_022, TM_022, TM_022, TM_023, TM_025, TM_025, TM_029, TM_024  
DW TM_024, TM_028, TM_02B, TM_02D, TM_02A, TM_02C  

;86eb
P5B_UT:		;5B: Something for grapple (wall jump?), probably unused
PB8_UT:		;B8: Grapple, attached to a wall on right, facing left
DW TM_030  

;86ed
P5C_UT:		;5C: Something for grapple (wall jump?), probably unused
PB9_UT:		;B9: Grapple, attached to a wall on left, facing right
DW TM_02F  

;86ef
P5D_UT:		;5D: Broken grapple? Facing clockwise, maybe unused
P5E_UT:		;5E: Broken grapple? Facing clockwise, maybe unused
P5F_UT:		;5F: Broken grapple? Facing clockwise, maybe unused
DW TM_03D  

;86f1
P60_UT:		;60: Better broken grapple. Facing clockwise, maybe unused
DW TM_03C  

;86f3
P61_UT:		;61: Nearly normal grapple. Facing clockwise, maybe unused
PB2_UT:		;B2: Grapple, facing clockwise
DW TM_0B0, TM_0AF, TM_0AE, TM_0AD, TM_0AC, TM_0AB, TM_0AA, TM_0A9  
DW TM_0A8, TM_097, TM_096, TM_095, TM_094, TM_093, TM_092, TM_091  
DW TM_090, TM_08F, TM_08E, TM_08D, TM_08C, TM_08B, TM_08A, TM_089  
DW TM_088, TM_0B7, TM_0B6, TM_0B5, TM_0B4, TM_0B3, TM_0B2, TM_0B1  
DW TM_0B0, TM_0AF, TM_0AE, TM_0AD, TM_0AC, TM_0AB, TM_0AA, TM_0A9  
DW TM_0A8, TM_097, TM_096, TM_095, TM_094, TM_093, TM_092, TM_091  
DW TM_090, TM_08F, TM_08E, TM_08D, TM_08C, TM_08B, TM_08A, TM_089  
DW TM_088, TM_0B7, TM_0B6, TM_0B5, TM_0B4, TM_0B3, TM_0B2, TM_0B1  
DW TM_090, TM_090  

;8777		
P62_UT:		;62: Nearly normal grapple. Facing counterclockwise, maybe unused
PB3_UT:		;B3: Grapple, facing counterclockwise
DW TM_0C0, TM_0C1, TM_0C2, TM_0C3, TM_0C4, TM_0C5, TM_0C6, TM_0C7  
DW TM_098, TM_099, TM_09A, TM_09B, TM_09C, TM_09D, TM_09E, TM_09F  
DW TM_0A0, TM_0A1, TM_0A2, TM_0A3, TM_0A4, TM_0A5, TM_0A6, TM_0A7  
DW TM_0B8, TM_0B9, TM_0BA, TM_0BB, TM_0BC, TM_0BD, TM_0BE, TM_0BF  
DW TM_0C0, TM_0C1, TM_0C2, TM_0C3, TM_0C4, TM_0C5, TM_0C6, TM_0C7  
DW TM_098, TM_099, TM_09A, TM_09B, TM_09C, TM_09D, TM_09E, TM_09F  
DW TM_0A0, TM_0A1, TM_0A2, TM_0A3, TM_0A4, TM_0A5, TM_0A6, TM_0A7  
DW TM_0B8, TM_0B9, TM_0BA, TM_0BB, TM_0BC, TM_0BD, TM_0BE, TM_0BF  
DW TM_0A0, TM_0A0  

;87fb
P29_UT:		;29: Falling facing right, normal pose
DW TM_043, TM_057, TM_058, $0000, $0000, TM_057, TM_043  

;8809
P2A_UT:		;2A: Falling facing left, normal pose
DW TM_044, TM_059, TM_05A, $0000, $0000, TM_059, TM_044  

;8817
P67_UT:		;67: Facing right, falling, fired a shot
DW TM_016, TM_016, TM_016, $0000, $0000, TM_016, TM_016  

;8825
P68_UT:		;68: Facing left, falling, fired a shot
DW TM_017, TM_017, TM_017, $0000, $0000, TM_017, TM_017  

;8833
P2B_UT:		;2B: Falling facing right, aiming up
DW TM_018, TM_01C, TM_01C  

;8839
P2C_UT:		;2C: Falling facing left, aiming up
DW TM_019, TM_01D, TM_01D  

;883f
P2D_UT:		;2D: Falling facing right, aiming Down
DW TM_012, TM_03C  

;8843
P2E_UT:		;2E: Falling facing left, aiming Down
DW TM_013, TM_03D  

;8847
P6D_UT:		;6D: Falling facing right, aiming upright
DW TM_020, TM_020, TM_020  

;884d
P6E_UT:		;6E: Falling facing left, aiming upleft
DW TM_021, TM_021, TM_021  

;8853
P6F_UT:		;6F: Falling facing right, aiming Downright
DW TM_012, TM_012, TM_012  

;8859
P70_UT:		;70: Falling facing left, aiming Downleft
DW TM_013, TM_013, TM_013  

;885f
P71_UT:		;71: Standing to crouching, facing right and aiming upright
DW TM_018  

;8861
P72_UT:		;72: Standing to crouching, facing left and aiming upleft
DW TM_019  

;8863
P73_UT:		;73: Standing to crouching, facing right and aiming Downright
PB6_UT:		;B6: Crouching, facing right, aiming Downright. Unused? (Grapple movement)
DW TM_014  

;8865
P74_UT:		;74: Standing to crouching, facing left and aiming Downleft
PB7_UT:		;B7: Crouching, facing left, aiming Downleft. Unused? (Grapple movement)
DW TM_015  

;8867
P85_UT:		;85: Crouching, facing right aiming up
DW TM_018, TM_01C  

;886b
P86_UT:		;86: Crouching, facing left aiming up
DW TM_019, TM_01D  

;886f
P27_UT:		;27: Crouching, facing right
PB4_UT:		;B4: Crouching, facing right. Unused? (Grapple movement)
DW TM_067, TM_068, TM_069, TM_068, $0000, TM_067, TM_068, TM_06D, TM_068  

;8881
P28_UT:		;28: Crouching, facing left
PB5_UT:		;B5: Crouching, facing left. Unused? (Grapple movement)
DW TM_06A, TM_06B, TM_06C, TM_06B, $0000, TM_06A, TM_06B, TM_06E, TM_06B  

;8893
P35_UT:		;35: Crouch transition, facing right
P3B_UT:		;3B: Standing from crouching, facing right
DW TM_016  

;8895
P36_UT:		;36: Crouch transition, facing left
P3C_UT:		;3C: Standing from crouching, facing left
DW TM_017  

;8897
P37_UT:		;37: Morphing into ball, facing right. Ground and mid-air
P37_LT:		;37: Morphing into ball, facing right. Ground and mid-air
DW TM_186, TM_185  

;889b
P38_UT:		;38: Morphing into ball, facing left. Ground and mid-air
P38_LT:		;38: Morphing into ball, facing left. Ground and mid-air
DW TM_184, TM_183  

;889f
P3D_UT:		;3D: Demorph while facing right. Mid-air and on ground
P3D_LT:		;3D: Demorph while facing right. Mid-air and on ground
DW TM_185, TM_186  

;88a3
P3E_UT:		;3E: Demorph while facing left. Mid-air and on ground
P3E_LT:		;3E: Demorph while facing left. Mid-air and on ground
DW TM_183, TM_184  

;88a7
PDB_UT:		;DB: Standing transition to morphball, facing right? Unused?
DW TM_016, TM_186, TM_185  

;88ad
PDC_UT:		;DC: Standing transition to morphball, facing left? Unused?
DW TM_017, TM_184, TM_183  

;88b3
PDD_UT:		;DD: Morphball transition to standing, facing right? Unused?
DW TM_185, TM_186, TM_016  

;88b9
PDE_UT:		;DE: Morphball transition to standing, facing left? Unused?
DW TM_183, TM_184, TM_017  

;88bf
P25_UT:		;25: starting standing right, turning left
P2F_UT:		;2F: starting with normal jump facing right, turning left
P43_UT:		;43: starting from crouching right, turning left
P87_UT:		;87: Turning from right to left while falling
PBF_UT:		;BF: jump/Turn right to left while moonwalking.
PC6_UT:		;C6: Morph ball, facing left. Unused? (Grabbed by Draygon movement)
DW TM_02B, TM_02E, TM_02A  

;88c5
P26_UT:		;26: starting standing left, turning right
P30_UT:		;30: starting with normal jump facing left, turning right
P44_UT:		;44: starting from crouching left, turning right
P88_UT:		;88: Turning from left to right while falling
PC0_UT:		;C0: jump/Turn left to right while moonwalking.
DW TM_02A, TM_02E, TM_02B  

;88cb
P8B_UT:		;8B: Turning around from right to left while aiming straight up while standing
P8F_UT:		;8F: Turning around from right to left while aiming straight up in midair
P93_UT:		;93: Turning around from right to left while aiming straight up while falling
P97_UT:		;97: Turning around from right to left while aiming straight up while crouching
P9C_UT:		;9C: Turning around from right to left while aiming diagonal up while standing
P9E_UT:		;9E: Turning around from right to left while aiming diagonal up in midair
PA0_UT:		;A0: Turning around from right to left while aiming diagonal up while falling
PA2_UT:		;A2: Turn around from right to left while aiming diagonal up while crouching
PC1_UT:		;C1: jump/Turn right to left while moonwalking and aiming diagonal up.
DW TM_02D, TM_026, TM_02C  

;88d1
P8C_UT:		;8C: Turning around from left to right while aiming straight up while standing
P90_UT:		;90: Turning around from left to right while aiming straight up in midair
P94_UT:		;94: Turning around from left to right while aiming straight up while falling
P98_UT:		;98: Turning around from left to right while aiming straight up while crouching
P9D_UT:		;9D: Turning around from left to right while aiming diagonal up while standing
P9F_UT:		;9F: Turning around from left to right while aiming diagonal up in midair
PA1_UT:		;A1: Turning around from left to right while aiming diagonal up while falling
PA3_UT:		;A3: Turn around from left to right while aiming diagonal up while crouching
PC2_UT:		;C2: jump/Turn left to right while moonwalking and aiming diagonal up.
DW TM_02C, TM_026, TM_02D  

;88d7
P8D_UT:		;8D: Turn around from right to left while aiming diagonal Down while standing
P91_UT:		;91: Turning around from right to left while aiming Down or diagonal Down in midair
P95_UT:		;95: Turning around from right to left while aiming Down or diagonal Down while falling
P99_UT:		;99: Turning around from right to left while aiming diagonal Down while crouching
PC3_UT:		;C3: jump/Turn right to left while moonwalking and aiming diagonal Down.
DW TM_03B, TM_027, TM_03A  

;88dd
P8E_UT:		;8E: Turn around from left to right while aiming diagonal Down while standing
P92_UT:		;92: Turning around from left to right while aiming Down or diagonal Down in midair
P96_UT:		;96: Turning around from left to right while aiming Down or diagonal Down while falling
P9A_UT:		;9A: Turning around from left to right while aiming diagonal Down while crouching
PC4_UT:		;C4: jump/Turn left to right while moonwalking and aiming diagonal Down.
DW TM_03A, TM_027, TM_03B  

;88e3
PEC_UT:		;EC: Grabbed by Draygon, facing right. Not moving
DW TM_043  

;88e5
PED_UT:		;ED: Grabbed by Draygon, facing right aiming upright. Not moving
DW TM_020  

;88e7
PEE_UT:		;EE: Grabbed by Draygon, facing right and firing.
DW TM_016  

;88e9
PEF_UT:		;EF: Grabbed by Draygon, facing right aiming Downright. Not moving
DW TM_012  

;88eb
PBA_UT:		;BA: Grabbed by Draygon, facing left, not moving
DW TM_044  

;88ed
PBB_UT:		;BB: Grabbed by Draygon, facing left aiming upleft, not moving
DW TM_021  

;88ef
PBC_UT:		;BC: Grabbed by Draygon, facing left and firing
DW TM_017  

;88f1
PBD_UT:		;BD: Grabbed by Draygon, facing left aiming Downleft, not moving
DW TM_013  

;88f3
PF0_UT:		;F0: Grabbed by Draygon, facing right. Moving
DW TM_007, TM_008, TM_006, TM_00A, TM_00B, TM_006  

;88ff
PBE_UT:		;BE: Grabbed by Draygon, facing left, moving
DW TM_00D, TM_00E, TM_00C, TM_010, TM_011, TM_00C  

;890b
PC9_UT:		;C9: Horizontal super jump, right
DW TM_038  

;890d
PCA_UT:		;CA: Horizontal super jump, left
DW TM_039  

;890f
PCD_UT:		;CD: Diagonal super jump, right
DW TM_038  

;8911
PCE_UT:		;CE: Diagonal super jump, left
DW TM_039  

;8913
PD3_UT:		;D3: Crystal flash, facing right
DW TM_185, TM_186, TM_199, TM_186, $0000, $0000, TM_199, TM_19A  
DW TM_19B, TM_19A, $0000, $0000, TM_186, TM_186, TM_016  

;8931
PD4_UT:		;D4: Crystal flash, facing left
DW TM_183, TM_184, TM_196, TM_184, $0000, $0000, TM_196, TM_197  
DW TM_198, TM_197, $0000, $0000, TM_184, TM_184, TM_017  

;894f
PD7_UT:		;D7: Crystal flash ending, facing right
DW TM_16D, TM_185, TM_186, TM_016, TM_023, TM_023 

;895b
PD8_UT:		;D8: Crystal flash ending, facing left
DW TM_174, TM_183, TM_184, TM_017, TM_022, TM_022  

;8967
PE8_UT:		;E8: Samus exhausted(Metroid drain, MB attack), facing right
DW TM_16D, TM_185, TM_186, TM_023, TM_023, TM_023, TM_023, TM_023  
DW TM_05E, TM_05F, TM_060, TM_05F, $0000, $0000, TM_016

;8985
PE9_UT:		;E9: Samus exhausted(Metroid drain, MB attack), facing left
DW TM_183, TM_184, TM_022, TM_022, TM_022, TM_022, TM_022, TM_05C  
DW TM_05B, TM_05C, TM_05D, TM_05C, $0000, $0000, TM_05C, TM_062  
DW TM_042, $0000, $0000, TM_05C, TM_062, TM_042, TM_062, TM_05C  
DW $0000, $0000, TM_05B, $0000, $0000, TM_05B, $0000, $0000  

;89c5
PEA_UT:		;EA: Samus exhausted, looking up to watch Metroid attack MB, facing right
DW TM_064, TM_065, TM_066, TM_065, $0000, TM_016  

;89d1
PEB_UT:		;EB: Samus exhausted, looking up to watch Metroid attack MB, facing left
DW TM_061, TM_062, TM_063, TM_062, $0000, TM_017, TM_0C8, TM_0C8  

;89e1
P01_LT:		;01: Facing right, normal
P47_LT:		;47: Standing, facing right. Unused?
P89_LT:		;89: Ran into a wall on right (facing right)
PA8_LT:		;A8: Just standing, facing right. Unused? (Grapple movement)
DW TM_0CE, TM_0D6, TM_0D7, TM_0D6, $0000, TM_0CE, TM_0D6, TM_0D7, TM_0D6  

;89f3
P02_LT:		;02: Facing left, normal
P48_LT:		;48: Standing, facing left. Unused?
P8A_LT:		;8A: Ran into a wall on left (facing left)
PA9_LT:		;A9: Just standing, facing left. Unused? (Grapple movement)
DW TM_110, TM_0D8, TM_0E5, TM_0D8, $0000, TM_110, TM_0D8, TM_0E5, TM_0D8, TM_0CE, TM_0CE, TM_110, TM_110  

;8a0d
P03_LT:		;03: Facing right, aiming up
P05_LT:		;05: Facing right, aiming upright
P07_LT:		;07: Facing right, aiming Downright
PAA_LT:		;AA: Just standing, facing right aiming Downright. Unused? (Grapple movement)
PCF_LT:		;CF: Samus ran right into a wall, is still holding right and is now aiming diagonal up
PD1_LT:		;D1: Samus ran right into a wall, is still holding right and is now aiming diagonal Down
DW TM_108, TM_108  

;8a11
P04_LT:		;04: Facing left, aiming up
P06_LT:		;06: Facing left, aiming upleft
P08_LT:		;08: Facing left, aiming Downleft
PAB_LT:		;AB: Just standing, facing left aiming Downleft. Unused? (Grapple movement)
PD0_LT:		;D0: Samus ran left into a wall, is still holding left and is now aiming diagonal up
PD2_LT:		;D2: Samus ran left into a wall, is still holding left and is now aiming diagonal Down
DW TM_109, TM_109, TM_0C8

;8a17
PA4_LT:		;A4: Landing from normal jump, facing right
PE0_LT:		;E0: Landing from normal jump, facing right and aiming up
PE2_LT:		;E2: Landing from normal jump, facing right and aiming upright
PE4_LT:		;E4: Landing from normal jump, facing right and aiming Downright
PE6_LT:		;E6: Landing from normal jump, facing right, firing
DW TM_0EE, TM_0CE  

;8a1b
PA5_LT:		;A5: Landing from normal jump, facing left
PE1_LT:		;E1: Landing from normal jump, facing left and aiming up
PE3_LT:		;E3: Landing from normal jump, facing left and aiming upleft
PE5_LT:		;E5: Landing from normal jump, facing left and aiming Downleft
PE7_LT:		;E7: Landing from normal jump, facing left, firing
DW TM_0EF, TM_110  

;8a1f
PA6_LT:		;A6: Landing from spin jump, facing right
DW TM_100, TM_0EE, TM_0CE  

;8a25
PA7_LT:		;A7: Landing from spin jump, facing left
DW TM_101, TM_0EF, TM_110  

;8a2b
PD5_LT:		;D5: X-raying right, standing
DW TM_0CE, TM_0CE, TM_0CE, TM_0CE, TM_0CE  

;8a35
PD6_LT:		;D6: X-raying left, standing
DW TM_110, TM_110, TM_110, TM_110, TM_110  

;8a3f
PD9_LT:		;D9: X-raying right, crouching
DW TM_111, TM_111, TM_111, TM_111, TM_111  

;8a49
PDA_LT:		;DA: X-raying left, crouching
DW TM_0CF, TM_0CF, TM_0CF, TM_0CF, TM_0CF  

;8a53
P09_LT:		;09: Moving right, not aiming
P0B_LT:		;0B: Moving right, gun extended forward (not aiming)
P0D_LT:		;0D: Moving right, aiming straight up (unused?)
P0F_LT:		;0F: Moving right, aiming upright
P11_LT:		;11: Moving right, aiming Downright
P45_LT:		;45: running, facing right, shooting left. Unused? (Fast moonwalk)
DW TM_0C8, TM_0D0, TM_0C9, TM_0D1, TM_0CA, TM_0CB, TM_0D2, TM_0CC, TM_0D3, TM_0CD  

;8a67
P0A_LT:		;0A: Moving left, not aiming
P0C_LT:		;0C: Moving left, gun extended forward (not aiming)
P0E_LT:		;0E: Moving left, aiming straight up (unused?)
P10_LT:		;10: Moving left, aiming upleft
P12_LT:		;12: Moving left, aiming Downleft
P46_LT:		;46: running, facing left, shooting right. Unused? (Fast moonwalk)
DW TM_10A, TM_112, TM_10B, TM_113, TM_10C, TM_10D, TM_114, TM_10E, TM_115, TM_10F  

;8a7b
P49_LT:		;49: Moonwalk, facing left
P75_LT:		;75: Moonwalk, facing left aiming upleft
P77_LT:		;77: Moonwalk, facing left aiming Downleft
DW TM_117, TM_118, TM_0FC, TM_116, TM_119, TM_0FD  

;8a87
P4A_LT:		;4A: Moonwalk, facing right
P76_LT:		;76: Moonwalk, facing right aiming upright
P78_LT:		;78: Moonwalk, facing right aiming Downright
DW TM_0EB, TM_0EC, TM_0FE, TM_0E8, TM_0ED, TM_0FF 
 
;8a93
P17_LT:		;17: Normal jump facing right, aiming Down
PAE_LT:		;AE: jumping, facing right, aiming Down. Unused? (Grapple movement)
DW TM_0F2, TM_0F8  

;8a97
P18_LT:		;18: Normal jump facing left, aiming Down
PAF_LT:		;AF: jumping, facing left, aiming Down. Unused? (Grapple movement)
DW TM_0F3, TM_0F9  

;8a9b
P13_LT:		;13: Normal jump facing right, gun extended, not aiming or moving
PAC_LT:		;AC: jumping, facing right, gun extended. Unused? (Grapple movement)
DW TM_0F2, TM_100  

;8a9f
P14_LT:		;14: Normal jump facing left, gun extended, not aiming or moving
PAD_LT:		;AD: jumping, facing left, gun extended. Unused? (Grapple movement)
DW TM_0F3, TM_101  

;8aa3
P15_LT:		;15: Normal jump facing right, aiming up
DW TM_0F2, TM_0DB  

;8aa7
P16_LT:		;16: Normal jump facing left, aiming up
DW TM_0F3, TM_0DC  

;8aab
P51_LT:		;51: Normal jump facing right, moving forward (gun extended)
DW TM_0F2, TM_100  

;8aaf
P52_LT:		;52: Normal jump facing left, moving forward (gun extended)
DW TM_0F3, TM_101  

;8ab3
P69_LT:		;69: Normal jump facing right, aiming upright. Moving optional
DW TM_0F2, TM_0DB  

;8ab7
P6A_LT:		;6A: Normal jump facing left, aiming upleft. Moving optional
DW TM_0F3, TM_0DC  

;8abb
P6B_LT:		;6B: Normal jump facing right, aiming Downright. Moving optional
PB0_LT:		;B0: jumping, facing right, aiming Downright. Unused? (Grapple movement)
DW TM_0F2, TM_100  

;8abf
P6C_LT:		;6C: Normal jump facing left, aiming Downleft. Moving optional
PB1_LT:		;B1: jumping, facing left, aiming Downleft. Unused? (Grapple movement)
DW TM_0F3, TM_101  

;8ac3
P4B_LT:		;4B: Normal jump transition from ground(standing or crouching), facing right
P55_LT:		;55: Normal jump transition from ground, facing right and aiming up
P57_LT:		;57: Normal jump transition from ground, facing right and aiming upright
P59_LT:		;59: Normal jump transition from ground, facing right and aiming Downright
DW TM_0EE  

;8ac5
P4C_LT:		;4C: Normal jump transition from ground(standing or crouching), facing left
P56_LT:		;56: Normal jump transition from ground, facing left and aiming up
P58_LT:		;58: Normal jump transition from ground, facing left and aiming upleft
P5A_LT:		;5A: Normal jump transition from ground, facing left and aiming Downleft
DW TM_0EF  

;8ac7
P4D_LT:		;4D: Normal jump facing right, gun not extended, not aiming, not moving
PC7_LT:		;C7: Super jump windup, facing right
DW TM_0CB, TM_0F6, TM_0F0, TM_0F0, TM_0F2, TM_0F4  

;8ad3
P4E_LT:		;4E: Normal jump facing left, gun not extended, not aiming, not moving
PC8_LT:		;C8: Super jump windup, facing left
DW TM_10D, TM_0F7, TM_0F1, TM_0F1, TM_0F3, TM_0F5  

;8adf
P4F_LT:		;4F: Hurt roll back, moving right/facing left
DW TM_0D9, TM_0F3, $0000, $0000, $0000, $0000, $0000, $0000, $0000, TM_101 

;8af3
P50_LT:		;50: Hurt roll back, moving left/facing right
DW TM_0DA, TM_0F2, $0000, $0000, $0000, $0000, $0000, $0000, $0000, TM_100  

;8b07
P63_LT:		;63: Facing left on grapple blocks, ready to jump. Unused?
DW TM_0FC, TM_0E2  

;8b0b
P64_LT:		;64: Facing right on grapple blocks, ready to jump. Unused?
DW TM_0FD, TM_0E1  

;8b0f
P65_LT:		;65: Glitchy jump, facing left. Used by unused grapple jump?
DW TM_0FA, TM_175, TM_176, TM_177, TM_178, TM_179, TM_17A, TM_17B, TM_17C  

;8b21
P66_LT:		;66: Glitchy jump, facing right. Used by unused grapple jump?
DW TM_0FB, TM_187, TM_188, TM_189, TM_18A, TM_18B, TM_18C, TM_18D, TM_18E  

;8b33
P83_LT:		;83: Walljump right
DW TM_0FA, TM_100, $0000, $0000, $0000, $0000, $0000, $0000  
DW $0000, $0000, $0000, $0000, $0000, TM_1A7, TM_1A8, TM_1A9  
DW TM_1AA, TM_1AB, TM_1AC, TM_1AD, TM_1AE, $0000, $0000, TM_1A7  
DW TM_1A8, TM_1A9, TM_1AA, TM_1AB, TM_1AC, TM_1AD, TM_1AE, TM_1A7  
DW TM_1A8, TM_1A9, TM_1AA, TM_1AB, TM_1AC, TM_1AD, TM_1AE, TM_1A7  
DW TM_1A8, TM_1A9, TM_1AA, TM_1AB, TM_1AC, TM_1AD, TM_1AE  

;8b91
P84_LT:		;84: Walljump left
DW TM_0FB, TM_101, $0000, $0000, $0000, $0000, $0000, $0000  
DW $0000, $0000, $0000, $0000, $0000, TM_19F, TM_1A0, TM_1A1  
DW TM_1A2, TM_1A3, TM_1A4, TM_1A5, TM_1A6, $0000, $0000, TM_19F  
DW TM_1A0, TM_1A1, TM_1A2, TM_1A3, TM_1A4, TM_1A5, TM_1A6, TM_19F  
DW TM_1A0, TM_1A1, TM_1A2, TM_1A3, TM_1A4, TM_1A5, TM_1A6, TM_19F  
DW TM_1A0, TM_1A1, TM_1A2, TM_1A3, TM_1A4, TM_1A5, TM_1A6  

;8bef
P53_LT:		;53: Hurt, facing right
DW TM_0F4, TM_102  

;8bf3
P54_LT:		;54: Hurt, facing left
DW TM_0F5, TM_103  

;8bf7
P5B_LT:		;5B: Something for grapple (wall jump?), probably unused
PB8_LT:		;B8: Grapple, attached to a wall on right, facing left
DW TM_0E2  

;8bf9
P5C_LT:		;5C: Something for grapple (wall jump?), probably unused
PB9_LT:		;B9: Grapple, attached to a wall on left, facing right
DW TM_0E1  

;8bfb
P5D_LT:		;5D: Broken grapple? Facing clockwise, maybe unused
P5E_LT:		;5E: Broken grapple? Facing clockwise, maybe unused
P5F_LT:		;5F: Broken grapple? Facing clockwise, maybe unused
P60_LT:		;60: Better broken grapple. Facing clockwise, maybe unused
P61_LT:		;61: Nearly normal grapple. Facing clockwise, maybe unused
PB2_LT:		;B2: Grapple, facing clockwise
DW TM_135, TM_134, TM_133, TM_132, TM_132, TM_131, TM_131, TM_130  
DW TM_130, TM_130, TM_123, TM_123, TM_122, TM_122, TM_121, TM_120  
DW TM_11F, TM_11E, TM_11D, TM_11C, TM_11C, TM_11B, TM_11B, TM_11A  
DW TM_11A, TM_11A, TM_139, TM_139, TM_138, TM_138, TM_137, TM_136  
DW TM_13F, TM_13E, TM_13D, TM_13C, TM_13C, TM_13B, TM_13B, TM_13A  
DW TM_13A, TM_13A, TM_12F, TM_12F, TM_12E, TM_12E, TM_12D, TM_12C  
DW TM_12B, TM_12A, TM_129, TM_128, TM_128, TM_127, TM_127, TM_126  
DW TM_126, TM_126, TM_142, TM_142, TM_141, TM_141, TM_140, TM_13F  
DW TM_124, TM_125  

;8c7f
P62_LT:		;62: Nearly normal grapple. Facing counterclockwise, maybe unused
PB3_LT:		;B3: Grapple, facing counterclockwise
DW TM_15E, TM_15F, TM_160, TM_161, TM_161, TM_162, TM_162, TM_143  
DW TM_143, TM_143, TM_144, TM_144, TM_145, TM_145, TM_146, TM_147  
DW TM_148, TM_149, TM_14A, TM_14B, TM_14B, TM_14C, TM_14C, TM_159  
DW TM_159, TM_159, TM_15A, TM_15A, TM_15B, TM_15B, TM_15C, TM_15D  
DW TM_168, TM_169, TM_16A, TM_16B, TM_16B, TM_16C, TM_16C, TM_14F  
DW TM_14F, TM_14F, TM_150, TM_150, TM_151, TM_151, TM_152, TM_153  
DW TM_154, TM_155, TM_156, TM_157, TM_157, TM_158, TM_158, TM_163  
DW TM_163, TM_163, TM_164, TM_164, TM_165, TM_165, TM_166, TM_167  
DW TM_14D, TM_14E  

;8d03
P29_LT:		;29: Falling facing right, normal pose
P67_LT:		;67: Facing right, falling, fired a shot
DW TM_0F2, TM_0F4, TM_0F4, $0000, $0000, TM_0F2, TM_100  

;8d11
P2A_LT:		;2A: Falling facing left, normal pose
P68_LT:		;68: Facing left, falling, fired a shot
DW TM_0F3, TM_0F5, TM_0F5, $0000, $0000, TM_0F3, TM_101  

;8d1f
P2D_LT:		;2D: Falling facing right, aiming Down
DW TM_0F2, TM_0F8  

;8d23
P2E_LT:		;2E: Falling facing left, aiming Down
DW TM_0F3, TM_0F9  

;8d27
P2B_LT:		;2B: Falling facing right, aiming up
DW TM_0F2, TM_0F4, TM_100  

;8d2d
P2C_LT:		;2C: Falling facing left, aiming up
DW TM_0F3, TM_0F5, TM_101  

;8d33
P6D_LT:		;6D: Falling facing right, aiming upright
DW TM_0F2, TM_0F4, TM_100  

;8d39
P6E_LT:		;6E: Falling facing left, aiming upleft
DW TM_0F3, TM_0F5, TM_101  

;8d3f
P6F_LT:		;6F: Falling facing right, aiming Downright
DW TM_0F2, TM_0F4, TM_100  

;8d45
P70_LT:		;70: Falling facing left, aiming Downleft
DW TM_0F3, TM_0F5, TM_101  

;8d4b
P27_LT:		;27: Crouching, facing right
PB4_LT:		;B4: Crouching, facing right. Unused? (Grapple movement)
DW TM_111, TM_111, TM_111, TM_111, $0000, TM_111, TM_111, TM_111, TM_111  

;8d5d
P28_LT:		;28: Crouching, facing left
PB5_LT:		;B5: Crouching, facing left. Unused? (Grapple movement)
DW TM_0CF, TM_0CF, TM_0CF, TM_0CF, $0000, TM_0CF, TM_0CF, TM_0CF, TM_0CF  

;8d6f
P71_LT:		;71: Standing to crouching, facing right and aiming upright
DW TM_111  

;8d71
P72_LT:		;72: Standing to crouching, facing left and aiming upleft
DW TM_0CF  

;8d73
P73_LT:		;73: Standing to crouching, facing right and aiming Downright
PB6_LT:		;B6: Crouching, facing right, aiming Downright. Unused? (Grapple movement)
DW TM_111  

;8d75
P74_LT:		;74: Standing to crouching, facing left and aiming Downleft
PB7_LT:		;B7: Crouching, facing left, aiming Downleft. Unused? (Grapple movement)
DW TM_0CF  

;8d77
P85_LT:		;85: Crouching, facing right aiming up
DW TM_111, TM_111  

;8d7b
P86_LT:		;86: Crouching, facing left aiming up
DW TM_0CF, TM_0CF  

;8d7f
P35_LT:		;35: Crouch transition, facing right
P3B_LT:		;3B: Standing from crouching, facing right
PF1_LT:		;F1: Crouch transition, facing right and aiming up
PF3_LT:		;F3: Crouch transition, facing right and aiming upright
PF5_LT:		;F5: Crouch transition, facing right and aiming Downright
PF7_LT:		;F7: Crouching to standing, facing right and aiming up
PF9_LT:		;F9: Crouching to standing, facing right and aiming upright
PFB_LT:		;FB: Crouching to standing, facing right and aiming Downright
DW TM_0EE  

;8d81
P36_LT:		;36: Crouch transition, facing left
P3C_LT:		;3C: Standing from crouching, facing left
PF2_LT:		;F2: Crouch transition, facing left and aiming up
PF4_LT:		;F4: Crouch transition, facing left and aiming upleft
PF6_LT:		;F6: Crouch transition, facing left and aiming Downleft
PF8_LT:		;F8: Crouching to standing, facing left and aiming up
PFA_LT:		;FA: Crouching to standing, facing left and aiming upleft
PFC_LT:		;FC: Crouching to standing, facing left and aiming Downleft
DW TM_0EF, $0000, $0000  

;8d87
PDB_LT:		;DB: Standing transition to morphball, facing right? Unused?
DW TM_0EE, $0000, $0000 
 
;8d8d
PDC_LT:		;DC: Standing transition to morphball, facing left? Unused?
DW TM_0EE  

;8d8f
PDD_LT:		;DD: Morphball transition to standing, facing right? Unused?
DW $0000, $0000, TM_0EE  

;8d95
PDE_LT:		;DE: Morphball transition to standing, facing left? Unused?
DW $0000, $0000, TM_0EE  

;8d9b
P25_LT:		;25: starting standing right, turning left
P8B_LT:		;8B: Turning around from right to left while aiming straight up while standing
P8D_LT:		;8D: Turn around from right to left while aiming diagonal Down while standing
P9C_LT:		;9C: Turning around from right to left while aiming diagonal up while standing
PBF_LT:		;BF: jump/Turn right to left while moonwalking.
PC1_LT:		;C1: jump/Turn right to left while moonwalking and aiming diagonal up.
PC3_LT:		;C3: jump/Turn right to left while moonwalking and aiming diagonal Down.
PC6_LT:		;C6: Morph ball, facing left. Unused? (Grabbed by Draygon movement)
DW TM_0DE, TM_0E9, TM_0DD

;8da1
P26_LT:		;26: starting standing left, turning right
P8C_LT:		;8C: Turning around from left to right while aiming straight up while standing
P8E_LT:		;8E: Turn around from left to right while aiming diagonal Down while standing
P9D_LT:		;9D: Turning around from left to right while aiming diagonal up while standing
PC0_LT:		;C0: jump/Turn left to right while moonwalking.
PC2_LT:		;C2: jump/Turn left to right while moonwalking and aiming diagonal up.
PC4_LT:		;C4: jump/Turn left to right while moonwalking and aiming diagonal Down.
DW TM_0DD, TM_0E9, TM_0DE

;8da7
P2F_LT:		;2F: starting with normal jump facing right, turning left
P43_LT:		;43: starting from crouching right, turning left
P87_LT:		;87: Turning from right to left while falling
P8F_LT:		;8F: Turning around from right to left while aiming straight up in midair
P91_LT:		;91: Turning around from right to left while aiming Down or diagonal Down in midair
P93_LT:		;93: Turning around from right to left while aiming straight up while falling
P95_LT:		;95: Turning around from right to left while aiming Down or diagonal Down while falling
P97_LT:		;97: Turning around from right to left while aiming straight up while crouching
P99_LT:		;99: Turning around from right to left while aiming diagonal Down while crouching
P9E_LT:		;9E: Turning around from right to left while aiming diagonal up in midair
PA0_LT:		;A0: Turning around from right to left while aiming diagonal up while falling
PA2_LT:		;A2: Turn around from right to left while aiming diagonal up while crouching
DW TM_0E0, TM_0EA, TM_0DF

;8dad
P30_LT:		;30: starting with normal jump facing left, turning right
P44_LT:		;44: starting from crouching left, turning right
P90_LT:		;90: Turning around from left to right while aiming straight up in midair
P92_LT:		;92: Turning around from left to right while aiming Down or diagonal Down in midair
P98_LT:		;98: Turning around from left to right while aiming straight up while crouching
P9A_LT:		;9A: Turning around from left to right while aiming diagonal Down while crouching
P9F_LT:		;9F: Turning around from left to right while aiming diagonal up in midair
PA3_LT:		;A3: Turn around from left to right while aiming diagonal up while crouching
DW TM_0DF, TM_0EA, TM_0E0, TM_0E0, TM_0EA, TM_0DF  

;8db9
P88_LT:		;88: Turning from left to right while falling
P94_LT:		;94: Turning around from left to right while aiming straight up while falling
P96_LT:		;96: Turning around from left to right while aiming Down or diagonal Down while falling
PA1_LT:		;A1: Turning around from left to right while aiming diagonal up while falling
DW TM_0DF, TM_0EA, TM_0E0

;8dbf
PEC_LT:		;EC: Grabbed by Draygon, facing right. Not moving
PED_LT:		;ED: Grabbed by Draygon, facing right aiming upright. Not moving
PEE_LT:		;EE: Grabbed by Draygon, facing right and firing.
PEF_LT:		;EF: Grabbed by Draygon, facing right aiming Downright. Not moving
DW TM_102  

;8dc1
PBA_LT:		;BA: Grabbed by Draygon, facing left, not moving
PBB_LT:		;BB: Grabbed by Draygon, facing left aiming upleft, not moving
PBC_LT:		;BC: Grabbed by Draygon, facing left and firing
PBD_LT:		;BD: Grabbed by Draygon, facing left aiming Downleft, not moving
DW TM_103  

;8dc3
PF0_LT:		;F0: Grabbed by Draygon, facing right. Moving
DW TM_0F4, TM_102, TM_100, TM_0F4, TM_0F6, TM_0F0  

;8dcf
PBE_LT:		;BE: Grabbed by Draygon, facing left, moving
DW TM_0F5, TM_103, TM_101, TM_0F5, TM_0F7, TM_0F1  

;8ddb
PC9_LT:		;C9: Horizontal super jump, right
DW TM_0E3  

;8ddd
PCA_LT:		;CA: Horizontal super jump, left
DW TM_0E4  

;8ddf
PCD_LT:		;CD: Diagonal super jump, right
DW TM_0E3  

;8de1
PCE_LT:		;CE: Diagonal super jump, left
DW TM_0E4  

;8de3
PD3_LT:		;D3: Crystal flash, facing right
DW TM_19C, TM_19D, TM_19E, TM_19E, $0000, $0000, TM_19E, TM_19E  
DW TM_19E, TM_19E, $0000, $0000, TM_19D, TM_19C, TM_0EE  

;8e01
PD4_LT:		;D4: Crystal flash, facing left
DW TM_19C, TM_19D, TM_19E, TM_19E, $0000, $0000, TM_19E, TM_19E  
DW TM_19E, TM_19E, $0000, $0000, TM_19D, TM_19C, TM_0EF  

;8e1f
PD7_LT:		;D7: Crystal flash ending, facing right
DW $0000, $0000, $0000, TM_0EE, TM_0F4, TM_102  

;8e2b
PD8_LT:		;D8: Crystal flash ending, facing left
DW $0000, $0000, $0000, TM_0EF, TM_0F5, TM_103  

;8e37
PE8_LT:		;E8: Samus exhausted(Metroid drain, MB attack), facing right
DW $0000, $0000, $0000, TM_0F4, TM_0F4, TM_0F4, TM_0F4, TM_0F4  
DW TM_105, TM_105, TM_105, TM_105, $0000, $0000, TM_0EE  

;8e55
PE9_LT:		;E9: Samus exhausted(Metroid drain, MB attack), facing left
DW $0000, $0000, TM_0F5, TM_0F5, TM_0F5, TM_0F5, TM_0F5, TM_0EF  
DW TM_104, TM_104, TM_104, TM_104, $0000, $0000, TM_101, TM_0EF  
DW TM_109, $0000, $0000, TM_101, TM_0EF, TM_109, TM_0EF, TM_101  
DW $0000, $0000, TM_104, $0000, $0000, TM_104, $0000, $0000  

;8e95
PEA_LT:		;EA: Samus exhausted, looking up to watch Metroid attack MB, facing right
DW TM_105, TM_105, TM_105, TM_105, $0000, TM_0EE  

;8ea1
PEB_LT:		;EB: Samus exhausted, looking up to watch Metroid attack MB, facing left
DW TM_104, TM_104, TM_104, TM_104, $0000, TM_0EF  

;8ead
P1D_UT:		;1D: Facing right as morphball, no springball
P31_UT:		;31: Midair morphball facing right without springball
P32_UT:		;32: Midair morphball facing left without springball
P3F_UT:		;3F: Some transition with morphball, facing right. Maybe unused
P40_UT:		;40: Some transition with morphball, facing left. Maybe unused
P1D_LT:		;1D: Facing right as morphball, no springball
P31_LT:		;31: Midair morphball facing right without springball
P32_LT:		;32: Midair morphball facing left without springball
P3F_LT:		;3F: Some transition with morphball, facing right. Maybe unused
P40_LT:		;40: Some transition with morphball, facing left. Maybe unused
DW TM_16D, TM_171, TM_16E, TM_172, TM_16F, TM_173, TM_170, TM_174, $0000, TM_182  

;8ec1
P41_UT:		;41: Staying still with morphball, facing left, no springball
PC5_UT:		;C5: Morph ball, facing right. Unused? (Grabbed by Draygon movement)
PDF_UT:		;DF: Samus is facing left as a morphball. Unused? (Grabbed by Draygon movement)
P41_LT:		;41: Staying still with morphball, facing left, no springball
PC5_LT:		;C5: Morph ball, facing right. Unused? (Grabbed by Draygon movement)
PDF_LT:		;DF: Samus is facing left as a morphball. Unused? (Grabbed by Draygon movement)
DW TM_174, TM_170, TM_173, TM_16F, TM_172, TM_16E, TM_171, TM_16D, $0000, TM_182  

;8ed5
P1E_UT:		;1E: Moving right as a morphball on ground without springball
P1E_LT:		;1E: Moving right as a morphball on ground without springball
DW TM_16D, TM_171, TM_16E, TM_172, TM_16F, TM_173, TM_170, TM_174, $0000, TM_182

;8ee9
P1F_UT:		;1F: Moving left as a morphball on ground without springball
P1F_LT:		;1F: Moving left as a morphball on ground without springball
DW  TM_174, TM_170, TM_173, TM_16F, TM_172, TM_16E, TM_171, TM_16D, $0000, TM_182

;8efd
P79_UT:		;79: Spring ball on ground, facing right
P7B_UT:		;7B: Spring ball on ground, moving right
P7D_UT:		;7D: Spring ball falling, facing/moving right
P7F_UT:		;7F: Spring ball jump in air, facing/moving right
P79_LT:		;79: Spring ball on ground, facing right
P7B_LT:		;7B: Spring ball on ground, moving right
P7D_LT:		;7D: Spring ball falling, facing/moving right
P7F_LT:		;7F: Spring ball jump in air, facing/moving right
DW  TM_16D, TM_171, TM_16E, TM_172, TM_16F, TM_173, TM_170, TM_174, $0000, TM_182

;8f11
P7A_UT:		;7A: Spring ball on ground, facing left
P7C_UT:		;7C: Spring ball on ground, moving left
P7E_UT:		;7E: Spring ball falling, facing/moving left
P80_UT:		;80: Spring ball jump in air, facing/moving left
P7A_LT:		;7A: Spring ball on ground, facing left
P7C_LT:		;7C: Spring ball on ground, moving left
P7E_LT:		;7E: Spring ball falling, facing/moving left
P80_LT:		;80: Spring ball jump in air, facing/moving left
DW  TM_174, TM_170, TM_173, TM_16F, TM_172, TM_16E, TM_171, TM_16D, $0000, TM_182  

;8f25
P19_UT:		;19: Spin jump right
P20_UT:		;20: Spinjump right. Unused?
P21_UT:		;21: Spinjump right. Unused?
P22_UT:		;22: Spinjump right. Unused?
P23_UT:		;23: Spinjump right. Unused?
P24_UT:		;24: Spinjump right. Unused?
P33_UT:		;33: Spinjump right. Unused?
P34_UT:		;34: Spinjump right. Unused?
P39_UT:		;39: Midair morphing into ball, facing right? May be unused
P3A_UT:		;3A: Midair morphing into ball, facing left? May be unused
P42_UT:		;42: Spinjump right. Unused?
P20_LT:		;20: Spinjump right. Unused?
P21_LT:		;21: Spinjump right. Unused?
P22_LT:		;22: Spinjump right. Unused?
P23_LT:		;23: Spinjump right. Unused?
P24_LT:		;24: Spinjump right. Unused?
P33_LT:		;33: Spinjump right. Unused?
P34_LT:		;34: Spinjump right. Unused?
P39_LT:		;39: Midair morphing into ball, facing right? May be unused
P3A_LT:		;3A: Midair morphing into ball, facing left? May be unused
P42_LT:		;42: Spinjump right. Unused?
DW TM_043, TM_187, TM_188, TM_189, TM_18A, TM_18B, TM_18C, TM_18D, TM_18E, $0000, $0000, TM_03E 

;8f3d
P19_LT:		;19: Spin jump right
DW TM_100, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, TM_0E6  

;8f55
P1A_UT:		;1A: Spin jump left
DW TM_044, TM_175, TM_176, TM_177, TM_178, TM_179, TM_17A, TM_17B, TM_17C, $0000, $0000, TM_03F  

;8f6d
P1A_LT:		;1A: Spin jump left
DW TM_101, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, TM_0E7  

;8f85
P1B_UT:		;1B: Space jump right
DW TM_043, TM_193, TM_193, TM_193, TM_193, TM_193, TM_193, TM_193, TM_193, $0000, $0000, TM_03E  

;8f9d
P1B_LT:		;1B: Space jump right
DW TM_100, TM_1A7, TM_1A8, TM_1A9, TM_1AA, TM_1AB, TM_1AC, TM_1AD, TM_1AE, $0000, $0000, TM_0E6  

;8fb5
P1C_UT:		;1C: Space jump left
DW TM_044, TM_181, TM_181, TM_181, TM_181, TM_181, TM_181, TM_181, TM_181, $0000, $0000, TM_03F  

;8fcd
P1C_LT:		;1C: Space jump left
DW TM_101, TM_19F, TM_1A0, TM_1A1, TM_1A2, TM_1A3, TM_1A4, TM_1A5, TM_1A6, $0000, $0000, TM_0E7  

;8fe5
P81_UT:		;81: Screw attack right
DW TM_043, TM_18F, TM_18F, TM_18F, TM_193, TM_193, TM_193, TM_190  
DW TM_190, TM_190, TM_193, TM_193, TM_193, TM_191, TM_191, TM_191  
DW TM_193, TM_193, TM_193, TM_192, TM_192, TM_192, TM_193, TM_193
DW TM_193, $0000, $0000, TM_03E  

;901d
P81_LT:		;81: Screw attack right
DW TM_100, TM_1A7, TM_1A8, TM_1A9, TM_1AA, TM_1AB, TM_1AC, TM_1AD  
DW TM_1AE, TM_1A7, TM_1A8, TM_1A9, TM_1AA, TM_1AB, TM_1AC, TM_1AD  
DW TM_1AE, TM_1A7, TM_1A8, TM_1A9, TM_1AA, TM_1AB, TM_1AC, TM_1AD
DW TM_1AE, $0000, $0000, TM_0E6 

;9055
P82_UT:		;82: Screw attack left
DW TM_044, TM_17D, TM_17D, TM_17D, TM_181, TM_181, TM_181, TM_17E  
DW TM_17E, TM_17E, TM_181, TM_181, TM_181, TM_17F, TM_17F, TM_17F  
DW TM_181, TM_181, TM_181, TM_180, TM_180, TM_180, TM_181, TM_181
DW TM_181, $0000, $0000, TM_03F 

;908d
P82_LT:		;82: Screw attack left
DW TM_101, TM_19F, TM_1A0, TM_1A1, TM_1A2, TM_1A3, TM_1A4, TM_1A5  
DW TM_1A6, TM_19F, TM_1A0, TM_1A1, TM_1A2, TM_1A3, TM_1A4, TM_1A5  
DW TM_1A6, TM_19F, TM_1A0, TM_1A1, TM_1A2, TM_1A3, TM_1A4, TM_1A5
DW TM_1A6, $0000, $0000, TM_0E7  

;90c5		this is never pointed to?
DW TM_1B8, TM_1B9, TM_1BA, TM_1BB, TM_1BC, TM_1BD, TM_1BE, TM_1BF  
DW TM_1C0, TM_1AF, TM_1B0, TM_1B1, TM_1B2, TM_1B3, TM_1B4, TM_1B5  
DW TM_1B6, TM_1B7  

;90E9
PCB_UT:		;CB: Vertical super jump, facing right
PCB_LT:		;CB: Vertical super jump, facing right
DW TM_194 

;90EB
PCC_UT:		;CC: Vertical super jump, facing left
PCC_LT:		;CC: Vertical super jump, facing left
DW TM_195  


ORG $9290ED		;tilemaps here for some reason...

;90ED
TM_000:
DW $0001  
DB $FC, $01, $FC, $5A, $31 

;90F4
TM_001:
DW $0019
DB $39, $00, $E8, $36, $31 
DB $31, $00, $E8, $44, $31 
DB $29, $00, $E8, $31, $31 
DB $21, $00, $E8, $34, $31 
DB $19, $00, $E8, $33, $31 
DB $10, $00, $08, $4B, $31 
DB $08, $00, $08, $3D, $31 
DB $00, $00, $08, $3E, $31 
DB $F8, $01, $08, $38, $31 
DB $F0, $01, $08, $43, $31 
DB $E8, $01, $08, $3F, $31 
DB $E0, $01, $08, $3E, $31 
DB $10, $00, $F8, $4A, $31 
DB $08, $00, $F8, $3D, $31 
DB $00, $00, $F8, $3E, $31 
DB $F8, $01, $F8, $38, $31 
DB $F0, $01, $F8, $43, $31 
DB $E8, $01, $F8, $3F, $31 
DB $E0, $01, $F8, $3E, $31 
DB $08, $00, $E8, $3B, $31 
DB $00, $00, $E8, $30, $31 
DB $F8, $01, $E8, $44, $31 
DB $F0, $01, $E8, $42, $31 
DB $E8, $01, $E8, $38, $31 
DB $E0, $01, $E8, $45, $31 

;9173		;unused?  this is never pointed to
DW $0001
DB $00, $00, $00, $5F, $3A 

;917A
TM_002:
DW $0010
DB $18, $00, $00, $17, $38 
DB $10, $00, $00, $16, $38 
DB $08, $00, $00, $15, $38 
DB $00, $00, $00, $14, $38 
DB $F8, $01, $00, $13, $38 
DB $F0, $01, $00, $12, $38 
DB $E8, $01, $00, $11, $38 
DB $E0, $01, $00, $10, $38 
DB $18, $00, $F8, $07, $38 
DB $10, $00, $F8, $06, $38 
DB $08, $00, $F8, $05, $38 
DB $00, $00, $F8, $04, $38 
DB $F8, $01, $F8, $03, $38 
DB $F0, $01, $F8, $02, $38 
DB $E8, $01, $F8, $01, $38 
DB $E0, $01, $F8, $00, $38 

;91CC  
TM_003:
DW $0010
DB $18, $00, $00, $1F, $38 
DB $10, $00, $00, $1E, $38 
DB $08, $00, $00, $1D, $38 
DB $00, $00, $00, $1C, $38 
DB $F8, $01, $00, $1B, $38 
DB $F0, $01, $00, $1A, $38 
DB $E8, $01, $00, $19, $38 
DB $E0, $01, $00, $18, $38 
DB $18, $00, $F8, $0F, $38 
DB $10, $00, $F8, $0E, $38 
DB $08, $00, $F8, $0D, $38 
DB $00, $00, $F8, $0C, $38 
DB $F8, $01, $F8, $0B, $38 
DB $F0, $01, $F8, $0A, $38 
DB $E8, $01, $F8, $09, $38 
DB $E0, $01, $F8, $08, $38 

;921E  
TM_004:
DW $0008
DB $18, $00, $00, $37, $3C 
DB $10, $00, $00, $36, $3C 
DB $08, $00, $00, $35, $3C 
DB $00, $00, $00, $34, $3C 
DB $F8, $01, $00, $33, $3C 
DB $F0, $01, $00, $32, $3C 
DB $E8, $01, $00, $31, $3C 
DB $E0, $01, $00, $30, $3C 

;9248
TM_005:
DW $0005
DB $00, $00, $00, $24, $3A 
DB $F8, $01, $00, $23, $3A 
DB $F0, $01, $00, $22, $3A 
DB $E8, $01, $00, $21, $3A 
DB $E0, $01, $00, $20, $3A

ORG $929263		;upper half indexing
DW P00_UT-$808D/2, P01_UT-$808D/2, P02_UT-$808D/2, P03_UT-$808D/2, P04_UT-$808D/2, P05_UT-$808D/2, P06_UT-$808D/2, P07_UT-$808D/2, P08_UT-$808D/2, P09_UT-$808D/2, P0A_UT-$808D/2, P0B_UT-$808D/2, P0C_UT-$808D/2, P0D_UT-$808D/2, P0E_UT-$808D/2, P0F_UT-$808D/2
DW P10_UT-$808D/2, P11_UT-$808D/2, P12_UT-$808D/2, P13_UT-$808D/2, P14_UT-$808D/2, P15_UT-$808D/2, P16_UT-$808D/2, P17_UT-$808D/2, P18_UT-$808D/2, P19_UT-$808D/2, P1A_UT-$808D/2, P1B_UT-$808D/2, P1C_UT-$808D/2, P1D_UT-$808D/2, P1E_UT-$808D/2, P1F_UT-$808D/2
DW P20_UT-$808D/2, P21_UT-$808D/2, P22_UT-$808D/2, P23_UT-$808D/2, P24_UT-$808D/2, P25_UT-$808D/2, P26_UT-$808D/2, P27_UT-$808D/2, P28_UT-$808D/2, P29_UT-$808D/2, P2A_UT-$808D/2, P2B_UT-$808D/2, P2C_UT-$808D/2, P2D_UT-$808D/2, P2E_UT-$808D/2, P2F_UT-$808D/2
DW P30_UT-$808D/2, P31_UT-$808D/2, P32_UT-$808D/2, P33_UT-$808D/2, P34_UT-$808D/2, P35_UT-$808D/2, P36_UT-$808D/2, P37_UT-$808D/2, P38_UT-$808D/2, P39_UT-$808D/2, P3A_UT-$808D/2, P3B_UT-$808D/2, P3C_UT-$808D/2, P3D_UT-$808D/2, P3E_UT-$808D/2, P3F_UT-$808D/2
DW P40_UT-$808D/2, P41_UT-$808D/2, P42_UT-$808D/2, P43_UT-$808D/2, P44_UT-$808D/2, P45_UT-$808D/2, P46_UT-$808D/2, P47_UT-$808D/2, P48_UT-$808D/2, P49_UT-$808D/2, P4A_UT-$808D/2, P4B_UT-$808D/2, P4C_UT-$808D/2, P4D_UT-$808D/2, P4E_UT-$808D/2, P4F_UT-$808D/2
DW P50_UT-$808D/2, P51_UT-$808D/2, P52_UT-$808D/2, P53_UT-$808D/2, P54_UT-$808D/2, P55_UT-$808D/2, P56_UT-$808D/2, P57_UT-$808D/2, P58_UT-$808D/2, P59_UT-$808D/2, P5A_UT-$808D/2, P5B_UT-$808D/2, P5C_UT-$808D/2, P5D_UT-$808D/2, P5E_UT-$808D/2, P5F_UT-$808D/2
DW P60_UT-$808D/2, P61_UT-$808D/2, P62_UT-$808D/2, P63_UT-$808D/2, P64_UT-$808D/2, P65_UT-$808D/2, P66_UT-$808D/2, P67_UT-$808D/2, P68_UT-$808D/2, P69_UT-$808D/2, P6A_UT-$808D/2, P6B_UT-$808D/2, P6C_UT-$808D/2, P6D_UT-$808D/2, P6E_UT-$808D/2, P6F_UT-$808D/2
DW P70_UT-$808D/2, P71_UT-$808D/2, P72_UT-$808D/2, P73_UT-$808D/2, P74_UT-$808D/2, P75_UT-$808D/2, P76_UT-$808D/2, P77_UT-$808D/2, P78_UT-$808D/2, P79_UT-$808D/2, P7A_UT-$808D/2, P7B_UT-$808D/2, P7C_UT-$808D/2, P7D_UT-$808D/2, P7E_UT-$808D/2, P7F_UT-$808D/2
DW P80_UT-$808D/2, P81_UT-$808D/2, P82_UT-$808D/2, P83_UT-$808D/2, P84_UT-$808D/2, P85_UT-$808D/2, P86_UT-$808D/2, P87_UT-$808D/2, P88_UT-$808D/2, P89_UT-$808D/2, P8A_UT-$808D/2, P8B_UT-$808D/2, P8C_UT-$808D/2, P8D_UT-$808D/2, P8E_UT-$808D/2, P8F_UT-$808D/2
DW P90_UT-$808D/2, P91_UT-$808D/2, P92_UT-$808D/2, P93_UT-$808D/2, P94_UT-$808D/2, P95_UT-$808D/2, P96_UT-$808D/2, P97_UT-$808D/2, P98_UT-$808D/2, P99_UT-$808D/2, P9A_UT-$808D/2, P9B_UT-$808D/2, P9C_UT-$808D/2, P9D_UT-$808D/2, P9E_UT-$808D/2, P9F_UT-$808D/2
DW PA0_UT-$808D/2, PA1_UT-$808D/2, PA2_UT-$808D/2, PA3_UT-$808D/2, PA4_UT-$808D/2, PA5_UT-$808D/2, PA6_UT-$808D/2, PA7_UT-$808D/2, PA8_UT-$808D/2, PA9_UT-$808D/2, PAA_UT-$808D/2, PAB_UT-$808D/2, PAC_UT-$808D/2, PAD_UT-$808D/2, PAE_UT-$808D/2, PAF_UT-$808D/2
DW PB0_UT-$808D/2, PB1_UT-$808D/2, PB2_UT-$808D/2, PB3_UT-$808D/2, PB4_UT-$808D/2, PB5_UT-$808D/2, PB6_UT-$808D/2, PB7_UT-$808D/2, PB8_UT-$808D/2, PB9_UT-$808D/2, PBA_UT-$808D/2, PBB_UT-$808D/2, PBC_UT-$808D/2, PBD_UT-$808D/2, PBE_UT-$808D/2, PBF_UT-$808D/2
DW PC0_UT-$808D/2, PC1_UT-$808D/2, PC2_UT-$808D/2, PC3_UT-$808D/2, PC4_UT-$808D/2, PC5_UT-$808D/2, PC6_UT-$808D/2, PC7_UT-$808D/2, PC8_UT-$808D/2, PC9_UT-$808D/2, PCA_UT-$808D/2, PCB_UT-$808D/2, PCC_UT-$808D/2, PCD_UT-$808D/2, PCE_UT-$808D/2, PCF_UT-$808D/2
DW PD0_UT-$808D/2, PD1_UT-$808D/2, PD2_UT-$808D/2, PD3_UT-$808D/2, PD4_UT-$808D/2, PD5_UT-$808D/2, PD6_UT-$808D/2, PD7_UT-$808D/2, PD8_UT-$808D/2, PD9_UT-$808D/2, PDA_UT-$808D/2, PDB_UT-$808D/2, PDC_UT-$808D/2, PDD_UT-$808D/2, PDE_UT-$808D/2, PDF_UT-$808D/2
DW PE0_UT-$808D/2, PE1_UT-$808D/2, PE2_UT-$808D/2, PE3_UT-$808D/2, PE4_UT-$808D/2, PE5_UT-$808D/2, PE6_UT-$808D/2, PE7_UT-$808D/2, PE8_UT-$808D/2, PE9_UT-$808D/2, PEA_UT-$808D/2, PEB_UT-$808D/2, PEC_UT-$808D/2, PED_UT-$808D/2, PEE_UT-$808D/2, PEF_UT-$808D/2
DW PF0_UT-$808D/2, PF1_UT-$808D/2, PF2_UT-$808D/2, PF3_UT-$808D/2, PF4_UT-$808D/2, PF5_UT-$808D/2, PF6_UT-$808D/2, PF7_UT-$808D/2, PF8_UT-$808D/2, PF9_UT-$808D/2, PFA_UT-$808D/2, PFB_UT-$808D/2, PFC_UT-$808D/2

;ends @ $92945C

ORG $92945D		;lower half indexing
DW P00_LT-$808D/2, P01_LT-$808D/2, P02_LT-$808D/2, P03_LT-$808D/2, P04_LT-$808D/2, P05_LT-$808D/2, P06_LT-$808D/2, P07_LT-$808D/2, P08_LT-$808D/2, P09_LT-$808D/2, P0A_LT-$808D/2, P0B_LT-$808D/2, P0C_LT-$808D/2, P0D_LT-$808D/2, P0E_LT-$808D/2, P0F_LT-$808D/2
DW P10_LT-$808D/2, P11_LT-$808D/2, P12_LT-$808D/2, P13_LT-$808D/2, P14_LT-$808D/2, P15_LT-$808D/2, P16_LT-$808D/2, P17_LT-$808D/2, P18_LT-$808D/2, P19_LT-$808D/2, P1A_LT-$808D/2, P1B_LT-$808D/2, P1C_LT-$808D/2, P1D_LT-$808D/2, P1E_LT-$808D/2, P1F_LT-$808D/2
DW P20_LT-$808D/2, P21_LT-$808D/2, P22_LT-$808D/2, P23_LT-$808D/2, P24_LT-$808D/2, P25_LT-$808D/2, P26_LT-$808D/2, P27_LT-$808D/2, P28_LT-$808D/2, P29_LT-$808D/2, P2A_LT-$808D/2, P2B_LT-$808D/2, P2C_LT-$808D/2, P2D_LT-$808D/2, P2E_LT-$808D/2, P2F_LT-$808D/2
DW P30_LT-$808D/2, P31_LT-$808D/2, P32_LT-$808D/2, P33_LT-$808D/2, P34_LT-$808D/2, P35_LT-$808D/2, P36_LT-$808D/2, P37_LT-$808D/2, P38_LT-$808D/2, P39_LT-$808D/2, P3A_LT-$808D/2, P3B_LT-$808D/2, P3C_LT-$808D/2, P3D_LT-$808D/2, P3E_LT-$808D/2, P3F_LT-$808D/2
DW P40_LT-$808D/2, P41_LT-$808D/2, P42_LT-$808D/2, P43_LT-$808D/2, P44_LT-$808D/2, P45_LT-$808D/2, P46_LT-$808D/2, P47_LT-$808D/2, P48_LT-$808D/2, P49_LT-$808D/2, P4A_LT-$808D/2, P4B_LT-$808D/2, P4C_LT-$808D/2, P4D_LT-$808D/2, P4E_LT-$808D/2, P4F_LT-$808D/2
DW P50_LT-$808D/2, P51_LT-$808D/2, P52_LT-$808D/2, P53_LT-$808D/2, P54_LT-$808D/2, P55_LT-$808D/2, P56_LT-$808D/2, P57_LT-$808D/2, P58_LT-$808D/2, P59_LT-$808D/2, P5A_LT-$808D/2, P5B_LT-$808D/2, P5C_LT-$808D/2, P5D_LT-$808D/2, P5E_LT-$808D/2, P5F_LT-$808D/2
DW P60_LT-$808D/2, P61_LT-$808D/2, P62_LT-$808D/2, P63_LT-$808D/2, P64_LT-$808D/2, P65_LT-$808D/2, P66_LT-$808D/2, P67_LT-$808D/2, P68_LT-$808D/2, P69_LT-$808D/2, P6A_LT-$808D/2, P6B_LT-$808D/2, P6C_LT-$808D/2, P6D_LT-$808D/2, P6E_LT-$808D/2, P6F_LT-$808D/2
DW P70_LT-$808D/2, P71_LT-$808D/2, P72_LT-$808D/2, P73_LT-$808D/2, P74_LT-$808D/2, P75_LT-$808D/2, P76_LT-$808D/2, P77_LT-$808D/2, P78_LT-$808D/2, P79_LT-$808D/2, P7A_LT-$808D/2, P7B_LT-$808D/2, P7C_LT-$808D/2, P7D_LT-$808D/2, P7E_LT-$808D/2, P7F_LT-$808D/2
DW P80_LT-$808D/2, P81_LT-$808D/2, P82_LT-$808D/2, P83_LT-$808D/2, P84_LT-$808D/2, P85_LT-$808D/2, P86_LT-$808D/2, P87_LT-$808D/2, P88_LT-$808D/2, P89_LT-$808D/2, P8A_LT-$808D/2, P8B_LT-$808D/2, P8C_LT-$808D/2, P8D_LT-$808D/2, P8E_LT-$808D/2, P8F_LT-$808D/2
DW P90_LT-$808D/2, P91_LT-$808D/2, P92_LT-$808D/2, P93_LT-$808D/2, P94_LT-$808D/2, P95_LT-$808D/2, P96_LT-$808D/2, P97_LT-$808D/2, P98_LT-$808D/2, P99_LT-$808D/2, P9A_LT-$808D/2, P9B_LT-$808D/2, P9C_LT-$808D/2, P9D_LT-$808D/2, P9E_LT-$808D/2, P9F_LT-$808D/2
DW PA0_LT-$808D/2, PA1_LT-$808D/2, PA2_LT-$808D/2, PA3_LT-$808D/2, PA4_LT-$808D/2, PA5_LT-$808D/2, PA6_LT-$808D/2, PA7_LT-$808D/2, PA8_LT-$808D/2, PA9_LT-$808D/2, PAA_LT-$808D/2, PAB_LT-$808D/2, PAC_LT-$808D/2, PAD_LT-$808D/2, PAE_LT-$808D/2, PAF_LT-$808D/2
DW PB0_LT-$808D/2, PB1_LT-$808D/2, PB2_LT-$808D/2, PB3_LT-$808D/2, PB4_LT-$808D/2, PB5_LT-$808D/2, PB6_LT-$808D/2, PB7_LT-$808D/2, PB8_LT-$808D/2, PB9_LT-$808D/2, PBA_LT-$808D/2, PBB_LT-$808D/2, PBC_LT-$808D/2, PBD_LT-$808D/2, PBE_LT-$808D/2, PBF_LT-$808D/2
DW PC0_LT-$808D/2, PC1_LT-$808D/2, PC2_LT-$808D/2, PC3_LT-$808D/2, PC4_LT-$808D/2, PC5_LT-$808D/2, PC6_LT-$808D/2, PC7_LT-$808D/2, PC8_LT-$808D/2, PC9_LT-$808D/2, PCA_LT-$808D/2, PCB_LT-$808D/2, PCC_LT-$808D/2, PCD_LT-$808D/2, PCE_LT-$808D/2, PCF_LT-$808D/2
DW PD0_LT-$808D/2, PD1_LT-$808D/2, PD2_LT-$808D/2, PD3_LT-$808D/2, PD4_LT-$808D/2, PD5_LT-$808D/2, PD6_LT-$808D/2, PD7_LT-$808D/2, PD8_LT-$808D/2, PD9_LT-$808D/2, PDA_LT-$808D/2, PDB_LT-$808D/2, PDC_LT-$808D/2, PDD_LT-$808D/2, PDE_LT-$808D/2, PDF_LT-$808D/2
DW PE0_LT-$808D/2, PE1_LT-$808D/2, PE2_LT-$808D/2, PE3_LT-$808D/2, PE4_LT-$808D/2, PE5_LT-$808D/2, PE6_LT-$808D/2, PE7_LT-$808D/2, PE8_LT-$808D/2, PE9_LT-$808D/2, PEA_LT-$808D/2, PEB_LT-$808D/2, PEC_LT-$808D/2, PED_LT-$808D/2, PEE_LT-$808D/2, PEF_LT-$808D/2
DW PF0_LT-$808D/2, PF1_LT-$808D/2, PF2_LT-$808D/2, PF3_LT-$808D/2, PF4_LT-$808D/2, PF5_LT-$808D/2, PF6_LT-$808D/2, PF7_LT-$808D/2, PF8_LT-$808D/2, PF9_LT-$808D/2, PFA_LT-$808D/2, PFB_LT-$808D/2, PFC_LT-$808D/2
;ends @ $929656

;TILEMAPS!!!!!!!!!!
;9657
TM_006:
DW $0002  
DB $FB, $C3, $F8, $00, $28 
DB $FB, $C3, $F0, $02, $28 

;9663
TM_007:
DW $0002  
DB $FB, $C3, $F7, $00, $28 
DB $FB, $C3, $EF, $02, $28 

;966f
TM_008:
DW $0003  
DB $FF, $C3, $F7, $00, $28 
DB $07, $00, $EF, $04, $28 
DB $F7, $C3, $EF, $02, $28 

;9680
TM_009:
DW $0003  
DB $08, $00, $EE, $04, $28 
DB $00, $C2, $F6, $00, $28 
DB $F8, $C3, $EE, $02, $28 

;9691
TM_00A:
DW $0002  
DB $F9, $C3, $F7, $00, $28 
DB $F9, $C3, $EF, $02, $28 

;969d
TM_00B:
DW $0003  
DB $FE, $C3, $EF, $00, $28 
DB $F6, $C3, $F7, $02, $28 
DB $F6, $C3, $EF, $04, $28 

;96ae
TM_00C:
DW $0002  
DB $F5, $C3, $F8, $00, $28 
DB $F5, $C3, $F0, $02, $28 

;96ba
TM_00D:
DW $0002  
DB $F5, $C3, $F7, $00, $28 
DB $F5, $C3, $EF, $02, $28 

;96c6
TM_00E:
DW $0003  
DB $F1, $C3, $F7, $00, $28 
DB $F9, $C3, $EF, $02, $28 
DB $F1, $C3, $EF, $04, $28 

;96d7
TM_00F:
DW $0003  
DB $F0, $C3, $F6, $00, $28 
DB $F0, $C3, $EE, $02, $28 
DB $F8, $C3, $EE, $04, $28 

;96e8
TM_010:
DW $0002  
DB $F7, $C3, $F7, $00, $28 
DB $F7, $C3, $EF, $02, $28 

;96f4
TM_011:
DW $0003  
DB $FA, $C3, $F7, $00, $28 
DB $02, $00, $EF, $04, $28 
DB $F2, $C3, $EF, $02, $28 

;9705
TM_012:
DW $0006  
DB $FD, $01, $FB, $02, $28 
DB $05, $00, $F3, $03, $28 
DB $FD, $01, $F3, $04, $28 
DB $0B, $00, $01, $05, $28 
DB $07, $00, $FD, $06, $28 
DB $FA, $C3, $F0, $00, $28 

;9725
TM_013:
DW $0006  
DB $ED, $01, $01, $02, $68 
DB $F1, $01, $FD, $03, $68 
DB $FC, $01, $FB, $04, $28 
DB $F4, $01, $F3, $05, $28 
DB $FC, $01, $F3, $06, $28 
DB $F6, $C3, $F0, $00, $28 

;9745
TM_014:
DW $0005  
DB $06, $00, $01, $04, $28 
DB $FE, $C3, $F1, $00, $28 
DB $F6, $C3, $F1, $02, $28 
DB $0D, $00, $03, $05, $28 
DB $09, $00, $FF, $06, $28 

;9760
TM_015:
DW $0005  
DB $EF, $01, $FF, $04, $68 
DB $F0, $01, $01, $05, $28 
DB $F0, $C3, $F1, $00, $28 
DB $EB, $01, $03, $06, $68 
DB $F8, $C3, $F1, $02, $28 

;977b
TM_016:
DW $0005  
DB $01, $00, $00, $02, $28 
DB $F9, $01, $00, $03, $28 
DB $F9, $C3, $F0, $00, $28 
DB $0A, $00, $FD, $04, $28 
DB $02, $00, $FD, $05, $28 

;9796
TM_017:
DW $0005  
DB $FF, $01, $00, $02, $28 
DB $F7, $01, $00, $03, $28 
DB $F7, $C3, $F0, $00, $28 
DB $EE, $01, $FD, $04, $68 
DB $F6, $01, $FD, $05, $68 

;97b1
TM_018:
DW $0004  
DB $0A, $00, $EE, $04, $68 
DB $FF, $C3, $F1, $00, $28 
DB $0E, $00, $EA, $05, $68 
DB $F7, $C3, $F1, $02, $28 

;97c7
TM_019:
DW $0004  
DB $EA, $01, $E9, $04, $28 
DB $F1, $C3, $F1, $00, $28 
DB $EE, $01, $ED, $05, $28 
DB $F9, $C3, $F1, $02, $28 

;97dd
TM_01A:
DW $0003  
DB $FF, $C3, $F8, $00, $28 
DB $07, $00, $F0, $04, $28 
DB $F7, $C3, $F0, $02, $28 

;97ee
TM_01B:
DW $0003  
DB $F1, $C3, $F8, $00, $28 
DB $F9, $C3, $F0, $02, $28 
DB $F1, $C3, $F0, $04, $28 

;97ff
TM_01C:
DW $0005  
DB $F9, $01, $F9, $02, $28 
DB $F9, $01, $F1, $03, $28 
DB $FE, $01, $E1, $04, $28 
DB $FE, $01, $E9, $05, $28 
DB $F9, $C3, $F1, $00, $28 

;981a
TM_01D:
DW $0005  
DB $FF, $01, $F9, $02, $28 
DB $FF, $01, $F1, $03, $28 
DB $FA, $01, $E1, $04, $68 
DB $F7, $C3, $F1, $00, $28 
DB $FA, $01, $E9, $05, $68 

;9835
TM_01E:
DW $0003  
DB $FF, $C3, $EE, $00, $28 
DB $F7, $01, $FE, $04, $28 
DB $F7, $C3, $EE, $02, $28 

;9846
TM_01F:
DW $0003  
DB $F1, $C3, $EE, $00, $28 
DB $01, $00, $FE, $04, $28 
DB $F9, $C3, $EE, $02, $28 

;9857
TM_020:
DW $0005  
DB $0C, $00, $EA, $02, $68 
DB $FD, $01, $F8, $03, $28 
DB $FD, $01, $F0, $04, $28 
DB $08, $00, $EE, $05, $68 
DB $FB, $C3, $F0, $00, $28 

;9872
TM_021:
DW $0006  
DB $FB, $01, $FB, $02, $28 
DB $FB, $01, $F3, $03, $28 
DB $F3, $01, $F3, $04, $28 
DB $EC, $01, $EA, $05, $28 
DB $F0, $01, $EE, $06, $28 
DB $F5, $C3, $F0, $00, $28 

;9892
TM_022:
DW $0005  
DB $F7, $01, $F1, $06, $68 
DB $F3, $01, $F5, $07, $68 
DB $F3, $C3, $F0, $00, $28 
DB $FB, $C3, $E8, $02, $28 
DB $FB, $C3, $F0, $04, $28 

;98ad
TM_023:
DW $0005  
DB $04, $00, $F4, $06, $68 
DB $00, $00, $F8, $07, $68 
DB $F5, $C3, $E8, $00, $68 
DB $FD, $C3, $F0, $02, $68 
DB $F5, $C3, $F0, $04, $68 

;98c8		;unused?
DW $0007  
DB $F5, $01, $F3, $02, $28 
DB $FD, $01, $F3, $03, $28 
DB $E7, $01, $FB, $04, $68 
DB $F6, $C3, $F0, $00, $28 
DB $EF, $01, $FB, $05, $68 
DB $FE, $01, $00, $06, $28 
DB $F6, $01, $00, $07, $28 

;98ed		;unused?
DW $0007  
DB $FD, $01, $FB, $02, $28 
DB $04, $00, $F3, $03, $28 
DB $FC, $01, $F3, $04, $28 
DB $11, $00, $FB, $05, $28 
DB $02, $00, $00, $06, $28 
DB $FA, $C3, $F0, $00, $28 
DB $09, $00, $FB, $07, $28 

;9912
TM_024:
DW $0004  
DB $F9, $C3, $F8, $00, $28 
DB $F9, $C3, $F0, $02, $28 
DB $0A, $00, $FE, $04, $28 
DB $02, $00, $FE, $05, $28 

;9928
TM_025:
DW $0004  
DB $F7, $C3, $F8, $00, $28 
DB $F7, $C3, $F0, $02, $28 
DB $EE, $01, $FE, $04, $68 
DB $F6, $01, $FE, $05, $68 

;993e
TM_026:
DW $0004  
DB $F4, $01, $E8, $06, $28 
DB $FC, $C3, $E8, $00, $28 
DB $FC, $C3, $F0, $02, $28 
DB $F4, $C3, $F0, $04, $28 

;9954
TM_027:
DW $0005  
DB $F4, $01, $00, $06, $28 
DB $04, $00, $F8, $07, $28 
DB $FC, $C3, $E8, $00, $28 
DB $F4, $C3, $E8, $02, $28 
DB $F4, $C3, $F0, $04, $28 

;996f
TM_028:
DW $0001  
DB $F8, $01, $F8, $00, $2C 

;9976
TM_029:
DW $0002  
DB $FF, $C3, $F0, $00, $68 
DB $F0, $C3, $F0, $00, $28 

;9982
TM_02A:
DW $0004  
DB $04, $00, $E8, $04, $28 
DB $FC, $01, $E8, $05, $28 
DB $FC, $C3, $F0, $00, $28 
DB $F4, $C3, $F0, $02, $28 

;9998
TM_02B:
DW $0004  
DB $F5, $01, $E8, $04, $68 
DB $FD, $01, $E8, $05, $68 
DB $F2, $C3, $F0, $00, $28 
DB $FA, $C3, $F0, $02, $28 

;99ae
TM_02C:
DW $0006  
DB $F3, $01, $E8, $02, $28 
DB $03, $00, $E8, $03, $28 
DB $FB, $01, $E8, $04, $28 
DB $03, $00, $F8, $05, $28 
DB $03, $00, $F0, $06, $28 
DB $F3, $C3, $F0, $00, $28 

;99ce
TM_02D:
DW $0005  
DB $04, $00, $E8, $02, $28 
DB $FC, $01, $E8, $03, $28 
DB $F4, $01, $F8, $04, $28 
DB $F4, $01, $F0, $05, $28 
DB $FC, $C3, $F0, $00, $28 

;99e9
TM_02E:
DW $0004  
DB $04, $00, $E8, $06, $28 
DB $F4, $C3, $E8, $00, $28 
DB $F4, $C3, $F0, $02, $28 
DB $FC, $C3, $F0, $04, $28 

;99ff
TM_02F:
DW $0006  
DB $E2, $01, $F4, $04, $68 
DB $EA, $01, $F4, $05, $68 
DB $EC, $C3, $F0, $00, $28 
DB $04, $00, $08, $06, $28 
DB $04, $00, $00, $07, $28 
DB $FC, $C3, $F0, $02, $28 

;9a1f
TM_030:
DW $0006  
DB $15, $00, $F4, $04, $28 
DB $0D, $00, $F4, $05, $28 
DB $F4, $01, $08, $06, $28 
DB $F4, $01, $00, $07, $28 
DB $04, $C2, $F0, $00, $28 
DB $F4, $C3, $F0, $02, $28 

;9a3f
TM_031:
DW $0002  
DB $FA, $C3, $F8, $00, $28 
DB $FA, $C3, $F0, $02, $28 

;9a4b
TM_032:
DW $0002  
DB $F8, $C3, $F8, $00, $28 
DB $F8, $C3, $F0, $02, $28 

;9a57
TM_033:
DW $0002  
DB $F6, $C3, $F8, $00, $28 
DB $F6, $C3, $F0, $02, $28 

;9a63
TM_034:
DW $0002  
DB $F8, $C3, $F8, $00, $28 
DB $F8, $C3, $F0, $02, $28 

;9a6f
TM_035:
DW $0002  
DB $FC, $C3, $F0, $00, $28 
DB $F4, $C3, $F0, $02, $28 

;9a7b
TM_036:
DW $0002  
DB $FC, $C3, $F0, $00, $28 
DB $04, $C2, $F0, $02, $28 

;9a87
TM_037:
DW $0002  
DB $F4, $C3, $F0, $00, $68 
DB $EC, $C3, $F0, $02, $68 

;9a93	
TM_038:
DW $0005  
DB $ED, $01, $F8, $06, $68 
DB $F1, $01, $F4, $07, $68 
DB $00, $C2, $F8, $00, $68 
DB $F0, $C3, $F0, $02, $68 
DB $00, $C2, $F0, $04, $68 

;9aae	
TM_039:
DW $0005  
DB $F6, $01, $FC, $06, $68 
DB $F2, $01, $00, $07, $68 
DB $F0, $C3, $F8, $00, $28 
DB $00, $C2, $F0, $02, $28 
DB $F0, $C3, $F0, $04, $28 

;9ac9		;unused?
DW $0001  
DB $F8, $01, $F8, $00, $38 

;9ad0		;unused?
DW $0001  
DB $F8, $01, $F8, $00, $38 

;9ad7	
TM_03A:
DW $0006  
DB $F8, $01, $00, $02, $28 
DB $04, $00, $E8, $03, $28 
DB $FC, $01, $E8, $04, $28 
DB $04, $00, $F8, $05, $28 
DB $04, $00, $F0, $06, $28 
DB $F4, $C3, $F0, $00, $28 

;9af7	
TM_03B:
DW $0006  
DB $F7, $01, $00, $02, $28 
DB $F6, $01, $E8, $03, $68 
DB $FE, $01, $E8, $04, $68 
DB $F3, $01, $F8, $05, $28 
DB $F3, $01, $F0, $06, $28 
DB $FB, $C3, $F0, $00, $28 

;9b17	
TM_03C:
DW $0004  
DB $FF, $01, $05, $04, $E8 
DB $FF, $01, $0D, $05, $E8 
DB $F8, $C3, $F0, $00, $28 
DB $F8, $C3, $F8, $02, $28 

;9b2d	
TM_03D:
DW $0004  
DB $F8, $01, $05, $04, $A8 
DB $F8, $01, $0D, $05, $A8 
DB $F8, $C3, $F0, $00, $28 
DB $F8, $C3, $F8, $02, $28 

;9b43	
TM_03E:
DW $0004  
DB $F4, $C3, $F0, $00, $28 
DB $0C, $00, $08, $04, $28 
DB $0C, $00, $00, $05, $28 
DB $04, $C2, $F0, $02, $28 

;9b59	
TM_03F:
DW $0004  
DB $FC, $C3, $F0, $00, $28 
DB $EC, $01, $08, $04, $28 
DB $EC, $01, $00, $05, $28 
DB $EC, $C3, $F0, $02, $28 

;9b6f	
TM_040:
DW $0003  
DB $01, $00, $FE, $02, $28 
DB $F9, $01, $FE, $03, $28 
DB $F7, $C3, $F0, $00, $28 

;9b80	
TM_041:
DW $0002  
DB $F9, $C3, $F8, $00, $28 
DB $F9, $C3, $F0, $02, $28 

;9b8c		;unused?
DW $0004  
DB $FE, $01, $03, $04, $28 
DB $FA, $01, $FF, $05, $28 
DB $F7, $C3, $F8, $00, $28 
DB $F7, $C3, $F0, $02, $28 

;9ba2	
TM_042:
DW $0002  
DB $F9, $C3, $F8, $00, $28 
DB $F9, $C3, $F0, $02, $28 

;9bae	
TM_043:
DW $0003  
DB $FB, $01, $00, $02, $28 
DB $F7, $01, $FC, $03, $28 
DB $F7, $C3, $F0, $00, $28 

;9bbf	
TM_044:
DW $0002  
DB $F9, $C3, $F8, $00, $28 
DB $F9, $C3, $F0, $02, $28 

;9bcb	
TM_045:
DW $0006  
DB $FD, $01, $F9, $02, $28 
DB $05, $00, $F1, $03, $28 
DB $FD, $01, $F1, $04, $28 
DB $0B, $00, $00, $05, $28 
DB $07, $00, $FC, $06, $28 
DB $FA, $C3, $EF, $00, $28 

;9beb	
TM_046:
DW $0006  
DB $F1, $01, $FC, $02, $68 
DB $ED, $01, $00, $03, $68 
DB $FC, $01, $F9, $04, $28 
DB $F4, $01, $F1, $05, $28 
DB $FC, $01, $F1, $06, $28 
DB $F6, $C3, $EF, $00, $28 

;9c0b	
TM_047:
DW $0005  
DB $F9, $01, $F0, $02, $68 
DB $01, $00, $F0, $03, $68 
DB $F9, $C3, $F8, $00, $28 
DB $0A, $00, $FD, $04, $28 
DB $02, $00, $FD, $05, $28 

;9c26	
TM_048:
DW $0005  
DB $F9, $01, $F0, $02, $68 
DB $01, $00, $F0, $03, $68 
DB $F9, $C3, $F8, $00, $28 
DB $0A, $00, $FD, $04, $28 
DB $02, $00, $FD, $05, $28 

;9c41	
TM_049:
DW $0005  
DB $F9, $01, $F0, $02, $68 
DB $01, $00, $F0, $03, $68 
DB $F9, $C3, $F8, $00, $28 
DB $0A, $00, $FD, $04, $28 
DB $02, $00, $FD, $05, $28 

;9c5c	
TM_04A:
DW $0005  
DB $F9, $01, $F0, $02, $68 
DB $01, $00, $F0, $03, $68 
DB $F9, $C3, $F8, $00, $28 
DB $0A, $00, $FD, $04, $28 
DB $02, $00, $FD, $05, $28 

;9c77	
TM_04B:
DW $0005  
DB $F7, $01, $F0, $02, $28 
DB $FF, $01, $F0, $03, $28 
DB $F7, $C3, $F8, $00, $28 
DB $EE, $01, $FD, $04, $68 
DB $F6, $01, $FD, $05, $68 

;9c92	
TM_04C:
DW $0005  
DB $F7, $01, $F0, $02, $28 
DB $FF, $01, $F0, $03, $28 
DB $F7, $C3, $F8, $00, $28 
DB $EE, $01, $FD, $04, $68 
DB $F6, $01, $FD, $05, $68 

;9cad	
TM_04D:
DW $0005  
DB $FF, $01, $F0, $02, $28 
DB $F7, $01, $F0, $03, $28 
DB $F7, $C3, $F8, $00, $28 
DB $EE, $01, $FD, $04, $68 
DB $F6, $01, $FD, $05, $68 

;9cc8	
TM_04E:
DW $0005  
DB $FF, $01, $F0, $02, $28 
DB $F7, $01, $F0, $03, $28 
DB $F7, $C3, $F8, $00, $28 
DB $EE, $01, $FD, $04, $68 
DB $F6, $01, $FD, $05, $68 

;9ce3	
TM_04F:
DW $0005  
DB $0C, $00, $E9, $02, $68 
DB $FD, $01, $F6, $03, $28 
DB $FD, $01, $EE, $04, $28 
DB $08, $00, $ED, $05, $68 
DB $FB, $C3, $EF, $00, $28 

;9cfe	
TM_050:
DW $0006  
DB $FB, $01, $F9, $02, $28 
DB $FB, $01, $F1, $03, $28 
DB $F3, $01, $F1, $04, $28 
DB $EC, $01, $E9, $05, $28 
DB $F0, $01, $ED, $06, $28 
DB $F5, $C3, $EF, $00, $28 

;9d1e		;unused?
DW $0007  
DB $F5, $01, $F1, $02, $28 
DB $FD, $01, $F1, $03, $28 
DB $E7, $01, $FA, $04, $68 
DB $F6, $C3, $EF, $00, $28 
DB $EF, $01, $FA, $05, $68 
DB $FE, $01, $FF, $06, $28 
DB $F6, $01, $FF, $07, $28 

;9d43		;unused?
DW $0007  
DB $FC, $01, $F9, $02, $28 
DB $04, $00, $F1, $03, $28 
DB $FC, $01, $F1, $04, $28 
DB $11, $00, $FA, $05, $28 
DB $02, $00, $FF, $06, $28 
DB $FA, $C3, $EF, $00, $28 
DB $09, $00, $FA, $07, $28 

;9d68		;unused?
DW $0007  
DB $F5, $01, $F1, $02, $28 
DB $FD, $01, $F1, $03, $28 
DB $E7, $01, $F9, $04, $68 
DB $F6, $C3, $EE, $00, $28 
DB $EF, $01, $F9, $05, $68 
DB $FE, $01, $FE, $06, $28 
DB $F6, $01, $FE, $07, $28 

;9d8d		;unused?
DW $0007  
DB $FC, $01, $F9, $02, $28 
DB $04, $00, $F1, $03, $28 
DB $FC, $01, $F1, $04, $28 
DB $11, $00, $F9, $05, $28 
DB $02, $00, $FE, $06, $28 
DB $FA, $C3, $EE, $00, $28 
DB $09, $00, $F9, $07, $28 

;9db2	
TM_051:
DW $0005  
DB $0C, $00, $E8, $02, $68 
DB $FD, $01, $F6, $03, $28 
DB $FD, $01, $EE, $04, $28 
DB $08, $00, $EC, $05, $68 
DB $FB, $C3, $EE, $00, $28 

;9dcd	
TM_052:
DW $0006  
DB $FB, $01, $F9, $02, $28 
DB $FB, $01, $F1, $03, $28 
DB $F3, $01, $F1, $04, $28 
DB $EC, $01, $E8, $05, $28 
DB $F0, $01, $EC, $06, $28 
DB $F5, $C3, $EE, $00, $28 

;9ded	
TM_053:
DW $0006  
DB $FD, $01, $F9, $02, $28 
DB $05, $00, $F1, $03, $28 
DB $FD, $01, $F1, $04, $28 
DB $0B, $00, $FF, $05, $28 
DB $07, $00, $FB, $06, $28 
DB $FA, $C3, $EE, $00, $28 

;9e0d	
TM_054:
DW $0006  
DB $F1, $01, $FB, $02, $68 
DB $FC, $01, $F9, $03, $28 
DB $F4, $01, $F1, $04, $28 
DB $FC, $01, $F1, $05, $28 
DB $ED, $01, $FF, $06, $68 
DB $F6, $C3, $EE, $00, $28 

;9e2d	
TM_055:
DW $0005  
DB $01, $00, $FF, $02, $28 
DB $F9, $01, $FF, $03, $28 
DB $F9, $C3, $EF, $00, $28 
DB $0A, $00, $FC, $04, $28 
DB $02, $00, $FC, $05, $28 

;9e48	
TM_056:
DW $0005  
DB $FF, $01, $FF, $02, $28 
DB $F7, $01, $FF, $03, $28 
DB $F7, $C3, $EF, $00, $28 
DB $EE, $01, $FC, $04, $68 
DB $F6, $01, $FC, $05, $68 

;9e63	
TM_057:
DW $0006  
DB $05, $00, $F7, $02, $28 
DB $FD, $01, $F7, $03, $28 
DB $F9, $01, $F5, $04, $28 
DB $F9, $01, $F7, $05, $68 
DB $F9, $01, $EF, $06, $68 
DB $FA, $C3, $F0, $00, $68 

;9e83	
TM_058:
DW $0005  
DB $05, $00, $EF, $02, $28 
DB $FD, $01, $EF, $03, $28 
DB $F9, $01, $F6, $04, $68 
DB $F9, $01, $EE, $05, $68 
DB $FA, $C3, $F0, $00, $68 

;9e9e	
TM_059:
DW $0005  
DB $FD, $01, $F6, $02, $28 
DB $F5, $01, $F6, $03, $28 
DB $FE, $01, $F7, $04, $28 
DB $FE, $01, $EF, $05, $28 
DB $F6, $C3, $F0, $00, $28 

;9eb9	
TM_05A:
DW $0005  
DB $F9, $01, $F0, $02, $28 
DB $F1, $01, $F0, $03, $28 
DB $FE, $01, $F6, $04, $28 
DB $FE, $01, $EE, $05, $28 
DB $F6, $C3, $F0, $00, $28 

;9ed4	
TM_05B:
DW $0006  
DB $FE, $01, $F4, $02, $28 
DB $F6, $01, $F4, $03, $28 
DB $F2, $01, $02, $04, $28 
DB $FA, $01, $02, $05, $28 
DB $FA, $01, $FA, $06, $28 
DB $F6, $C3, $F2, $00, $28 

;9ef4	
TM_05C:
DW $0006  
DB $FD, $01, $F5, $02, $28 
DB $F5, $01, $F5, $03, $28 
DB $F3, $01, $03, $04, $28 
DB $FB, $01, $03, $05, $28 
DB $FB, $01, $FB, $06, $28 
DB $F6, $C3, $F3, $00, $28 

;9f14	
TM_05D:
DW $0006  
DB $FC, $01, $F6, $02, $28 
DB $F4, $01, $F6, $03, $28 
DB $F4, $01, $04, $04, $28 
DB $FC, $01, $04, $05, $28 
DB $FC, $01, $FC, $06, $28 
DB $F6, $C3, $F4, $00, $28 

;9f34	
TM_05E:
DW $0007  
DB $00, $00, $00, $02, $28 
DB $04, $00, $04, $03, $28 
DB $FE, $01, $02, $04, $68 
DB $FA, $01, $F4, $05, $68 
DB $02, $00, $F4, $06, $68 
DB $FE, $01, $FA, $07, $68 
DB $FA, $C3, $F2, $00, $68 

;9f59	
TM_05F:
DW $0007  
DB $FF, $01, $01, $02, $28 
DB $03, $00, $05, $03, $28 
DB $FB, $01, $F5, $04, $68 
DB $03, $00, $F5, $05, $68 
DB $FD, $01, $03, $06, $68 
DB $FD, $01, $FB, $07, $68 
DB $FA, $C3, $F3, $00, $68 

;9f7e	
TM_060:
DW $0007  
DB $FE, $01, $02, $02, $28 
DB $02, $00, $06, $03, $28 
DB $FC, $01, $F6, $04, $68 
DB $04, $00, $F6, $05, $68 
DB $FC, $01, $04, $06, $68 
DB $FC, $01, $FC, $07, $68 
DB $FA, $C3, $F4, $00, $68 

;9fa3	
TM_061:
DW $0006  
DB $FE, $01, $F4, $02, $28 
DB $F6, $01, $F4, $03, $28 
DB $F2, $01, $02, $04, $28 
DB $FA, $01, $02, $05, $28 
DB $FA, $01, $FA, $06, $28 
DB $F6, $C3, $F2, $00, $28 

;9fc3	
TM_062:
DW $0006  
DB $FD, $01, $F5, $02, $28 
DB $F5, $01, $F5, $03, $28 
DB $F3, $01, $03, $04, $28 
DB $FB, $01, $03, $05, $28 
DB $FB, $01, $FB, $06, $28 
DB $F6, $C3, $F3, $00, $28 

;9fe3	
TM_063:
DW $0006  
DB $FC, $01, $F6, $02, $28 
DB $F4, $01, $F6, $03, $28 
DB $F4, $01, $04, $04, $28 
DB $FC, $01, $04, $05, $28 
DB $FC, $01, $FC, $06, $28 
DB $F6, $C3, $F4, $00, $28 

;a003	
TM_064:
DW $0007  
DB $00, $00, $00, $02, $28 
DB $04, $00, $04, $03, $28 
DB $FA, $01, $F4, $04, $68 
DB $02, $00, $F4, $05, $68 
DB $FE, $01, $02, $06, $68 
DB $FE, $01, $FA, $07, $68 
DB $FA, $C3, $F2, $00, $68 

;a028	
TM_065:
DW $0007  
DB $FF, $01, $01, $02, $28 
DB $03, $00, $05, $03, $28 
DB $FB, $01, $F5, $04, $68 
DB $03, $00, $F5, $05, $68 
DB $FD, $01, $03, $06, $68 
DB $FD, $01, $FB, $07, $68 
DB $FA, $C3, $F3, $00, $68 

;a04d	
TM_066:
DW $0007  
DB $FE, $01, $02, $02, $28 
DB $02, $00, $06, $03, $28 
DB $FC, $01, $F6, $04, $68 
DB $04, $00, $F6, $05, $68 
DB $FC, $01, $04, $06, $68 
DB $FC, $01, $FC, $07, $68 
DB $FA, $C3, $F4, $00, $68 

;a072	
TM_067:
DW $0004  
DB $F9, $C3, $F8, $00, $28 
DB $F9, $C3, $F0, $02, $28 
DB $0A, $00, $FD, $04, $28 
DB $02, $00, $FD, $05, $28 

;a088	
TM_068:
DW $0004  
DB $F9, $C3, $F8, $00, $28 
DB $F9, $C3, $F0, $02, $28 
DB $0A, $00, $FD, $04, $28 
DB $02, $00, $FD, $05, $28 

;a09e	
TM_069:
DW $0004  
DB $F9, $C3, $F8, $00, $28 
DB $F9, $C3, $F0, $02, $28 
DB $0A, $00, $FD, $04, $28 
DB $02, $00, $FD, $05, $28 

;a0b4	
TM_06A:
DW $0004  
DB $F7, $C3, $F8, $00, $28 
DB $F7, $C3, $F0, $02, $28 
DB $EE, $01, $FD, $04, $68 
DB $F6, $01, $FD, $05, $68 

;a0ca	
TM_06B:
DW $0004  
DB $F7, $C3, $F8, $00, $28 
DB $F7, $C3, $F0, $02, $28 
DB $EE, $01, $FD, $04, $68 
DB $F6, $01, $FD, $05, $68 

;a0e0	
TM_06C:
DW $0004  
DB $F7, $C3, $F8, $00, $28 
DB $F7, $C3, $F0, $02, $28 
DB $EE, $01, $FD, $04, $68 
DB $F6, $01, $FD, $05, $68 

;a0f6	
TM_06D:
DW $0005  
DB $01, $00, $00, $02, $28 
DB $F9, $01, $00, $03, $28 
DB $F9, $C3, $F0, $00, $28 
DB $0A, $00, $FD, $04, $28 
DB $02, $00, $FD, $05, $28 

;a111	
TM_06E:
DW $0005  
DB $FF, $01, $00, $02, $28 
DB $F7, $01, $00, $03, $28 
DB $F7, $C3, $F0, $00, $28 
DB $EE, $01, $FD, $04, $68 
DB $F6, $01, $FD, $05, $68 

;a12c	
TM_06F:
DW $0001  
DB $F8, $01, $F8, $00, $30 

;a133		;unused?
DW $0001  
DB $F8, $01, $F8, $00, $38 

;a13a	
TM_070:
DW $0009  
DB $04, $00, $10, $00, $38 
DB $04, $00, $08, $01, $38 
DB $FC, $01, $08, $02, $38 
DB $FC, $01, $00, $03, $38 
DB $FC, $01, $F8, $04, $38 
DB $04, $00, $F0, $05, $38 
DB $FC, $01, $F0, $06, $38 
DB $F4, $01, $F0, $07, $38 
DB $F4, $01, $E8, $10, $38 

;a169	
TM_071:
DW $0007  
DB $04, $00, $00, $00, $38 
DB $FC, $01, $00, $01, $38 
DB $F4, $01, $00, $02, $38 
DB $04, $00, $F8, $03, $38 
DB $FC, $01, $F8, $04, $38 
DB $F4, $01, $F8, $05, $38 
DB $F4, $01, $F0, $06, $38 

;a18e	
TM_072:
DW $000B  
DB $FC, $01, $10, $00, $38 
DB $F4, $01, $10, $01, $38 
DB $FC, $01, $08, $02, $38 
DB $F4, $01, $08, $03, $38 
DB $04, $00, $00, $04, $38 
DB $FC, $01, $00, $05, $38 
DB $04, $00, $F8, $06, $38 
DB $FC, $01, $F8, $07, $38 
DB $FC, $01, $F0, $10, $38 
DB $04, $00, $E8, $11, $38 
DB $FC, $01, $E8, $12, $38 

;a1c7	
TM_073:
DW $000F  
DB $FC, $01, $10, $00, $38 
DB $F4, $01, $10, $01, $38 
DB $FC, $01, $08, $02, $38 
DB $F4, $01, $08, $03, $38 
DB $04, $00, $00, $04, $38 
DB $FC, $01, $00, $05, $38 
DB $F4, $01, $00, $06, $38 
DB $04, $00, $F8, $07, $38 
DB $FC, $01, $F8, $10, $38 
DB $F4, $01, $F8, $11, $38 
DB $04, $00, $F0, $12, $38 
DB $FC, $01, $F0, $13, $38 
DB $F4, $01, $F0, $14, $38 
DB $04, $00, $E8, $15, $38 
DB $FC, $01, $E8, $16, $38 

;a214	
TM_074:
DW $0008  
DB $FC, $01, $10, $00, $38 
DB $FC, $01, $08, $01, $38 
DB $FC, $01, $00, $02, $38 
DB $04, $00, $F8, $03, $38 
DB $F4, $01, $F8, $04, $38 
DB $04, $00, $F0, $05, $38 
DB $F4, $01, $F0, $06, $38 
DB $04, $00, $E8, $07, $38 

;a23e	
TM_075:
DW $000A  
DB $FC, $01, $10, $00, $38 
DB $04, $00, $08, $01, $38 
DB $FC, $01, $08, $02, $38 
DB $04, $00, $00, $03, $38 
DB $FC, $01, $00, $04, $38 
DB $04, $00, $F0, $05, $38 
DB $FC, $01, $F0, $06, $38 
DB $F4, $01, $F0, $07, $38 
DB $04, $00, $E8, $10, $38 
DB $FC, $01, $E8, $11, $38 

;a272	
TM_076:
DW $000B  
DB $F4, $01, $10, $00, $38 
DB $04, $00, $08, $01, $38 
DB $FC, $01, $08, $02, $38 
DB $F4, $01, $08, $03, $38 
DB $04, $00, $00, $04, $38 
DB $FC, $01, $00, $05, $38 
DB $F4, $01, $00, $06, $38 
DB $F4, $01, $F0, $07, $38 
DB $04, $00, $E8, $10, $38 
DB $FC, $01, $E8, $11, $38 
DB $F4, $01, $E8, $12, $38 

;a2ab	
TM_077:
DW $0007  
DB $04, $00, $08, $00, $38 
DB $F4, $01, $08, $01, $38 
DB $F4, $01, $00, $02, $38 
DB $04, $00, $F8, $03, $38 
DB $04, $00, $E8, $04, $38 
DB $FC, $01, $E8, $05, $38 
DB $F4, $01, $E8, $06, $38 

;a2d0	
TM_078:
DW $0003  
DB $11, $00, $FA, $02, $28 
DB $09, $00, $FA, $03, $28 
DB $FA, $C3, $F0, $00, $28 

;a2e1	
TM_079:
DW $0003  
DB $11, $00, $F9, $02, $28 
DB $09, $00, $F9, $03, $28 
DB $FA, $C3, $EF, $00, $28 

;a2f2	
TM_07A:
DW $0004  
DB $11, $00, $F9, $02, $28 
DB $09, $00, $F9, $03, $28 
DB $07, $00, $F7, $04, $28 
DB $F7, $C3, $EF, $00, $28 

;a308	
TM_07B:
DW $0005  
DB $11, $00, $F8, $02, $28 
DB $09, $00, $F8, $03, $28 
DB $05, $00, $EE, $04, $28 
DB $05, $00, $F6, $05, $28 
DB $F5, $C3, $EE, $00, $28 

;a323	
TM_07C:
DW $0003  
DB $11, $00, $F9, $02, $28 
DB $09, $00, $F9, $03, $28 
DB $FA, $C3, $EF, $00, $28 

;a334	
TM_07D:
DW $0004  
DB $11, $00, $F9, $02, $28 
DB $09, $00, $F9, $03, $28 
DB $0A, $00, $F7, $04, $28 
DB $FA, $C3, $EF, $00, $28 

;a34a	
TM_07E:
DW $0005  
DB $EF, $01, $FA, $02, $68 
DB $E7, $01, $FA, $03, $68 
DB $FE, $01, $00, $04, $28 
DB $F6, $01, $00, $05, $28 
DB $F6, $C3, $F0, $00, $28 

;a365	
TM_07F:
DW $0005  
DB $EF, $01, $F9, $02, $68 
DB $E7, $01, $F9, $03, $68 
DB $FE, $01, $FF, $04, $28 
DB $F6, $01, $FF, $05, $28 
DB $F6, $C3, $EF, $00, $28 

;a380	
TM_080:
DW $0006  
DB $EE, $01, $F7, $02, $28 
DB $FE, $01, $FF, $03, $28 
DB $F6, $01, $FF, $04, $28 
DB $F6, $C3, $EF, $00, $28 
DB $EF, $01, $F9, $05, $68 
DB $E7, $01, $F9, $06, $68 

;a3a0	
TM_081:
DW $0006  
DB $EE, $01, $F6, $02, $28 
DB $EF, $01, $F8, $03, $68 
DB $E7, $01, $F8, $04, $68 
DB $FE, $01, $FE, $05, $28 
DB $F6, $01, $FE, $06, $28 
DB $F6, $C3, $EE, $00, $28 

;a3c0	
TM_082:
DW $0005  
DB $EF, $01, $F9, $02, $68 
DB $E7, $01, $F9, $03, $68 
DB $FE, $01, $FF, $04, $28 
DB $F6, $01, $FF, $05, $28 
DB $F6, $C3, $EF, $00, $28 

;a3db	
TM_083:
DW $0007  
DB $EF, $01, $F9, $02, $68 
DB $E7, $01, $F9, $03, $68 
DB $06, $00, $FF, $04, $28 
DB $FE, $01, $FF, $05, $28 
DB $F6, $01, $F7, $06, $28 
DB $F6, $01, $EF, $07, $28 
DB $FE, $C3, $EF, $00, $28 

;a400	
TM_084:
DW $0005  
DB $11, $00, $F8, $02, $28 
DB $09, $00, $F8, $03, $28 
DB $0A, $00, $F6, $04, $28 
DB $0A, $00, $EE, $05, $28 
DB $FA, $C3, $EE, $00, $28 

;a41b	
TM_085:
DW $0007  
DB $EF, $01, $F8, $02, $68 
DB $E7, $01, $F8, $03, $68 
DB $06, $00, $FE, $04, $28 
DB $FE, $01, $FE, $05, $28 
DB $F6, $01, $F6, $06, $28 
DB $F6, $01, $EE, $07, $28 
DB $FE, $C3, $EE, $00, $28 

;a440	
TM_086:
DW $0003  
DB $11, $00, $FA, $02, $28 
DB $09, $00, $FA, $03, $28 
DB $FA, $C3, $F0, $00, $28 

;a451	
TM_087:
DW $0005  
DB $EF, $01, $FA, $02, $68 
DB $E7, $01, $FA, $03, $68 
DB $FE, $01, $00, $04, $28 
DB $F6, $01, $00, $05, $28 
DB $F6, $C3, $F0, $00, $28 

;a46c	
TM_088:
DW $0004  
DB $1C, $00, $FD, $04, $28 
DB $14, $00, $FD, $05, $28 
DB $05, $C2, $F6, $00, $28 
DB $00, $C2, $F8, $02, $28 

;a482	
TM_089:
DW $0004  
DB $1B, $00, $F7, $04, $28 
DB $13, $00, $F7, $05, $28 
DB $04, $C2, $F4, $00, $28 
DB $FF, $C3, $F6, $02, $28 

;a498	
TM_08A:
DW $0003  
DB $10, $C2, $F1, $00, $28 
DB $04, $C2, $F3, $02, $28 
DB $FF, $C3, $F5, $04, $28 

;a4a9	
TM_08B:
DW $0003  
DB $02, $C2, $EF, $00, $28 
DB $0E, $C2, $ED, $02, $28 
DB $FF, $C3, $F2, $04, $28 

;a4ba	
TM_08C:
DW $0003  
DB $0C, $C2, $E5, $00, $28 
DB $02, $C2, $EF, $02, $28 
DB $FF, $C3, $F2, $04, $28 

;a4cb	
TM_08D:
DW $0003  
DB $09, $C2, $E5, $00, $28 
DB $01, $C2, $EF, $02, $28 
DB $FF, $C3, $F2, $04, $28 

;a4dc	
TM_08E:
DW $0003  
DB $07, $C2, $E3, $00, $28 
DB $01, $C2, $ED, $02, $28 
DB $FE, $C3, $F1, $04, $28 

;a4ed	
TM_08F:
DW $0004  
DB $04, $00, $E6, $04, $28 
DB $04, $00, $DE, $05, $28 
DB $FD, $C3, $EC, $00, $28 
DB $FB, $C3, $F0, $02, $28 

;a503	
TM_090:
DW $0004  
DB $FD, $01, $E5, $04, $28 
DB $FD, $01, $DD, $05, $28 
DB $F6, $C3, $EC, $00, $28 
DB $F8, $C3, $F0, $02, $28 

;a519	
TM_091:
DW $0004  
DB $F8, $01, $E6, $04, $68 
DB $F8, $01, $DE, $05, $68 
DB $F3, $C3, $EC, $00, $28 
DB $F7, $C3, $F0, $02, $28 

;a52f	
TM_092:
DW $0003  
DB $EE, $C3, $E2, $00, $68 
DB $F3, $C3, $ED, $02, $28 
DB $F5, $C3, $F1, $04, $28 

;a540	
TM_093:
DW $0003  
DB $E8, $C3, $E4, $00, $68 
DB $F0, $C3, $EF, $02, $28 
DB $F2, $C3, $F2, $04, $28 

;a551	
TM_094:
DW $0003  
DB $E3, $C3, $E5, $00, $68 
DB $EE, $C3, $EF, $02, $28 
DB $F2, $C3, $F2, $04, $28 

;a562	
TM_095:
DW $0003  
DB $E0, $C3, $E9, $00, $68 
DB $EB, $C3, $F2, $02, $28 
DB $F1, $C3, $F3, $04, $28 

;a573	
TM_096:
DW $0003  
DB $E0, $C3, $EF, $00, $68 
DB $EB, $C3, $F4, $02, $28 
DB $F1, $C3, $F3, $04, $28 

;a584	
TM_097:
DW $0004  
DB $DD, $01, $F7, $04, $68 
DB $E5, $01, $F7, $05, $68 
DB $EB, $C3, $F9, $00, $28 
DB $F0, $C3, $F7, $02, $28 

;a59a		;unused?
DW $0004  
DB $DC, $01, $FC, $04, $68 
DB $E4, $01, $FC, $05, $68 
DB $EB, $C3, $F9, $00, $28 
DB $F0, $C3, $F8, $02, $28 

;a5b0	
TM_098:
DW $0008  
DB $01, $00, $FB, $04, $28 
DB $01, $00, $F3, $05, $28 
DB $F1, $C3, $F3, $00, $28 
DB $F0, $C3, $F8, $02, $68 
DB $DC, $01, $FC, $06, $68 
DB $E4, $01, $FC, $07, $68 
DB $EB, $01, $02, $14, $28 
DB $EB, $01, $FA, $15, $28 

;a5da	
TM_099:
DW $0008  
DB $DC, $01, $F8, $04, $68 
DB $E4, $01, $F8, $05, $68 
DB $01, $00, $FA, $06, $28 
DB $01, $00, $F2, $07, $28 
DB $F1, $C3, $F2, $00, $28 
DB $F0, $C3, $F7, $02, $68 
DB $EB, $01, $00, $14, $28 
DB $EB, $01, $F8, $15, $28 

;a604	
TM_09A:
DW $000A  
DB $05, $00, $FA, $04, $28 
DB $05, $00, $F2, $05, $28 
DB $F5, $C3, $F2, $00, $28 
DB $F1, $C3, $F5, $02, $68 
DB $E0, $01, $F8, $06, $68 
DB $E8, $01, $F8, $07, $68 
DB $E0, $01, $F0, $14, $68 
DB $E8, $01, $F0, $15, $68 
DB $EB, $01, $FD, $16, $28 
DB $EB, $01, $F5, $17, $28 

;a638	
TM_09B:
DW $000A  
DB $05, $00, $F9, $04, $28 
DB $05, $00, $F1, $05, $28 
DB $F5, $C3, $F1, $00, $28 
DB $F1, $C3, $F4, $02, $68 
DB $E0, $01, $F5, $06, $68 
DB $E8, $01, $F5, $07, $68 
DB $E0, $01, $ED, $14, $68 
DB $E8, $01, $ED, $15, $68 
DB $EB, $01, $FB, $16, $28 
DB $EB, $01, $F3, $17, $28 

;a66c	
TM_09C:
DW $0009  
DB $FD, $01, $FE, $04, $28 
DB $F5, $C3, $EE, $00, $28 
DB $F0, $C3, $F2, $02, $68 
DB $E2, $01, $EC, $05, $68 
DB $EA, $01, $EC, $06, $68 
DB $E2, $01, $E4, $07, $68 
DB $EA, $01, $E4, $14, $68 
DB $F4, $01, $EE, $15, $28 
DB $EC, $01, $EE, $16, $28 

;a69b	
TM_09D:
DW $0009  
DB $FE, $01, $FE, $04, $28 
DB $F6, $C3, $EE, $00, $28 
DB $F2, $C3, $F1, $02, $68 
DB $F6, $01, $ED, $05, $28 
DB $EE, $01, $ED, $06, $28 
DB $ED, $01, $EB, $07, $68 
DB $E5, $01, $EB, $14, $68 
DB $E5, $01, $E3, $15, $68 
DB $ED, $01, $E3, $16, $68 

;a6ca	
TM_09E:
DW $0009  
DB $E9, $01, $E9, $04, $68 
DB $FE, $01, $FE, $05, $28 
DB $F6, $C3, $EE, $00, $28 
DB $F2, $C3, $F1, $02, $68 
DB $F1, $01, $E9, $06, $68 
DB $E9, $01, $E1, $07, $68 
DB $F1, $01, $E1, $14, $68 
DB $F6, $01, $EC, $15, $28 
DB $EE, $01, $EC, $16, $28 

;a6f9	
TM_09F:
DW $0008  
DB $00, $00, $02, $04, $28 
DB $F8, $01, $02, $05, $28 
DB $F8, $C3, $F2, $00, $28 
DB $F6, $C3, $F0, $02, $68 
DB $F8, $01, $EB, $06, $28 
DB $F0, $01, $EB, $07, $28 
DB $F5, $01, $E5, $14, $68 
DB $F5, $01, $DD, $15, $68 

;a723	
TM_0A0:
DW $0008  
DB $FF, $01, $03, $04, $28 
DB $F7, $01, $03, $05, $28 
DB $F7, $C3, $F3, $00, $28 
DB $F9, $C3, $F1, $02, $68 
DB $FC, $01, $E4, $06, $28 
DB $FC, $01, $DC, $07, $28 
DB $FD, $01, $EB, $14, $28 
DB $F5, $01, $EB, $15, $28 

;a74d	
TM_0A1:
DW $0008  
DB $FF, $01, $01, $04, $28 
DB $F7, $01, $01, $05, $28 
DB $F7, $C3, $F1, $00, $28 
DB $FA, $C3, $F0, $02, $68 
DB $02, $00, $E5, $06, $28 
DB $02, $00, $DD, $07, $28 
DB $03, $00, $EB, $14, $28 
DB $FB, $01, $EB, $15, $28 

;a777	
TM_0A2:
DW $0009  
DB $0B, $00, $E8, $04, $28 
DB $F1, $01, $FC, $05, $28 
DB $F9, $C3, $F4, $00, $28 
DB $FB, $C3, $F0, $02, $68 
DB $03, $00, $E8, $06, $28 
DB $0B, $00, $E0, $07, $28 
DB $03, $00, $E0, $14, $28 
DB $05, $00, $EB, $15, $28 
DB $FD, $01, $EB, $16, $28 

;a7a6	
TM_0A3:
DW $000A  
DB $10, $00, $EA, $04, $28 
DB $08, $00, $EA, $05, $28 
DB $10, $00, $E2, $06, $28 
DB $08, $00, $E2, $07, $28 
DB $F1, $01, $FD, $14, $28 
DB $F1, $01, $F5, $15, $28 
DB $F9, $C3, $F5, $00, $28 
DB $FD, $C3, $F2, $02, $68 
DB $08, $00, $ED, $16, $28 
DB $00, $00, $ED, $17, $28 

;a7da	
TM_0A4:
DW $000A  
DB $F1, $01, $FD, $04, $28 
DB $F1, $01, $F5, $05, $28 
DB $F9, $C3, $F5, $00, $28 
DB $FD, $C3, $F2, $02, $68 
DB $13, $00, $EC, $06, $28 
DB $0B, $00, $EC, $07, $28 
DB $13, $00, $E4, $14, $28 
DB $0B, $00, $E4, $15, $28 
DB $09, $00, $EE, $16, $28 
DB $01, $00, $EE, $17, $28 

;a80e	
TM_0A5:
DW $000A  
DB $F4, $01, $FC, $04, $28 
DB $F4, $01, $F4, $05, $28 
DB $FC, $C3, $F4, $00, $28 
DB $FE, $C3, $F4, $02, $68 
DB $16, $00, $F3, $06, $28 
DB $0E, $00, $F3, $07, $28 
DB $16, $00, $EB, $14, $28 
DB $0E, $00, $EB, $15, $28 
DB $0A, $00, $F6, $16, $28 
DB $0A, $00, $EE, $17, $28 

;a842	
TM_0A6:
DW $000A  
DB $F4, $01, $FC, $04, $28 
DB $F4, $01, $F4, $05, $28 
DB $FC, $C3, $F4, $00, $28 
DB $FE, $C3, $F4, $02, $68 
DB $17, $00, $F7, $06, $28 
DB $0F, $00, $F7, $07, $28 
DB $17, $00, $EF, $14, $28 
DB $0F, $00, $EF, $15, $28 
DB $0B, $00, $F8, $16, $28 
DB $0B, $00, $F0, $17, $28 

;a876	
TM_0A7:
DW $0009  
DB $FE, $C3, $F3, $00, $28 
DB $F6, $01, $FB, $04, $28 
DB $F6, $01, $F3, $05, $28 
DB $F6, $01, $EB, $06, $28 
DB $FF, $C3, $F7, $02, $68 
DB $0E, $00, $FA, $07, $28 
DB $0E, $00, $F9, $14, $A8 
DB $1C, $00, $F7, $15, $28 
DB $14, $00, $F7, $16, $28 

;a895		;unused?
DW $0009  
DB $FE, $C3, $F4, $00, $28 
DB $F6, $01, $FC, $04, $28 
DB $F6, $01, $F4, $05, $28 
DB $F6, $01, $EC, $06, $28 
DB $FF, $C3, $F8, $02, $68 
DB $1C, $00, $FC, $07, $28 
DB $14, $00, $FC, $14, $28 
DB $0E, $00, $FD, $15, $28 
DB $0E, $00, $F5, $16, $28 

;a8d4	
TM_0A8:
DW $0004  
DB $DC, $01, $FB, $04, $E8 
DB $E4, $01, $FB, $05, $E8 
DB $EB, $C3, $FA, $00, $E8 
DB $F0, $C3, $F8, $02, $E8 

;a8ea	
TM_0A9:
DW $0004  
DB $DD, $01, $01, $04, $E8 
DB $E5, $01, $01, $05, $E8 
DB $EC, $C3, $FC, $00, $E8 
DB $F1, $C3, $FA, $02, $E8 

;a900	
TM_0AA:
DW $0003  
DB $E0, $C3, $FF, $00, $E8 
DB $EC, $C3, $FD, $02, $E8 
DB $F1, $C3, $FB, $04, $E8 

;a911	
TM_0AB:
DW $0003  
DB $EE, $C3, $01, $00, $E8 
DB $E2, $C3, $03, $02, $E8 
DB $F1, $C3, $FE, $04, $E8 

;a922	
TM_0AC:
DW $0003  
DB $E4, $C3, $0B, $00, $E8 
DB $EE, $C3, $01, $02, $E8 
DB $F1, $C3, $FE, $04, $E8 

;a933	
TM_0AD:
DW $0003  
DB $E7, $C3, $0B, $00, $E8 
DB $EF, $C3, $01, $02, $E8 
DB $F1, $C3, $FE, $04, $E8 

;a944	
TM_0AE:
DW $0003  
DB $E9, $C3, $0D, $00, $E8 
DB $EF, $C3, $03, $02, $E8 
DB $F2, $C3, $FF, $04, $E8 

;a955	
TM_0AF:
DW $0004  
DB $F4, $01, $12, $04, $E8 
DB $F4, $01, $1A, $05, $E8 
DB $F3, $C3, $04, $00, $E8 
DB $F5, $C3, $00, $02, $E8 

;a96b	
TM_0B0:
DW $0004  
DB $FB, $01, $13, $04, $E8 
DB $FB, $01, $1B, $05, $E8 
DB $FA, $C3, $04, $00, $E8 
DB $F8, $C3, $00, $02, $E8 

;a981	
TM_0B1:
DW $0004  
DB $00, $00, $12, $04, $A8 
DB $00, $00, $1A, $05, $A8 
DB $FD, $C3, $04, $00, $E8 
DB $F9, $C3, $00, $02, $E8 

;a997	
TM_0B2:
DW $0003  
DB $02, $C2, $0E, $00, $A8 
DB $FD, $C3, $03, $02, $E8 
DB $FB, $C3, $FF, $04, $E8 

;a9a8	
TM_0B3:
DW $0003  
DB $08, $C2, $0C, $00, $A8 
DB $00, $C2, $01, $02, $E8 
DB $FE, $C3, $FE, $04, $E8 

;a9b9	
TM_0B4:
DW $0003  
DB $0D, $C2, $0B, $00, $A8 
DB $02, $C2, $01, $02, $E8 
DB $FE, $C3, $FE, $04, $E8 

;a9ca	
TM_0B5:
DW $0003  
DB $10, $C2, $07, $00, $A8 
DB $05, $C2, $FE, $02, $E8 
DB $FF, $C3, $FD, $04, $E8 

;a9db	
TM_0B6:
DW $0003  
DB $10, $C2, $01, $00, $A8 
DB $05, $C2, $FC, $02, $E8 
DB $FF, $C3, $FD, $04, $E8 

;a9ec	
TM_0B7:
DW $0004  
DB $1B, $00, $01, $04, $A8 
DB $13, $00, $01, $05, $A8 
DB $05, $C2, $F7, $00, $E8 
DB $00, $C2, $F9, $02, $E8 

;aa02		;unused?
DW $0004  
DB $1C, $00, $FC, $04, $A8 
DB $14, $00, $FC, $05, $A8 
DB $05, $C2, $F7, $00, $E8 
DB $00, $C2, $F8, $02, $E8 

;aa18	
TM_0B8:
DW $0008  
DB $F7, $01, $FD, $04, $E8 
DB $F7, $01, $05, $05, $E8 
DB $FF, $C3, $FD, $00, $E8 
DB $00, $C2, $F8, $02, $A8 
DB $1C, $00, $FC, $06, $A8 
DB $14, $00, $FC, $07, $A8 
DB $0D, $00, $F6, $14, $E8 
DB $0D, $00, $FE, $15, $E8 

;aa42	
TM_0B9:
DW $0008  
DB $1C, $00, $00, $04, $A8 
DB $14, $00, $00, $05, $A8 
DB $F7, $01, $FE, $06, $E8 
DB $F7, $01, $06, $07, $E8 
DB $FF, $C3, $FE, $00, $E8 
DB $00, $C2, $F9, $02, $A8 
DB $0D, $00, $F8, $14, $E8 
DB $0D, $00, $00, $15, $E8 

;aa6c	
TM_0BA:
DW $000A  
DB $F3, $01, $FE, $04, $E8 
DB $F3, $01, $06, $05, $E8 
DB $FB, $C3, $FE, $00, $E8 
DB $FF, $C3, $FB, $02, $A8 
DB $18, $00, $00, $06, $A8 
DB $10, $00, $00, $07, $A8 
DB $18, $00, $08, $14, $A8 
DB $10, $00, $08, $15, $A8 
DB $0D, $00, $FB, $16, $E8 
DB $0D, $00, $03, $17, $E8 

;aaa0	
TM_0BB:
DW $000A  
DB $F3, $01, $FF, $04, $E8 
DB $F3, $01, $07, $05, $E8 
DB $FB, $C3, $FF, $00, $E8 
DB $FF, $C3, $FC, $02, $A8 
DB $18, $00, $03, $06, $A8 
DB $10, $00, $03, $07, $A8 
DB $18, $00, $0B, $14, $A8 
DB $10, $00, $0B, $15, $A8 
DB $0D, $00, $FD, $16, $E8 
DB $0D, $00, $05, $17, $E8 

;aad4	
TM_0BC:
DW $0009  
DB $FB, $01, $FA, $04, $E8 
DB $FB, $C3, $02, $00, $E8 
DB $00, $C2, $FE, $02, $A8 
DB $16, $00, $0C, $05, $A8 
DB $0E, $00, $0C, $06, $A8 
DB $16, $00, $14, $07, $A8 
DB $0E, $00, $14, $14, $A8 
DB $04, $00, $0A, $15, $E8 
DB $0C, $00, $0A, $16, $E8 

;ab03	
TM_0BD:
DW $0009  
DB $FA, $01, $FA, $04, $E8 
DB $FA, $C3, $02, $00, $E8 
DB $FE, $C3, $FF, $02, $A8 
DB $02, $00, $0B, $05, $E8 
DB $0A, $00, $0B, $06, $E8 
DB $0B, $00, $0D, $07, $A8 
DB $13, $00, $0D, $14, $A8 
DB $13, $00, $15, $15, $A8 
DB $0B, $00, $15, $16, $A8 

;ab32	
TM_0BE:
DW $0009  
DB $0F, $00, $0F, $04, $A8 
DB $FA, $01, $FA, $05, $E8 
DB $FA, $C3, $02, $00, $E8 
DB $FE, $C3, $FF, $02, $A8 
DB $07, $00, $0F, $06, $A8 
DB $0F, $00, $17, $07, $A8 
DB $07, $00, $17, $14, $A8 
DB $02, $00, $0C, $15, $E8 
DB $0A, $00, $0C, $16, $E8 

;ab61	
TM_0BF:
DW $0008  
DB $F8, $01, $F6, $04, $E8 
DB $00, $00, $F6, $05, $E8 
DB $F8, $C3, $FE, $00, $E8 
DB $FA, $C3, $00, $02, $A8 
DB $00, $00, $0D, $06, $E8 
DB $08, $00, $0D, $07, $E8 
DB $03, $00, $13, $14, $A8 
DB $03, $00, $1B, $15, $A8 

;ab8b	
TM_0C0:
DW $0008  
DB $F9, $01, $F5, $04, $E8 
DB $01, $00, $F5, $05, $E8 
DB $F9, $C3, $FD, $00, $E8 
DB $F7, $C3, $FF, $02, $A8 
DB $FC, $01, $14, $06, $E8 
DB $FC, $01, $1C, $07, $E8 
DB $FB, $01, $0D, $14, $E8 
DB $03, $00, $0D, $15, $E8 

;abb5	
TM_0C1:
DW $0008  
DB $F9, $01, $F7, $04, $E8 
DB $01, $00, $F7, $05, $E8 
DB $F9, $C3, $FF, $00, $E8 
DB $F6, $C3, $00, $02, $A8 
DB $F6, $01, $13, $06, $E8 
DB $F6, $01, $1B, $07, $E8 
DB $F5, $01, $0D, $14, $E8 
DB $FD, $01, $0D, $15, $E8 

;abdf	
TM_0C2:
DW $0009  
DB $ED, $01, $10, $04, $E8 
DB $07, $00, $FC, $05, $E8 
DB $F7, $C3, $FC, $00, $E8 
DB $F5, $C3, $00, $02, $A8 
DB $F5, $01, $10, $06, $E8 
DB $ED, $01, $18, $07, $E8 
DB $F5, $01, $18, $14, $E8 
DB $F3, $01, $0D, $15, $E8 
DB $FB, $01, $0D, $16, $E8 

;ac0e	
TM_0C3:
DW $000A  
DB $E8, $01, $0E, $04, $E8 
DB $F0, $01, $0E, $05, $E8 
DB $E8, $01, $16, $06, $E8 
DB $F0, $01, $16, $07, $E8 
DB $07, $00, $FB, $14, $E8 
DB $07, $00, $03, $15, $E8 
DB $F7, $C3, $FB, $00, $E8 
DB $F3, $C3, $FE, $02, $A8 
DB $F0, $01, $0B, $16, $E8 
DB $F8, $01, $0B, $17, $E8 

;ac42	
TM_0C4:
DW $000A  
DB $07, $00, $FB, $04, $E8 
DB $07, $00, $03, $05, $E8 
DB $F7, $C3, $FB, $00, $E8 
DB $F3, $C3, $FE, $02, $A8 
DB $E5, $01, $0C, $06, $E8 
DB $ED, $01, $0C, $07, $E8 
DB $E5, $01, $14, $14, $E8 
DB $ED, $01, $14, $15, $E8 
DB $EF, $01, $0A, $16, $E8 
DB $F7, $01, $0A, $17, $E8 

;ac76	
TM_0C5:
DW $000A  
DB $04, $00, $FC, $04, $E8 
DB $04, $00, $04, $05, $E8 
DB $F4, $C3, $FC, $00, $E8 
DB $F2, $C3, $FC, $02, $A8 
DB $E2, $01, $05, $06, $E8 
DB $EA, $01, $05, $07, $E8 
DB $E2, $01, $0D, $14, $E8 
DB $EA, $01, $0D, $15, $E8 
DB $EE, $01, $02, $16, $E8 
DB $EE, $01, $0A, $17, $E8 

;acaa	
TM_0C6:
DW $000A  
DB $04, $00, $FC, $04, $E8 
DB $04, $00, $04, $05, $E8 
DB $F4, $C3, $FC, $00, $E8 
DB $F2, $C3, $FC, $02, $A8 
DB $E1, $01, $01, $06, $E8 
DB $E9, $01, $01, $07, $E8 
DB $E1, $01, $09, $14, $E8 
DB $E9, $01, $09, $15, $E8 
DB $ED, $01, $00, $16, $E8 
DB $ED, $01, $08, $17, $E8 

;acde	
TM_0C7:
DW $0009  
DB $F2, $C3, $FD, $00, $E8 
DB $02, $00, $FD, $04, $E8 
DB $02, $00, $05, $05, $E8 
DB $02, $00, $0D, $06, $E8 
DB $F1, $C3, $F9, $02, $A8 
DB $EA, $01, $FE, $07, $E8 
DB $EA, $01, $FF, $14, $68 
DB $DC, $01, $01, $15, $E8 
DB $E4, $01, $01, $16, $E8 

;ad0d		;unused?
DW $0009  
DB $F2, $C3, $FC, $00, $E8 
DB $02, $00, $FC, $04, $E8 
DB $02, $00, $04, $05, $E8 
DB $02, $00, $0C, $06, $E8 
DB $F1, $C3, $F8, $02, $A8 
DB $DC, $01, $FC, $07, $E8 
DB $E4, $01, $FC, $14, $E8 
DB $EA, $01, $FB, $15, $E8 
DB $EA, $01, $03, $16, $E8 

;ad3c	
TM_0C8:
DW $0002  
DB $F8, $C3, $10, $08, $28 
DB $F8, $C3, $00, $0A, $28 

;ad48	
TM_0C9:
DW $0005  
DB $F3, $C3, $07, $08, $28 
DB $FB, $C3, $FF, $0A, $28 
DB $EB, $01, $0F, $0C, $28 
DB $F3, $01, $17, $0D, $28 
DB $03, $00, $0F, $0E, $28 

;ad63	
TM_0CA:
DW $0004  
DB $F0, $C3, $FF, $08, $28 
DB $00, $C2, $0F, $0A, $28 
DB $F8, $C3, $FF, $0C, $28 
DB $08, $00, $07, $0E, $28 

;ad79	
TM_0CB:
DW $0002  
DB $F7, $C3, $10, $08, $28 
DB $F7, $C3, $00, $0A, $28 

;ad85	
TM_0CC:
DW $0006  
DB $F3, $C3, $07, $08, $28 
DB $FB, $C3, $FF, $0A, $28 
DB $F3, $01, $FF, $0C, $28 
DB $EB, $01, $0F, $0D, $28 
DB $F3, $01, $17, $0E, $28 
DB $03, $00, $0F, $0F, $28 

;ada5	
TM_0CD:
DW $0004  
DB $EF, $C3, $FF, $08, $28 
DB $FF, $C3, $0F, $0A, $28 
DB $F7, $C3, $FF, $0C, $28 
DB $F7, $01, $0F, $0E, $28 

;adbb	
TM_0CE:
DW $0003  
DB $F1, $C3, $10, $08, $28 
DB $F9, $C3, $10, $0A, $28 
DB $F9, $C3, $00, $0C, $28 

;adcc	
TM_0CF:
DW $0002  
DB $EF, $C3, $00, $08, $28 
DB $F7, $C3, $00, $0A, $28 

;add8	
TM_0D0:
DW $0004  
DB $FB, $C3, $00, $08, $28 
DB $F3, $C3, $10, $0A, $28 
DB $F3, $01, $08, $0C, $28 
DB $03, $00, $10, $0D, $28 

;adee	
TM_0D1:
DW $0006  
DB $FF, $C3, $06, $08, $28 
DB $F7, $C3, $FE, $0A, $28 
DB $0F, $00, $0F, $0C, $28 
DB $EF, $01, $0E, $0D, $28 
DB $EF, $01, $06, $0E, $28 
DB $07, $00, $16, $0F, $28 

;ae0e	
TM_0D2:
DW $0004  
DB $FB, $01, $18, $0C, $28 
DB $FB, $C3, $00, $08, $28 
DB $F3, $C3, $08, $0A, $28 
DB $F3, $01, $18, $0D, $28 

;ae24	
TM_0D3:
DW $0006  
DB $FE, $C3, $06, $08, $28 
DB $F6, $C3, $FE, $0A, $28 
DB $0E, $00, $0F, $0C, $28 
DB $06, $00, $16, $0D, $28 
DB $EE, $01, $0E, $0E, $28 
DB $EE, $01, $06, $0F, $28 

;ae44	
TM_0D4:
DW $0008  
DB $F0, $01, $08, $0C, $28 
DB $F0, $01, $00, $0D, $28 
DB $F4, $01, $18, $0E, $28 
DB $F4, $01, $10, $0F, $28 
DB $F4, $01, $08, $1C, $28 
DB $F4, $01, $00, $1D, $28 
DB $FC, $C3, $10, $08, $28 
DB $FC, $C3, $00, $0A, $28 

;ae6e	
TM_0D5:
DW $0008  
DB $F0, $01, $08, $0C, $28 
DB $F0, $01, $00, $0D, $28 
DB $F4, $01, $18, $0E, $28 
DB $F4, $01, $10, $0F, $28 
DB $F4, $01, $08, $1C, $28 
DB $F4, $01, $00, $1D, $28 
DB $FC, $C3, $10, $08, $28 
DB $FC, $C3, $00, $0A, $28 

;ae98	
TM_0D6:
DW $0003  
DB $F1, $C3, $10, $08, $28 
DB $F9, $C3, $10, $0A, $28 
DB $F9, $C3, $00, $0C, $28 

;aea9
TM_0D7:
DW $0003  
DB $F1, $C3, $10, $08, $28 
DB $F9, $C3, $10, $0A, $28 
DB $F9, $C3, $00, $0C, $28 

;aeba	
TM_0D8:
DW $0003  
DB $FF, $C3, $10, $08, $68 
DB $F7, $C3, $10, $0A, $68 
DB $F7, $C3, $00, $0C, $68 

;aecb	
TM_0D9:
DW $0004  
DB $FB, $01, $0F, $0A, $28 
DB $F3, $01, $0F, $0B, $28 
DB $EB, $01, $0F, $0C, $28 
DB $F3, $C3, $FF, $08, $28 

;aee1	
TM_0DA:
DW $0004  
DB $FD, $01, $0F, $0A, $78 
DB $05, $00, $0F, $0B, $68 
DB $0D, $00, $0F, $0C, $68 
DB $FD, $C3, $FF, $08, $68 

;aef7	
TM_0DB:
DW $0003  
DB $FE, $C3, $08, $08, $28 
DB $F6, $C3, $00, $0A, $28 
DB $06, $00, $00, $0C, $28 

;af08	
TM_0DC:
DW $0003  
DB $F2, $C3, $08, $08, $68 
DB $FA, $C3, $00, $0A, $68 
DB $F2, $01, $00, $0C, $68 

;af19	
TM_0DD:
DW $0003  
DB $F6, $01, $10, $0C, $68 
DB $FE, $C3, $10, $08, $68 
DB $F6, $C3, $00, $0A, $68 

;af2a	
TM_0DE:
DW $0003  
DB $02, $00, $10, $0C, $28 
DB $F2, $C3, $10, $08, $28 
DB $FA, $C3, $00, $0A, $28 

;af3b	
TM_0DF:
DW $0003  
DB $F1, $01, $08, $0A, $28 
DB $F1, $01, $00, $0B, $28 
DB $F9, $C3, $00, $08, $28 

;af4c	
TM_0E0:
DW $0003  
DB $07, $00, $08, $0A, $68 
DB $07, $00, $00, $0B, $68 
DB $F7, $C3, $00, $08, $68 

;af5d	
TM_0E1:
DW $0002  
DB $EC, $C3, $00, $08, $28 
DB $F4, $C3, $00, $0A, $28 

;af69	
TM_0E2:
DW $0002  
DB $04, $C2, $00, $08, $28 
DB $FC, $C3, $00, $0A, $28 

;af75	
TM_0E3:
DW $0004  
DB $E8, $01, $10, $0C, $68 
DB $E8, $01, $08, $0D, $68 
DB $F0, $C3, $00, $08, $68 
DB $00, $C2, $00, $0A, $68 

;af8b	
TM_0E4:
DW $0004  
DB $10, $00, $10, $0C, $28 
DB $10, $00, $08, $0D, $28 
DB $00, $C2, $00, $08, $28 
DB $F0, $C3, $00, $0A, $28 

;afa1	
TM_0E5:
DW $0003  
DB $FF, $C3, $10, $08, $68 
DB $F7, $C3, $10, $0A, $68 
DB $F7, $C3, $00, $0C, $68 

;afb2	
TM_0E6:
DW $0002  
DB $F4, $C3, $00, $08, $28 
DB $FC, $C3, $00, $0A, $28 

;afbe	
TM_0E7:
DW $0002  
DB $FC, $C3, $00, $08, $28 
DB $F4, $C3, $00, $0A, $28 

;afca	
TM_0E8:
DW $0004  
DB $F0, $01, $18, $0C, $68 
DB $F0, $01, $10, $0D, $68 
DB $F8, $C3, $10, $08, $68 
DB $F8, $C3, $00, $0A, $68 

;afe0	
TM_0E9:
DW $0002  
DB $F8, $C3, $00, $08, $28 
DB $F8, $C3, $10, $0A, $28 

;afec	
TM_0EA:
DW $0001  
DB $F9, $C3, $00, $08, $28 

;aff3	
TM_0EB:
DW $0004  
DB $F2, $01, $18, $0C, $28 
DB $F2, $01, $10, $0D, $28 
DB $FA, $C3, $10, $08, $28 
DB $FA, $C3, $00, $0A, $28 

;b009	
TM_0EC:
DW $0002  
DB $FA, $C3, $0F, $08, $68 
DB $FA, $C3, $FF, $0A, $68 

;b015	
TM_0ED:
DW $0002  
DB $FA, $C3, $0F, $08, $68 
DB $FA, $C3, $FF, $0A, $68 

;b021	
TM_0EE:
DW $0004  
DB $F2, $01, $15, $0C, $28 
DB $F2, $01, $0D, $0D, $28 
DB $FA, $C3, $0D, $08, $28 
DB $FA, $C3, $FD, $0A, $28 

;b037	
TM_0EF:
DW $0004  
DB $06, $00, $15, $0C, $68 
DB $06, $00, $0D, $0D, $68 
DB $F6, $C3, $0D, $08, $68 
DB $F6, $C3, $FD, $0A, $68 

;b04d	
TM_0F0:
DW $0006  
DB $08, $00, $10, $0A, $28 
DB $08, $00, $08, $0B, $28 
DB $00, $00, $10, $0C, $28 
DB $F8, $01, $10, $0D, $28 
DB $08, $00, $00, $0E, $28 
DB $F8, $C3, $00, $08, $28 

;b06d	
TM_0F1:
DW $0006  
DB $F0, $01, $10, $0A, $68 
DB $F0, $01, $08, $0B, $68 
DB $F8, $01, $10, $0C, $68 
DB $00, $00, $10, $0D, $68 
DB $F0, $01, $00, $0E, $68 
DB $F8, $C3, $00, $08, $68 

;b08d	
TM_0F2:
DW $0003  
DB $09, $00, $02, $0C, $68 
DB $F9, $C3, $08, $08, $68 
DB $F9, $C3, $00, $0A, $68 

;b09e	
TM_0F3:
DW $0003  
DB $EF, $01, $02, $0C, $28 
DB $F7, $C3, $08, $08, $28 
DB $F7, $C3, $00, $0A, $28 

;b0af	
TM_0F4:
DW $0002  
DB $FC, $C3, $10, $08, $68 
DB $FC, $C3, $00, $0A, $68 

;b0bb	
TM_0F5:
DW $0002  
DB $F4, $C3, $10, $08, $28 
DB $F4, $C3, $00, $0A, $28 

;b0c7	
TM_0F6:
DW $0005  
DB $04, $00, $0F, $0A, $28 
DB $F4, $01, $10, $0B, $28 
DB $FC, $01, $17, $0C, $28 
DB $FC, $01, $0F, $0D, $28 
DB $FC, $C3, $FF, $08, $28 

;b0e2	
TM_0F7:
DW $0005  
DB $F4, $01, $0F, $0A, $68 
DB $04, $00, $10, $0B, $68 
DB $FC, $01, $17, $0C, $68 
DB $FC, $01, $0F, $0D, $68 
DB $F4, $C3, $FF, $08, $68 

;b0fd		;unused?
DW $0001  
DB $F8, $01, $F8, $08, $2C 

;b104	
TM_0F8:
DW $0006  
DB $FA, $01, $10, $0A, $68 
DB $02, $00, $10, $0B, $68 
DB $F2, $01, $10, $0C, $68 
DB $F2, $01, $08, $0D, $68 
DB $F2, $01, $00, $0E, $68 
DB $FA, $C3, $00, $08, $68 

;b124	
TM_0F9:
DW $0006  
DB $FE, $01, $10, $0A, $28 
DB $F6, $01, $10, $0B, $28 
DB $06, $00, $10, $0C, $28 
DB $06, $00, $08, $0D, $28 
DB $06, $00, $00, $0E, $28 
DB $F6, $C3, $00, $08, $28 

;b144	
TM_0FA:
DW $0007  
DB $0C, $00, $01, $0A, $28 
DB $04, $00, $02, $0B, $28 
DB $FC, $01, $10, $0C, $28 
DB $F4, $01, $10, $0D, $28 
DB $F4, $01, $08, $0E, $28 
DB $0C, $00, $00, $0F, $28 
DB $FC, $C3, $00, $08, $28 

;b169	
TM_0FB:
DW $0005  
DB $FC, $01, $10, $0A, $68 
DB $04, $00, $10, $0B, $68 
DB $04, $00, $08, $0C, $68 
DB $EC, $01, $00, $0D, $68 
DB $F4, $C3, $00, $08, $68 

;b184	
TM_0FC:
DW $0003  
DB $F8, $C3, $0F, $08, $28 
DB $08, $00, $0F, $0C, $28 
DB $F8, $C3, $FF, $0A, $28 

;b195	
TM_0FD:
DW $0003  
DB $F8, $C3, $0F, $08, $28 
DB $08, $00, $0F, $0C, $28 
DB $F8, $C3, $FF, $0A, $28 

;b1a6	
TM_0FE:
DW $0003  
DB $F8, $C3, $0F, $08, $68 
DB $F0, $01, $0F, $0C, $68 
DB $F8, $C3, $FF, $0A, $68 

;b1b7	
TM_0FF:
DW $0003  
DB $F8, $C3, $0F, $08, $68 
DB $F0, $01, $0F, $0C, $68 
DB $F8, $C3, $FF, $0A, $68 

;b1c8	
TM_100:
DW $0005  
DB $F6, $01, $10, $0C, $68 
DB $F6, $01, $08, $0D, $68 
DB $F6, $01, $00, $0E, $68 
DB $FE, $C3, $08, $08, $68 
DB $FE, $C3, $00, $0A, $68 

;b1e3	
TM_101:
DW $0005  
DB $02, $00, $10, $0C, $28 
DB $02, $00, $08, $0D, $28 
DB $02, $00, $00, $0E, $28 
DB $F2, $C3, $08, $08, $28 
DB $F2, $C3, $00, $0A, $28 

;b1fe	
TM_102:
DW $0004  
DB $FD, $C3, $08, $08, $68 
DB $F8, $01, $18, $0C, $68 
DB $F5, $01, $10, $0D, $68 
DB $FD, $C3, $00, $0A, $68 

;b214	
TM_103:
DW $0004  
DB $F3, $C3, $08, $08, $28 
DB $00, $00, $18, $0C, $28 
DB $03, $00, $10, $0D, $28 
DB $F3, $C3, $00, $0A, $28 

;b22a		;unused?
DW $0002  
DB $FA, $C3, $10, $08, $68 
DB $FA, $C3, $00, $0A, $68 

;b236	
TM_104:
DW $0002  
DB $04, $00, $08, $0A, $28 
DB $F4, $C3, $00, $08, $28 

;b242	
TM_105:
DW $0002  
DB $F4, $01, $08, $0A, $68 
DB $FC, $C3, $00, $08, $68 

;b24e	
TM_106:
DW $0006  
DB $F1, $C3, $08, $08, $78 
DB $00, $C2, $08, $08, $38 
DB $F0, $C3, $F8, $0A, $38 
DB $00, $C2, $F8, $0C, $38 
DB $F1, $C3, $E8, $0E, $78 
DB $00, $C2, $E8, $0E, $38 

;b26e	
TM_107:
DW $0006  
DB $F1, $C3, $08, $08, $78 
DB $F1, $C3, $E8, $0A, $78 
DB $F0, $C3, $F8, $0C, $38 
DB $00, $C2, $08, $08, $38 
DB $00, $C2, $F8, $0E, $38 
DB $00, $C2, $E8, $0A, $38 

;b28e		;unused?
DW $0001  
DB $F8, $01, $F8, $08, $30 

;b295	
TM_108:
DW $0004  
DB $F1, $01, $18, $0C, $28 
DB $F1, $01, $10, $0D, $28 
DB $F9, $C3, $10, $08, $28 
DB $F9, $C3, $00, $0A, $28 

;b2ab	
TM_109:
DW $0004  
DB $07, $00, $18, $0C, $68 
DB $07, $00, $10, $0D, $68 
DB $F7, $C3, $10, $08, $68 
DB $F7, $C3, $00, $0A, $68 

;b2c1	
TM_10A:
DW $0002  
DB $F8, $C3, $10, $08, $68 
DB $F8, $C3, $00, $0A, $68 

;b2cd	
TM_10B:
DW $0005  
DB $FD, $C3, $07, $08, $68 
DB $F5, $C3, $FF, $0A, $68 
DB $0D, $00, $0F, $0C, $68 
DB $05, $00, $17, $0D, $68 
DB $F5, $01, $0F, $0E, $68 

;b2e8	
TM_10C:
DW $0004  
DB $00, $C2, $FF, $08, $68 
DB $F0, $C3, $0F, $0A, $68 
DB $F8, $C3, $FF, $0C, $68 
DB $F0, $01, $07, $0E, $68 

;b2fe	
TM_10D:
DW $0002  
DB $F9, $C3, $10, $08, $68 
DB $F9, $C3, $00, $0A, $68 

;b30a	
TM_10E:
DW $0006  
DB $FD, $C3, $07, $08, $68 
DB $F5, $C3, $FF, $0A, $68 
DB $05, $00, $FF, $0C, $68 
DB $0D, $00, $0F, $0D, $68 
DB $05, $00, $17, $0E, $68 
DB $F5, $01, $0F, $0F, $68 

;b32a	
TM_10F:
DW $0004  
DB $01, $C2, $FF, $08, $68 
DB $F1, $C3, $0F, $0A, $68 
DB $F9, $C3, $FF, $0C, $68 
DB $01, $00, $0F, $0E, $68 

;b340	
TM_110:
DW $0003  
DB $FF, $C3, $10, $08, $68 
DB $F7, $C3, $10, $0A, $68 
DB $F7, $C3, $00, $0C, $68 

;b351	
TM_111:
DW $0002  
DB $01, $C2, $00, $08, $68 
DB $F9, $C3, $00, $0A, $68 

;b35d	
TM_112:
DW $0004  
DB $F5, $C3, $00, $08, $68 
DB $FD, $C3, $10, $0A, $68 
DB $05, $00, $08, $0C, $68 
DB $F5, $01, $10, $0D, $68 

;b373	
TM_113:
DW $0006  
DB $F1, $C3, $06, $08, $68 
DB $F9, $C3, $FE, $0A, $68 
DB $E9, $01, $0F, $0C, $68 
DB $09, $00, $0E, $0D, $68 
DB $09, $00, $06, $0E, $68 
DB $F1, $01, $16, $0F, $68 

;b393	
TM_114:
DW $0004  
DB $FD, $01, $18, $0C, $68 
DB $F5, $C3, $00, $08, $68 
DB $FD, $C3, $08, $0A, $68 
DB $05, $00, $18, $0D, $68 

;b3a9	
TM_115:
DW $0006  
DB $F2, $C3, $06, $08, $68 
DB $FA, $C3, $FE, $0A, $68 
DB $EA, $01, $0F, $0C, $68 
DB $F2, $01, $16, $0D, $68 
DB $0A, $00, $0E, $0E, $68 
DB $0A, $00, $06, $0F, $68 

;b3c9	
TM_116:
DW $0004  
DB $08, $00, $18, $0C, $28 
DB $08, $00, $10, $0D, $28 
DB $F8, $C3, $10, $08, $28 
DB $F8, $C3, $00, $0A, $28 

;b3df		;unused?
DW $0001  
DB $F8, $01, $F8, $08, $3C 

;b3e6		;unused?
DW $0001  
DB $F8, $01, $F8, $08, $3C 

;b3ed	
TM_117:
DW $0004  
DB $06, $00, $18, $0C, $68 
DB $06, $00, $10, $0D, $68 
DB $F6, $C3, $10, $08, $68 
DB $F6, $C3, $00, $0A, $68 

;b403	
TM_118:
DW $0002  
DB $F6, $C3, $0F, $08, $28 
DB $F6, $C3, $FF, $0A, $28 

;b40f	
TM_119:
DW $0002  
DB $F6, $C3, $0F, $08, $28 
DB $F6, $C3, $FF, $0A, $28 

;b41b	
TM_11A:
DW $0003  
DB $E8, $01, $04, $0A, $28 
DB $E8, $01, $FC, $0B, $28 
DB $F0, $C3, $FC, $08, $28 

;b42c	
TM_11B:
DW $0006  
DB $E9, $01, $0D, $0A, $28 
DB $E9, $01, $05, $0B, $28 
DB $E9, $01, $FD, $0C, $28 
DB $F9, $01, $0D, $0D, $28 
DB $F1, $01, $0D, $0E, $28 
DB $F1, $C3, $FD, $08, $28 

;b44c	
TM_11C:
DW $0003  
DB $E9, $C3, $07, $08, $28 
DB $E9, $01, $FF, $0C, $28 
DB $F1, $C3, $FF, $0A, $28 

;b45d	
TM_11D:
DW $0004  
DB $F8, $01, $10, $0A, $28 
DB $F0, $01, $10, $0B, $28 
DB $F0, $01, $08, $0C, $28 
DB $F8, $C3, $00, $08, $28 

;b473	
TM_11E:
DW $0005  
DB $03, $00, $10, $0A, $28 
DB $FB, $01, $10, $0B, $28 
DB $F3, $01, $10, $0C, $28 
DB $F3, $01, $08, $0D, $28 
DB $FB, $C3, $00, $08, $28 

;b48e	
TM_11F:
DW $0005  
DB $F5, $01, $08, $0A, $28 
DB $05, $00, $10, $0B, $28 
DB $FD, $01, $10, $0C, $28 
DB $F5, $01, $10, $0D, $28 
DB $FD, $C3, $00, $08, $28 

;b4a9	
TM_120:
DW $0003  
DB $05, $00, $10, $0A, $28 
DB $FD, $01, $10, $0B, $28 
DB $FD, $C3, $00, $08, $28 

;b4ba	
TM_121:
DW $0004  
DB $0F, $00, $0F, $0A, $28 
DB $07, $00, $0F, $0B, $28 
DB $FF, $01, $FF, $0C, $28 
DB $07, $C2, $FF, $08, $28 

;b4d0	
TM_122:
DW $0004  
DB $07, $00, $0B, $0A, $28 
DB $0F, $00, $0B, $0B, $28 
DB $0F, $00, $03, $0C, $28 
DB $FF, $C3, $FB, $08, $28 

;b4e6	
TM_123:
DW $0005  
DB $08, $00, $08, $0A, $28 
DB $10, $00, $F8, $0B, $28 
DB $10, $00, $08, $0C, $28 
DB $10, $00, $00, $0D, $28 
DB $00, $C2, $F8, $08, $28 

;b501		;unused?
DW $0003  
DB $10, $00, $08, $0C, $20 
DB $10, $C2, $F8, $08, $28 
DB $00, $C2, $F8, $0A, $28 

;b512	
TM_124:
DW $0002  
DB $F8, $C3, $10, $08, $28 
DB $F8, $C3, $00, $0A, $28 

;b51e	
TM_125:
DW $0002  
DB $F8, $C3, $10, $08, $28 
DB $F8, $C3, $00, $0A, $28 

;b52a	
TM_126:
DW $0002  
DB $F0, $C3, $F9, $08, $28 
DB $E0, $C3, $F9, $0A, $28 

;b536	
TM_127:
DW $0004  
DB $E1, $01, $0F, $0A, $28 
DB $E1, $01, $07, $0B, $28 
DB $F9, $01, $FF, $0C, $28 
DB $E9, $C3, $FF, $08, $28 

;b54c	
TM_128:
DW $0002  
DB $E9, $C3, $07, $08, $28 
DB $F1, $C3, $FF, $0A, $28 

;b558	
TM_129:
DW $0002  
DB $EB, $C3, $0F, $08, $28 
DB $F3, $C3, $FF, $0A, $28 

;b564	
TM_12A:
DW $0004  
DB $F3, $01, $07, $0A, $28 
DB $F3, $C3, $0F, $08, $28 
DB $FB, $01, $07, $0B, $28 
DB $FB, $01, $FF, $0C, $28 

;b57a	
TM_12B:
DW $0002  
DB $F9, $C3, $10, $08, $28 
DB $F9, $C3, $00, $0A, $28 

;b586	
TM_12C:
DW $0002  
DB $FD, $C3, $0E, $08, $28 
DB $FD, $C3, $FE, $0A, $28 

;b592	
TM_12D:
DW $0002  
DB $07, $C2, $0F, $08, $28 
DB $FF, $C3, $FF, $0A, $28 

;b59e	
TM_12E:
DW $0004  
DB $18, $00, $10, $0C, $28 
DB $18, $00, $08, $0D, $28 
DB $08, $C2, $08, $08, $28 
DB $00, $C2, $00, $0A, $28 

;b5b4	
TM_12F:
DW $0002  
DB $0F, $C2, $04, $08, $28 
DB $FF, $C3, $FC, $0A, $28 

;b5c0		;unused?
DW $0002  
DB $00, $C2, $F8, $08, $E8 
DB $10, $C2, $F8, $0A, $E8 

;b5cc	
TM_130:
DW $0003  
DB $10, $00, $F4, $0A, $E8 
DB $10, $00, $FC, $0B, $E8 
DB $00, $C2, $F4, $08, $E8 

;b5dd	
TM_131:
DW $0006  
DB $0F, $00, $EB, $0A, $E8 
DB $0F, $00, $F3, $0B, $E8 
DB $0F, $00, $FB, $0C, $E8 
DB $FF, $01, $EB, $0D, $E8 
DB $07, $00, $EB, $0E, $E8 
DB $FF, $C3, $F3, $08, $E8 

;b5fd	
TM_132:
DW $0003  
DB $07, $C2, $E9, $08, $E8 
DB $0F, $00, $F9, $0C, $E8 
DB $FF, $C3, $F1, $0A, $E8 

;b60e	
TM_133:
DW $0004  
DB $00, $00, $E8, $0A, $E8 
DB $08, $00, $E8, $0B, $E8 
DB $08, $00, $F0, $0C, $E8 
DB $F8, $C3, $F0, $08, $E8 

;b624	
TM_134:
DW $0005  
DB $F5, $01, $E8, $0A, $E8 
DB $FD, $01, $E8, $0B, $E8 
DB $05, $00, $E8, $0C, $E8 
DB $05, $00, $F0, $0D, $E8 
DB $F5, $C3, $F0, $08, $E8 

;b63f	
TM_135:
DW $0005  
DB $03, $00, $F0, $0A, $E8 
DB $F3, $01, $E8, $0B, $E8 
DB $FB, $01, $E8, $0C, $E8 
DB $03, $00, $E8, $0D, $E8 
DB $F3, $C3, $F0, $08, $E8 

;b65a	
TM_136:
DW $0003  
DB $F3, $01, $E8, $0A, $E8 
DB $FB, $01, $E8, $0B, $E8 
DB $F3, $C3, $F0, $08, $E8 

;b66b	
TM_137:
DW $0004  
DB $E9, $01, $E9, $0A, $E8 
DB $F1, $01, $E9, $0B, $E8 
DB $F9, $01, $F9, $0C, $E8 
DB $E9, $C3, $F1, $08, $E8 

;b681	
TM_138:
DW $0004  
DB $F1, $01, $ED, $0A, $E8 
DB $E9, $01, $ED, $0B, $E8 
DB $E9, $01, $F5, $0C, $E8 
DB $F1, $C3, $F5, $08, $E8 

;b697	
TM_139:
DW $0005  
DB $F0, $01, $F0, $0A, $E8 
DB $E8, $01, $00, $0B, $E8 
DB $E8, $01, $F0, $0C, $E8 
DB $E8, $01, $F8, $0D, $E8 
DB $F0, $C3, $F8, $08, $E8 

;b6b2		;unused?
DW $0003  
DB $E8, $01, $F0, $0C, $E8 
DB $E0, $C3, $F8, $08, $E8 
DB $F0, $C3, $F8, $0A, $E8 

;b6c3		;unused?
DW $0002  
DB $F8, $C3, $E0, $08, $E8 
DB $F8, $C3, $F0, $0A, $E8 

;b6cf		;unused?
DW $0002  
DB $F8, $C3, $E0, $08, $E8 
DB $F8, $C3, $F0, $0A, $E8 

;b6db	
TM_13A:
DW $0002  
DB $00, $C2, $F7, $08, $E8 
DB $10, $C2, $F7, $0A, $E8 

;b6e7	
TM_13B:
DW $0004  
DB $17, $00, $E9, $0A, $E8 
DB $17, $00, $F1, $0B, $E8 
DB $FF, $01, $F9, $0C, $E8 
DB $07, $C2, $F1, $08, $E8 

;b6fd	
TM_13C:
DW $0002  
DB $07, $C2, $E9, $08, $E8 
DB $FF, $C3, $F1, $0A, $E8 

;b709	
TM_13D:
DW $0002  
DB $05, $C2, $E1, $08, $E8 
DB $FD, $C3, $F1, $0A, $E8 

;b715	
TM_13E:
DW $0004  
DB $05, $00, $F1, $0A, $E8 
DB $FD, $C3, $E1, $08, $E8 
DB $FD, $01, $F1, $0B, $E8 
DB $FD, $01, $F9, $0C, $E8 

;b72b	
TM_13F:
DW $0002  
DB $F7, $C3, $E0, $08, $E8 
DB $F7, $C3, $F0, $0A, $E8 

;b737	
TM_140:
DW $0002  
DB $F3, $C3, $E2, $08, $E8 
DB $F3, $C3, $F2, $0A, $E8 

;b743	
TM_141:
DW $0002  
DB $E9, $C3, $E1, $08, $E8 
DB $F1, $C3, $F1, $0A, $E8 

;b74f	
TM_142:
DW $0002  
DB $E1, $C3, $EC, $08, $E8 
DB $F1, $C3, $F4, $0A, $E8 

;b75b		;unused?
DW $0002  
DB $F0, $C3, $F8, $08, $28 
DB $E0, $C3, $F8, $0A, $28 

;b767	
TM_143:
DW $0003  
DB $10, $00, $04, $0A, $68 
DB $10, $00, $FC, $0B, $68 
DB $00, $C2, $FC, $08, $68 

;b778	
TM_144:
DW $0006  
DB $0F, $00, $0D, $0A, $68 
DB $0F, $00, $05, $0B, $68 
DB $0F, $00, $FD, $0C, $68 
DB $FF, $01, $0D, $0D, $68 
DB $07, $00, $0D, $0E, $68 
DB $FF, $C3, $FD, $08, $68 

;b798	
TM_145:
DW $0003  
DB $07, $C2, $07, $08, $68 
DB $0F, $00, $FF, $0C, $68 
DB $FF, $C3, $FF, $0A, $68 

;b7a9	
TM_146:
DW $0004  
DB $00, $00, $10, $0A, $68 
DB $08, $00, $10, $0B, $68 
DB $08, $00, $08, $0C, $68 
DB $F8, $C3, $00, $08, $68 

;b7bf	
TM_147:
DW $0005  
DB $F5, $01, $10, $0A, $68 
DB $FD, $01, $10, $0B, $68 
DB $05, $00, $10, $0C, $68 
DB $05, $00, $08, $0D, $68 
DB $F5, $C3, $00, $08, $68 

;b7da	
TM_148:
DW $0005  
DB $03, $00, $08, $0A, $68 
DB $F3, $01, $10, $0B, $68 
DB $FB, $01, $10, $0C, $68 
DB $03, $00, $10, $0D, $68 
DB $F3, $C3, $00, $08, $68 

;b7f5	
TM_149:
DW $0003  
DB $F3, $01, $10, $0A, $68 
DB $FB, $01, $10, $0B, $68 
DB $F3, $C3, $00, $08, $68 

;b806	
TM_14A:
DW $0004  
DB $E9, $01, $0F, $0A, $68 
DB $F1, $01, $0F, $0B, $68 
DB $F9, $01, $FF, $0C, $68 
DB $E9, $C3, $FF, $08, $68 

;b81c	
TM_14B:
DW $0004  
DB $F1, $01, $0B, $0A, $68 
DB $E9, $01, $0B, $0B, $68 
DB $E9, $01, $03, $0C, $68 
DB $F1, $C3, $FB, $08, $68 

;b832	
TM_14C:
DW $0005  
DB $F0, $01, $08, $0A, $68 
DB $E8, $01, $F8, $0B, $68 
DB $E8, $01, $08, $0C, $68 
DB $E8, $01, $00, $0D, $68 
DB $F0, $C3, $F8, $08, $68 

;b84d		;unused?
DW $0003  
DB $E8, $01, $08, $0C, $60 
DB $E0, $C3, $F8, $08, $68 
DB $F0, $C3, $F8, $0A, $68 

;b85e	
TM_14D:
DW $0002  
DB $F8, $C3, $10, $08, $68 
DB $F8, $C3, $00, $0A, $68 

;b86a	
TM_14E:
DW $0002  
DB $F8, $C3, $10, $08, $68 
DB $F8, $C3, $00, $0A, $68 

;b876	
TM_14F:
DW $0002  
DB $00, $C2, $F9, $08, $68 
DB $10, $C2, $F9, $0A, $68 

;b882	
TM_150:
DW $0004  
DB $17, $00, $0F, $0A, $68 
DB $17, $00, $07, $0B, $68 
DB $FF, $01, $FF, $0C, $68 
DB $07, $C2, $FF, $08, $68 

;b898	
TM_151:
DW $0002  
DB $07, $C2, $07, $08, $68 
DB $FF, $C3, $FF, $0A, $68 

;b8a4	
TM_152:
DW $0002  
DB $05, $C2, $0F, $08, $68 
DB $FD, $C3, $FF, $0A, $68 

;b8b0	
TM_153:
DW $0004  
DB $05, $00, $07, $0A, $68 
DB $FD, $C3, $0F, $08, $68 
DB $FD, $01, $07, $0B, $68 
DB $FD, $01, $FF, $0C, $68 

;b8c6	
TM_154:
DW $0002  
DB $F7, $C3, $10, $08, $68 
DB $F7, $C3, $00, $0A, $68 

;b8d2	
TM_155:
DW $0002  
DB $F3, $C3, $0E, $08, $68 
DB $F3, $C3, $FE, $0A, $68 

;b8de	
TM_156:
DW $0002  
DB $E9, $C3, $0F, $08, $68 
DB $F1, $C3, $FF, $0A, $68 

;b8ea	
TM_157:
DW $0004  
DB $E0, $01, $10, $0C, $68 
DB $E0, $01, $08, $0D, $68 
DB $E8, $C3, $08, $08, $68 
DB $F0, $C3, $00, $0A, $68 

;b900	
TM_158:
DW $0002  
DB $E1, $C3, $04, $08, $68 
DB $F1, $C3, $FC, $0A, $68 

;b90c		;unused?
DW $0002  
DB $F0, $C3, $F8, $08, $A8 
DB $E0, $C3, $F8, $0A, $A8 

;b918	
TM_159:
DW $0003  
DB $E8, $01, $F4, $0A, $A8 
DB $E8, $01, $FC, $0B, $A8 
DB $F0, $C3, $F4, $08, $A8 

;b929	
TM_15A:
DW $0006  
DB $E9, $01, $EB, $0A, $A8 
DB $E9, $01, $F3, $0B, $A8 
DB $E9, $01, $FB, $0C, $A8 
DB $F9, $01, $EB, $0D, $A8 
DB $F1, $01, $EB, $0E, $A8 
DB $F1, $C3, $F3, $08, $A8 

;b949	
TM_15B:
DW $0003  
DB $E9, $C3, $E9, $08, $A8 
DB $E9, $01, $F9, $0C, $A8 
DB $F1, $C3, $F1, $0A, $A8 

;b95a	
TM_15C:
DW $0004  
DB $F8, $01, $E8, $0A, $A8 
DB $F0, $01, $E8, $0B, $A8 
DB $F0, $01, $F0, $0C, $A8 
DB $F8, $C3, $F0, $08, $A8 

;b970	
TM_15D:
DW $0005  
DB $03, $00, $E8, $0A, $A8 
DB $FB, $01, $E8, $0B, $A8 
DB $F3, $01, $E8, $0C, $A8 
DB $F3, $01, $F0, $0D, $A8 
DB $FB, $C3, $F0, $08, $A8 

;b98b	
TM_15E:
DW $0005  
DB $F5, $01, $F0, $0A, $A8 
DB $05, $00, $E8, $0B, $A8 
DB $FD, $01, $E8, $0C, $A8 
DB $F5, $01, $E8, $0D, $A8 
DB $FD, $C3, $F0, $08, $A8 

;b9a6	
TM_15F:
DW $0003  
DB $05, $00, $E8, $0A, $A8 
DB $FD, $01, $E8, $0B, $A8 
DB $FD, $C3, $F0, $08, $A8 

;b9b7	
TM_160:
DW $0004  
DB $0F, $00, $E9, $0A, $A8 
DB $07, $00, $E9, $0B, $A8 
DB $FF, $01, $F9, $0C, $A8 
DB $07, $C2, $F1, $08, $A8 

;b9cd	
TM_161:
DW $0004  
DB $07, $00, $ED, $0A, $A8 
DB $0F, $00, $ED, $0B, $A8 
DB $0F, $00, $F5, $0C, $A8 
DB $FF, $C3, $F5, $08, $A8 

;b9e3	
TM_162:
DW $0005  
DB $08, $00, $F0, $0A, $A8 
DB $10, $00, $00, $0B, $A8 
DB $10, $00, $F0, $0C, $A8 
DB $10, $00, $F8, $0D, $A8 
DB $00, $C2, $F8, $08, $A8 

;b9fe		;unused?
DW $0003  
DB $10, $00, $F0, $0C, $A8 
DB $10, $C2, $F8, $08, $A8 
DB $00, $C2, $F8, $0A, $A8 

;ba0f		;unused?
DW $0002  
DB $F8, $C3, $E0, $08, $A8 
DB $F8, $C3, $F0, $0A, $A8 

;ba1b		;unused?
DW $0002  
DB $F8, $C3, $E0, $08, $A8 
DB $F8, $C3, $F0, $0A, $A8 

;ba27	
TM_163:
DW $0002  
DB $F0, $C3, $F7, $08, $A8 
DB $E0, $C3, $F7, $0A, $A8 

;ba33	
TM_164:
DW $0004  
DB $E1, $01, $E9, $0A, $A8 
DB $E1, $01, $F1, $0B, $A8 
DB $F9, $01, $F9, $0C, $A8 
DB $E9, $C3, $F1, $08, $A8 

;ba49	
TM_165:
DW $0002  
DB $E9, $C3, $E9, $08, $A8 
DB $F1, $C3, $F1, $0A, $A8 

;ba55	
TM_166:
DW $0002  
DB $EB, $C3, $E1, $08, $A8 
DB $F3, $C3, $F1, $0A, $A8 

;ba61	
TM_167:
DW $0004  
DB $F3, $01, $F1, $0A, $A8 
DB $F3, $C3, $E1, $08, $A8 
DB $FB, $01, $F1, $0B, $A8 
DB $FB, $01, $F9, $0C, $A8 

;ba77	
TM_168:
DW $0002  
DB $F9, $C3, $E0, $08, $A8 
DB $F9, $C3, $F0, $0A, $A8 

;ba83	
TM_169:
DW $0002  
DB $FD, $C3, $E2, $08, $A8 
DB $FD, $C3, $F2, $0A, $A8 

;ba8f	
TM_16A:
DW $0002  
DB $07, $C2, $E1, $08, $A8 
DB $FF, $C3, $F1, $0A, $A8 

;ba9b	
TM_16B:
DW $0002  
DB $0F, $C2, $EC, $08, $A8 
DB $FF, $C3, $F4, $0A, $A8 

;baa7	
TM_16C:
DW $0002  
DB $00, $C2, $F8, $08, $68 
DB $10, $C2, $F8, $0A, $68 

;bab3	
TM_16D:
DW $0002  
DB $F8, $01, $F8, $02, $28 
DB $F8, $C3, $F8, $00, $28 

;babf	
TM_16E:
DW $0002  
DB $F8, $01, $F8, $02, $28 
DB $F8, $C3, $F8, $00, $68 

;bacb	
TM_16F:
DW $0002  
DB $F8, $01, $F8, $02, $28 
DB $F8, $C3, $F8, $00, $E8 

;bad7	
TM_170:
DW $0002  
DB $F8, $01, $F8, $02, $28 
DB $F8, $C3, $F8, $00, $A8 

;bae3	
TM_171:
DW $0005  
DB $F8, $01, $F8, $00, $28 
DB $00, $00, $FF, $01, $28 
DB $F8, $01, $FF, $02, $28 
DB $00, $00, $F7, $03, $28 
DB $F8, $01, $F7, $04, $28 

;bafe	
TM_172:
DW $0002  
DB $F8, $01, $F8, $02, $28 
DB $F8, $C3, $F9, $00, $28 

;bb0a	
TM_173:
DW $0002  
DB $F8, $01, $F8, $02, $28 
DB $F8, $C3, $F7, $00, $A8 

;bb16	
TM_174:
DW $0002  
DB $F8, $01, $F8, $02, $28 
DB $F8, $C3, $F9, $00, $68 

;bb22	
TM_175:
DW $0002  
DB $F8, $C3, $00, $00, $28 
DB $F8, $C3, $F0, $02, $28 

;bb2e	
TM_176:
DW $0004  
DB $00, $C2, $F1, $00, $28 
DB $F0, $C3, $01, $02, $28 
DB $00, $C2, $01, $04, $28 
DB $F0, $C3, $F1, $06, $28 

;bb44	
TM_177:
DW $0002  
DB $00, $C2, $F8, $00, $28 
DB $F0, $C3, $F8, $02, $28 

;bb50	
TM_178:
DW $0004  
DB $01, $C2, $01, $00, $E8 
DB $F1, $C3, $F1, $02, $E8 
DB $F1, $C3, $01, $04, $E8 
DB $01, $C2, $F1, $06, $E8 

;bb66	
TM_179:
DW $0002  
DB $F8, $C3, $F0, $00, $E8 
DB $F8, $C3, $00, $02, $E8 

;bb72	
TM_17A:
DW $0004  
DB $F1, $C3, $FF, $00, $E8 
DB $01, $C2, $EF, $02, $E8 
DB $01, $C2, $FF, $04, $E8 
DB $F1, $C3, $EF, $06, $E8 

;bb88	
TM_17B:
DW $0002  
DB $F0, $C3, $F8, $00, $E8 
DB $00, $C2, $F8, $02, $E8 

;bb94	
TM_17C:
DW $0004  
DB $EF, $C3, $EE, $00, $28 
DB $FF, $C3, $FE, $02, $28 
DB $EF, $C3, $FE, $04, $28 
DB $FF, $C3, $EE, $06, $28 

;bbaa	
TM_17D:
DW $000A  
DB $F8, $01, $0A, $00, $28 
DB $F0, $01, $0A, $01, $28 
DB $0A, $00, $00, $02, $28 
DB $EE, $01, $00, $03, $28 
DB $0A, $00, $F6, $04, $28 
DB $EE, $01, $F8, $05, $28 
DB $0A, $00, $EE, $06, $28 
DB $00, $00, $EE, $07, $28 
DB $F8, $01, $EE, $10, $28 
DB $EE, $01, $F0, $11, $28 

;bbde	
TM_17E:
DW $000B  
DB $00, $00, $08, $00, $28 
DB $F8, $01, $08, $01, $28 
DB $F0, $01, $08, $02, $28 
DB $08, $00, $00, $03, $28 
DB $F0, $01, $00, $04, $28 
DB $08, $00, $F8, $05, $28 
DB $F0, $01, $F6, $06, $28 
DB $08, $00, $F0, $07, $28 
DB $00, $00, $F0, $10, $28 
DB $F8, $01, $EE, $11, $28 
DB $F0, $01, $EE, $12, $28 

;bc17	
TM_17F:
DW $000B  
DB $0A, $00, $08, $00, $28 
DB $02, $00, $08, $01, $28 
DB $F8, $01, $08, $02, $28 
DB $F0, $01, $08, $03, $28 
DB $0A, $00, $00, $04, $28 
DB $EE, $01, $00, $05, $28 
DB $0A, $00, $F6, $06, $28 
DB $EE, $01, $F8, $07, $28 
DB $0A, $00, $EE, $10, $28 
DB $F8, $01, $EE, $11, $28 
DB $F0, $01, $EE, $12, $28 

;bc50	
TM_180:
DW $0008  
DB $08, $00, $08, $00, $28 
DB $00, $00, $08, $01, $28 
DB $F8, $01, $08, $02, $28 
DB $F0, $01, $08, $03, $28 
DB $08, $00, $00, $04, $28 
DB $08, $00, $F0, $05, $28 
DB $00, $00, $F0, $06, $28 
DB $F0, $01, $F0, $07, $28 

;bc7a	
TM_181:
DW $0001  
DB $F8, $01, $F8, $00, $10 

;bc81		;unused?
DW $0001  
DB $F8, $01, $F8, $00, $38 

;bc88	
TM_182:
DW $0002  
DB $07, $00, $FC, $02, $28 
DB $F7, $C3, $F9, $00, $28 

;bc94		;unused?
DW $0002  
DB $FD, $01, $07, $02, $28 
DB $F8, $C3, $F7, $00, $28 

;bca0	
TM_183:
DW $0003  
DB $00, $00, $05, $02, $28 
DB $F8, $01, $05, $03, $28 
DB $F8, $C3, $F5, $00, $28 

;bcb1	
TM_184:
DW $0005  
DB $00, $00, $0A, $02, $28 
DB $F8, $01, $0A, $03, $28 
DB $00, $00, $02, $04, $28 
DB $F8, $01, $02, $05, $28 
DB $F8, $C3, $F2, $00, $28 

;bccc	
TM_185:
DW $0003  
DB $F8, $01, $05, $02, $68 
DB $00, $00, $05, $03, $68 
DB $F8, $C3, $F5, $00, $68 

;bcdd	
TM_186:
DW $0005  
DB $F8, $01, $0A, $02, $68 
DB $00, $00, $0A, $03, $68 
DB $F8, $01, $02, $04, $68 
DB $00, $00, $02, $05, $68 
DB $F8, $C3, $F2, $00, $68 

;bcf8		;unused?
DW $0002  
DB $F8, $01, $F8, $02, $68 
DB $F8, $C3, $F8, $00, $68 

;bd04		;unused?
DW $0002  
DB $F8, $01, $F8, $02, $68 
DB $F8, $C3, $F8, $00, $28 

;bd10		;unused?
DW $0002  
DB $F8, $01, $F8, $02, $68 
DB $F8, $C3, $F8, $00, $A8 

;bd1c		;unused?
DW $0002  
DB $F8, $01, $F8, $02, $68 
DB $F8, $C3, $F8, $00, $E8 

;bd28		;unused?
DW $0005  
DB $F8, $01, $F8, $00, $68 
DB $F8, $01, $FF, $01, $68 
DB $00, $00, $FF, $02, $68 
DB $F8, $01, $F7, $03, $68 
DB $00, $00, $F7, $04, $68 

;bd43		;unused?
DW $0002  
DB $F8, $01, $F8, $02, $68 
DB $F8, $C3, $F9, $00, $68 

;bd4f		;unused?
DW $0002  
DB $F8, $01, $F8, $02, $68 
DB $F8, $C3, $F7, $00, $E8 

;bd5b		;unused?
DW $0002  
DB $F8, $01, $F8, $02, $68 
DB $F8, $C3, $F9, $00, $28 

;bd67	
TM_187:
DW $0002  
DB $F8, $C3, $00, $00, $68 
DB $F8, $C3, $F0, $02, $68 

;bd73	
TM_188:
DW $0004  
DB $F0, $C3, $F1, $00, $68 
DB $00, $C2, $01, $02, $68 
DB $F0, $C3, $01, $04, $68 
DB $00, $C2, $F1, $06, $68 

;bd89	
TM_189:
DW $0002  
DB $F0, $C3, $F8, $00, $68 
DB $00, $C2, $F8, $02, $68 

;bd95	
TM_18A:
DW $0004  
DB $EF, $C3, $01, $00, $A8 
DB $FF, $C3, $F1, $02, $A8 
DB $FF, $C3, $01, $04, $A8 
DB $EF, $C3, $F1, $06, $A8 

;bdab	
TM_18B:
DW $0002  
DB $F8, $C3, $F0, $00, $A8 
DB $F8, $C3, $00, $02, $A8 

;bdb7	
TM_18C:
DW $0004  
DB $FF, $C3, $FF, $00, $A8 
DB $EF, $C3, $EF, $02, $A8 
DB $EF, $C3, $FF, $04, $A8 
DB $FF, $C3, $EF, $06, $A8 

;bdcd	
TM_18D:
DW $0002  
DB $00, $C2, $F8, $00, $A8 
DB $F0, $C3, $F8, $02, $A8 

;bdd9	
TM_18E:
DW $0004  
DB $01, $C2, $EE, $00, $68 
DB $F1, $C3, $FE, $02, $68 
DB $01, $C2, $FE, $04, $68 
DB $F1, $C3, $EE, $06, $68 

;bdef	
TM_18F:
DW $000A  
DB $00, $00, $0A, $00, $68 
DB $08, $00, $0A, $01, $68 
DB $EE, $01, $00, $02, $68 
DB $0A, $00, $00, $03, $68 
DB $EE, $01, $F6, $04, $68 
DB $0A, $00, $F8, $05, $68 
DB $EE, $01, $EE, $06, $68 
DB $F8, $01, $EE, $07, $68 
DB $00, $00, $EE, $10, $68 
DB $0A, $00, $F0, $11, $68 

;be23	
TM_190:
DW $000B  
DB $F8, $01, $08, $00, $68 
DB $00, $00, $08, $01, $68 
DB $08, $00, $08, $02, $68 
DB $F0, $01, $00, $03, $68 
DB $08, $00, $00, $04, $68 
DB $F0, $01, $F8, $05, $68 
DB $08, $00, $F6, $06, $68 
DB $F0, $01, $F0, $07, $68 
DB $F8, $01, $F0, $10, $68 
DB $00, $00, $EE, $11, $68 
DB $08, $00, $EE, $12, $68 

;be5c	
TM_191:
DW $000B  
DB $EE, $01, $08, $00, $68 
DB $F6, $01, $08, $01, $68 
DB $00, $00, $08, $02, $68 
DB $08, $00, $08, $03, $68 
DB $EE, $01, $00, $04, $68 
DB $0A, $00, $00, $05, $68 
DB $EE, $01, $F6, $06, $68 
DB $0A, $00, $F8, $07, $68 
DB $EE, $01, $EE, $10, $68 
DB $00, $00, $EE, $11, $68 
DB $08, $00, $EE, $12, $68 

;be95	
TM_192:
DW $0008  
DB $F0, $01, $08, $00, $68 
DB $F8, $01, $08, $01, $68 
DB $00, $00, $08, $02, $68 
DB $08, $00, $08, $03, $68 
DB $F0, $01, $00, $04, $68 
DB $F0, $01, $F0, $05, $68 
DB $F8, $01, $F0, $06, $68 
DB $08, $00, $F0, $07, $68 

;bebf	
TM_193:
DW $0001  
DB $F8, $01, $F8, $00, $30 

;bec6		;unused?
DW $0002  
DB $00, $C2, $00, $08, $E8 
DB $F0, $C3, $F0, $08, $28 

;bed2		;unused?
DW $0004  
DB $F0, $C3, $F0, $08, $28 
DB $00, $C2, $F0, $0A, $68 
DB $00, $C2, $00, $08, $E8 
DB $F0, $C3, $00, $0A, $A8 

;bee8		;unused?
DW $0002  
DB $F0, $C3, $00, $08, $E8 
DB $00, $C2, $F0, $08, $28 

;bef4		;unused?
DW $0004  
DB $00, $C2, $00, $08, $68 
DB $F0, $C3, $F0, $08, $A8 
DB $F0, $C3, $00, $0A, $A8 
DB $00, $C2, $F0, $0A, $68 

;bf0a		;unused?
DW $0002  
DB $00, $C2, $00, $08, $E8 
DB $F0, $C3, $F0, $08, $28 

;bf16		;unused?
DW $0004  
DB $00, $C2, $F0, $08, $68 
DB $F0, $C3, $00, $08, $A8 
DB $F0, $C3, $F0, $0A, $28 
DB $00, $C2, $00, $0A, $E8 

;bf2c		;unused?
DW $0002  
DB $F0, $C3, $00, $08, $E8 
DB $00, $C2, $F0, $08, $28 

;bf38		;unused?
DW $0004  
DB $F0, $C3, $00, $08, $A8 
DB $00, $C2, $F0, $08, $68 
DB $00, $C2, $00, $0A, $68 
DB $F0, $C3, $F0, $0A, $A8 

;bf4e		;unused?
DW $0004  
DB $00, $C2, $00, $08, $E8 
DB $F0, $C3, $F0, $08, $28 
DB $F0, $C3, $00, $08, $A8 
DB $00, $C2, $F0, $08, $68 

;bf64		;unused?
DW $0004  
DB $F0, $C3, $00, $08, $A8 
DB $00, $C2, $F0, $08, $68 
DB $00, $C2, $00, $0A, $E8 
DB $F0, $C3, $F0, $0A, $28 

;bf7a		;unused?
DW $0004  
DB $F0, $C3, $00, $08, $A8 
DB $00, $C2, $F0, $08, $68 
DB $00, $C2, $00, $08, $E8 
DB $F0, $C3, $F0, $08, $28 

;bf90		;unused?
DW $0004  
DB $00, $C2, $00, $08, $E8 
DB $F0, $C3, $F0, $08, $28 
DB $00, $C2, $F0, $0A, $68 
DB $F0, $C3, $00, $0A, $A8 

;bfa6		;unused?
DW $0004  
DB $00, $C2, $00, $08, $E8 
DB $F0, $C3, $F0, $08, $28 
DB $00, $C2, $F0, $08, $68 
DB $F0, $C3, $00, $08, $A8 

;bfbc		;unused?
DW $0004  
DB $00, $C2, $F0, $08, $68 
DB $F0, $C3, $00, $08, $A8 
DB $00, $C2, $00, $0A, $E8 
DB $F0, $C3, $F0, $0A, $28 

;bfd2		;unused?
DW $0004  
DB $F0, $C3, $00, $08, $A8 
DB $00, $C2, $F0, $08, $68 
DB $F0, $C3, $F0, $08, $28 
DB $00, $C2, $00, $08, $E8 

;bfe8		;unused?
DW $0004  
DB $00, $C2, $00, $08, $E8 
DB $F0, $C3, $F0, $08, $28 
DB $00, $C2, $F0, $0A, $68 
DB $F0, $C3, $00, $0A, $A8 

;bffe		;unused?
DW $0004  
DB $F0, $C3, $F0, $08, $28 
DB $00, $C2, $00, $08, $E8 
DB $F0, $C3, $00, $0A, $A8 
DB $00, $C2, $F0, $0A, $68 

;c014		;unused?
DW $0002  
DB $F0, $C3, $00, $08, $A8 
DB $00, $C2, $F0, $08, $68 

;c020		;unused?
DW $0004  
DB $00, $C2, $F0, $08, $68 
DB $F0, $C3, $F0, $0A, $28 
DB $F0, $C3, $00, $08, $A8 
DB $00, $C2, $00, $0A, $E8 

;c036		;unused?
DW $0002  
DB $00, $C2, $00, $08, $A8 
DB $F0, $C3, $F0, $08, $68 

;c042		;unused?
DW $0004  
DB $F0, $C3, $00, $08, $28 
DB $00, $C2, $F0, $08, $E8 
DB $00, $C2, $00, $0A, $E8 
DB $F0, $C3, $F0, $0A, $28 

;c058		;unused?
DW $0002  
DB $F0, $C3, $00, $08, $A8 
DB $00, $C2, $F0, $08, $68 

;c064		;unused?
DW $0004  
DB $F0, $C3, $F0, $08, $28 
DB $00, $C2, $00, $08, $E8 
DB $00, $C2, $F0, $0A, $68 
DB $F0, $C3, $00, $0A, $A8 

;c078		;unused?
DW $0002  
DB $00, $C2, $00, $08, $A8 
DB $F0, $C3, $F0, $08, $68 

;c084		;unused?
DW $0004  
DB $00, $C2, $00, $08, $E8 
DB $F0, $C3, $F0, $08, $28 
DB $F0, $C3, $00, $0A, $28 
DB $00, $C2, $F0, $0A, $E8 

;c09a		;unused?
DW $0004  
DB $F0, $C3, $00, $08, $A8 
DB $00, $C2, $F0, $08, $68 
DB $00, $C2, $00, $08, $E8 
DB $F0, $C3, $F0, $08, $28 

;c0b0		;unused?
DW $0004  
DB $00, $C2, $00, $08, $E8 
DB $F0, $C3, $F0, $08, $28 
DB $F0, $C3, $00, $0A, $A8 
DB $00, $C2, $F0, $0A, $68 

;c0c6		;unused?
DW $0004  
DB $00, $C2, $00, $08, $E8 
DB $F0, $C3, $F0, $08, $28 
DB $F0, $C3, $00, $08, $A8 
DB $00, $C2, $F0, $08, $68 

;c0dc		;unused?
DW $0004  
DB $F0, $C3, $00, $08, $A8 
DB $00, $C2, $F0, $08, $68 
DB $F0, $C3, $F0, $0A, $28 
DB $00, $C2, $00, $0A, $E8 

;c0f2		;unused?
DW $0004  
DB $F0, $C3, $00, $08, $A8 
DB $00, $C2, $F0, $08, $68 
DB $F0, $C3, $F0, $08, $28 
DB $00, $C2, $00, $08, $E8 

;c108		;unused?
DW $0004  
DB $F0, $C3, $F0, $08, $28 
DB $00, $C2, $00, $08, $E8 
DB $F0, $C3, $00, $0A, $A8 
DB $00, $C2, $F0, $0A, $68 

;c11e		;unused?
DW $0004  
DB $00, $C2, $00, $08, $E8 
DB $F0, $C3, $F0, $08, $28 
DB $00, $C2, $F0, $08, $68 
DB $F0, $C3, $00, $08, $A8 

;c134		;unused?
DW $0004  
DB $F0, $C3, $00, $08, $A8 
DB $00, $C2, $F0, $08, $68 
DB $F0, $C3, $F0, $0A, $28 
DB $00, $C2, $00, $0A, $E8 

;c14a		;unused?
DW $0004  
DB $F0, $C3, $F0, $08, $28 
DB $00, $C2, $00, $08, $E8 
DB $F0, $C3, $00, $0A, $A8 
DB $00, $C2, $F0, $0A, $68 

;c162	
TM_194:
DW $0005  
DB $00, $00, $F8, $06, $28 
DB $F8, $01, $F8, $07, $28 
DB $F8, $C3, $08, $00, $68 
DB $F8, $C3, $F8, $02, $68 
DB $F8, $C3, $E8, $04, $28 

;c17d	
TM_195:
DW $0005  
DB $00, $00, $F8, $06, $28 
DB $F8, $01, $F8, $07, $28 
DB $F8, $C3, $08, $00, $28 
DB $F8, $C3, $F8, $02, $28 
DB $F8, $C3, $E8, $04, $28 

;c198	
TM_196:
DW $0007  
DB $F8, $C3, $EC, $00, $2C 
DB $00, $00, $0C, $02, $2C 
DB $F8, $01, $0C, $03, $2C 
DB $00, $00, $04, $04, $2C 
DB $F8, $01, $04, $05, $2C 
DB $00, $00, $FC, $06, $2C 
DB $F8, $01, $FC, $07, $2C 

;c1bd	
TM_197:
DW $0007  
DB $F8, $C3, $EB, $00, $2C 
DB $00, $00, $0B, $02, $2C 
DB $F8, $01, $0B, $03, $2C 
DB $00, $00, $03, $04, $2C 
DB $F8, $01, $03, $05, $2C 
DB $00, $00, $FB, $06, $2C 
DB $F8, $01, $FB, $07, $2C 

;c1e2	
TM_198:
DW $0007  
DB $F8, $C3, $EA, $00, $2C 
DB $00, $00, $0A, $02, $2C 
DB $F8, $01, $0A, $03, $2C 
DB $00, $00, $02, $04, $2C 
DB $F8, $01, $02, $05, $2C 
DB $00, $00, $FA, $06, $2C 
DB $F8, $01, $FA, $07, $2C 

;c207	
TM_199:
DW $0007  
DB $F8, $C3, $EC, $00, $6C 
DB $F8, $01, $0C, $02, $6C 
DB $00, $00, $0C, $03, $6C 
DB $F8, $01, $04, $04, $6C 
DB $00, $00, $04, $05, $6C 
DB $F8, $01, $FC, $06, $6C 
DB $00, $00, $FC, $07, $6C 

;c22c	
TM_19A:
DW $0007  
DB $F8, $C3, $EB, $00, $6C 
DB $F8, $01, $0B, $02, $6C 
DB $00, $00, $0B, $03, $6C 
DB $F8, $01, $03, $04, $6C 
DB $00, $00, $03, $05, $6C 
DB $F8, $01, $FB, $06, $6C 
DB $00, $00, $FB, $07, $6C 

;c251	
TM_19B:
DW $0007  
DB $F8, $C3, $EA, $00, $6C 
DB $F8, $01, $0A, $02, $6C 
DB $00, $00, $0A, $03, $6C 
DB $F8, $01, $02, $04, $6C 
DB $00, $00, $02, $05, $6C 
DB $F8, $01, $FA, $06, $6C 
DB $00, $00, $FA, $07, $6C 

;c276	
TM_19C:
DW $0004  
DB $00, $C2, $00, $08, $FC 
DB $F0, $C3, $00, $08, $BC 
DB $00, $C2, $F0, $08, $7C 
DB $F0, $C3, $F0, $08, $3C 

;c28c	
TM_19D:
DW $0010  
DB $00, $C2, $00, $08, $FC 
DB $10, $C2, $00, $0A, $FC 
DB $00, $C2, $10, $0C, $FC 
DB $10, $C2, $10, $0E, $FC 
DB $F0, $C3, $00, $08, $BC 
DB $E0, $C3, $00, $0A, $BC 
DB $F0, $C3, $10, $0C, $BC 
DB $E0, $C3, $10, $0E, $BC 
DB $00, $C2, $F0, $08, $7C 
DB $10, $C2, $F0, $0A, $7C 
DB $00, $C2, $E0, $0C, $7C 
DB $10, $C2, $E0, $0E, $7C 
DB $E0, $C3, $E0, $0E, $3C 
DB $E0, $C3, $F0, $0A, $3C 
DB $F0, $C3, $E0, $0C, $3C 
DB $F0, $C3, $F0, $08, $3C 

;c2de	
TM_19E:
DW $0010  
DB $00, $C2, $00, $08, $FC 
DB $10, $C2, $00, $0A, $FC 
DB $00, $C2, $10, $0C, $FC 
DB $10, $C2, $10, $0E, $FC 
DB $F0, $C3, $00, $08, $BC 
DB $E0, $C3, $00, $0A, $BC 
DB $F0, $C3, $10, $0C, $BC 
DB $E0, $C3, $10, $0E, $BC 
DB $00, $C2, $F0, $08, $7C 
DB $10, $C2, $F0, $0A, $7C 
DB $00, $C2, $E0, $0C, $7C 
DB $10, $C2, $E0, $0E, $7C 
DB $F0, $C3, $F0, $08, $3C 
DB $E0, $C3, $F0, $0A, $3C 
DB $F0, $C3, $E0, $0C, $3C 
DB $E0, $C3, $E0, $0E, $3C 

;c330	
TM_19F:
DW $0004  
DB $00, $C2, $F0, $08, $28 
DB $F0, $C3, $00, $0A, $28 
DB $F8, $C3, $00, $0C, $28 
DB $F8, $C3, $F0, $0E, $28 

;c346	
TM_1A0:
DW $000A  
DB $01, $C2, $04, $08, $28 
DB $F1, $C3, $F4, $0A, $28 
DB $F9, $01, $0C, $0C, $28 
DB $F1, $01, $EC, $0D, $28 
DB $01, $00, $EC, $0E, $28 
DB $F9, $01, $EC, $0F, $28 
DB $09, $00, $FC, $1C, $28 
DB $01, $00, $FC, $1D, $28 
DB $01, $00, $F4, $1E, $28 
DB $F9, $01, $04, $1F, $28 

;c37a	
TM_1A1:
DW $0004  
DB $00, $C2, $00, $08, $28 
DB $F0, $C3, $F0, $0A, $28 
DB $F0, $C3, $F8, $0C, $28 
DB $00, $C2, $F8, $0E, $28 

;c390	
TM_1A2:
DW $000A  
DB $FC, $01, $F0, $0C, $E8 
DB $F4, $01, $F8, $0D, $E8 
DB $FC, $01, $F8, $0E, $E8 
DB $04, $00, $00, $0F, $E8 
DB $0C, $00, $00, $1C, $E8 
DB $EC, $01, $F8, $1D, $E8 
DB $EC, $01, $00, $1E, $E8 
DB $EC, $01, $08, $1F, $E8 
DB $F4, $C3, $00, $08, $E8 
DB $04, $C2, $F0, $0A, $E8 

;c3c4	
TM_1A3:
DW $0004  
DB $F0, $C3, $00, $08, $E8 
DB $00, $C2, $F0, $0A, $E8 
DB $F8, $C3, $F0, $0C, $E8 
DB $F8, $C3, $00, $0E, $E8 

;c3da	
TM_1A4:
DW $000A  
DB $F0, $01, $FC, $0C, $E8 
DB $F8, $01, $FC, $0D, $E8 
DB $F8, $01, $04, $0E, $E8 
DB $08, $00, $0C, $0F, $E8 
DB $00, $00, $EC, $1C, $E8 
DB $00, $00, $F4, $1D, $E8 
DB $F8, $01, $0C, $1E, $E8 
DB $00, $00, $0C, $1F, $E8 
DB $F0, $C3, $EC, $08, $E8 
DB $00, $C2, $FC, $0A, $E8 

;c40e	
TM_1A5:
DW $0004  
DB $F0, $C3, $F0, $08, $E8 
DB $00, $C2, $00, $0A, $E8 
DB $00, $C2, $F8, $0C, $E8 
DB $F0, $C3, $F8, $0E, $E8 

;c424	
TM_1A6:
DW $000A  
DB $FC, $01, $00, $0C, $28 
DB $FC, $01, $08, $0D, $28 
DB $04, $00, $00, $0E, $28 
DB $F4, $01, $F8, $0F, $28 
DB $EC, $01, $F8, $1C, $28 
DB $0C, $00, $00, $1D, $28 
DB $0C, $00, $F8, $1E, $28 
DB $0C, $00, $F0, $1F, $28 
DB $FC, $C3, $F0, $08, $28 
DB $EC, $C3, $00, $0A, $28 

;c458	
TM_1A7:
DW $0004  
DB $F0, $C3, $F0, $08, $68 
DB $00, $C2, $00, $0A, $68 
DB $F8, $C3, $00, $0C, $68 
DB $F8, $C3, $F0, $0E, $68 

;c46e	
TM_1A8:
DW $000A  
DB $EF, $C3, $04, $08, $68 
DB $FF, $C3, $F4, $0A, $68 
DB $FF, $01, $0C, $0C, $68 
DB $07, $00, $EC, $0D, $68 
DB $F7, $01, $EC, $0E, $68 
DB $FF, $01, $EC, $0F, $68 
DB $EF, $01, $FC, $1C, $68 
DB $F7, $01, $FC, $1D, $68 
DB $F7, $01, $F4, $1E, $68 
DB $FF, $01, $04, $1F, $68 

;c4a2	
TM_1A9:
DW $0004  
DB $F0, $C3, $00, $08, $68 
DB $00, $C2, $F0, $0A, $68 
DB $00, $C2, $F8, $0C, $68 
DB $F0, $C3, $F8, $0E, $68 

;c4b8	
TM_1AA:
DW $000A  
DB $FC, $01, $F0, $0C, $A8 
DB $04, $00, $F8, $0D, $A8 
DB $FC, $01, $F8, $0E, $A8 
DB $F4, $01, $00, $0F, $A8 
DB $EC, $01, $00, $1C, $A8 
DB $0C, $00, $F8, $1D, $A8 
DB $0C, $00, $00, $1E, $A8 
DB $0C, $00, $08, $1F, $A8 
DB $FC, $C3, $00, $08, $A8 
DB $EC, $C3, $F0, $0A, $A8 

;c4ec	
TM_1AB:
DW $0004  
DB $00, $C2, $00, $08, $A8 
DB $F0, $C3, $F0, $0A, $A8 
DB $F8, $C3, $F0, $0C, $A8 
DB $F8, $C3, $00, $0E, $A8 

;c502	
TM_1AC:
DW $000A  
DB $08, $00, $FC, $0C, $A8 
DB $00, $00, $FC, $0D, $A8 
DB $00, $00, $04, $0E, $A8 
DB $F0, $01, $0C, $0F, $A8 
DB $F8, $01, $EC, $1C, $A8 
DB $F8, $01, $F4, $1D, $A8 
DB $00, $00, $0C, $1E, $A8 
DB $F8, $01, $0C, $1F, $A8 
DB $00, $C2, $EC, $08, $A8 
DB $F0, $C3, $FC, $0A, $A8 

;c536	
TM_1AD:
DW $0004  
DB $00, $C2, $F0, $08, $A8 
DB $F0, $C3, $00, $0A, $A8 
DB $F0, $C3, $F8, $0C, $A8 
DB $00, $C2, $F8, $0E, $A8 

;c54c	
TM_1AE:
DW $000A  
DB $FC, $01, $00, $0C, $68 
DB $FC, $01, $08, $0D, $68 
DB $F4, $01, $00, $0E, $68 
DB $04, $00, $F8, $0F, $68 
DB $0C, $00, $F8, $1C, $68 
DB $EC, $01, $00, $1D, $68 
DB $EC, $01, $F8, $1E, $68 
DB $EC, $01, $F0, $1F, $68 
DB $F4, $C3, $F0, $08, $68 
DB $04, $C2, $00, $0A, $68 

;c580	
TM_1AF:
DW $0009  
DB $00, $00, $10, $41, $28 
DB $F8, $01, $10, $40, $28 
DB $08, $00, $10, $42, $28 
DB $08, $00, $08, $32, $28 
DB $08, $00, $00, $22, $28 
DB $08, $00, $F8, $12, $28 
DB $08, $00, $F0, $02, $28 
DB $F8, $C3, $00, $20, $28 
DB $F8, $C3, $F0, $00, $28 

;c5af	
TM_1B0:
DW $0016  
DB $FD, $01, $F0, $1F, $28 
DB $03, $00, $F6, $0F, $28 
DB $FB, $01, $F9, $0F, $28 
DB $F7, $01, $F7, $5F, $28 
DB $07, $00, $0B, $4E, $28 
DB $FF, $01, $0F, $5F, $28 
DB $F7, $01, $F2, $7F, $28 
DB $F9, $01, $EF, $6C, $28 
DB $F9, $01, $EC, $2F, $28 
DB $FD, $01, $E9, $1F, $28 
DB $06, $00, $F2, $08, $28 
DB $F9, $01, $05, $58, $28 
DB $02, $00, $FD, $38, $28 
DB $01, $00, $06, $4B, $28 
DB $F8, $01, $0A, $43, $2E 
DB $F8, $01, $02, $33, $2E 
DB $F8, $01, $FA, $23, $2E 
DB $F8, $01, $F2, $13, $2E 
DB $F8, $01, $EA, $03, $2E 
DB $00, $C2, $0A, $44, $2E 
DB $00, $C2, $FA, $24, $2E 
DB $00, $C2, $EA, $04, $2E 

;c61f	
TM_1B1:
DW $001A  
DB $03, $00, $E7, $1F, $28 
DB $01, $00, $11, $4F, $28 
DB $FF, $01, $0A, $4E, $28 
DB $F9, $01, $07, $83, $28 
DB $00, $00, $04, $83, $28 
DB $06, $00, $F0, $83, $28 
DB $0C, $00, $EB, $08, $28 
DB $07, $00, $07, $58, $68 
DB $F7, $01, $FF, $4B, $28 
DB $F3, $01, $F6, $38, $28 
DB $F3, $01, $EE, $7F, $28 
DB $F6, $01, $E9, $6C, $28 
DB $FB, $01, $E7, $2F, $28 
DB $F8, $01, $F1, $3F, $28 
DB $F5, $01, $07, $93, $28 
DB $F8, $01, $0E, $73, $28 
DB $06, $00, $0F, $83, $28 
DB $09, $00, $01, $4F, $28 
DB $08, $00, $F8, $5F, $28 
DB $08, $00, $10, $68, $2E 
DB $00, $00, $10, $67, $2E 
DB $08, $00, $F0, $28, $2E 
DB $08, $00, $E8, $18, $2E 
DB $F8, $C3, $E0, $06, $2E 
DB $F8, $C3, $00, $46, $2E 
DB $F8, $C3, $F0, $26, $2E 

;c6a3	
TM_1B2:
DW $0018  
DB $0B, $00, $DD, $3F, $28 
DB $01, $00, $17, $4F, $28 
DB $F7, $01, $E0, $2F, $28 
DB $F1, $01, $E1, $6C, $28 
DB $0F, $00, $E6, $1F, $28 
DB $EE, $01, $FA, $6F, $28 
DB $ED, $01, $F2, $4E, $28 
DB $EE, $01, $07, $93, $28 
DB $F1, $01, $10, $73, $28 
DB $0D, $00, $10, $83, $28 
DB $0C, $00, $02, $6F, $28 
DB $10, $00, $FB, $4F, $28 
DB $0A, $00, $F1, $5F, $28 
DB $ED, $01, $E8, $7F, $28 
DB $F3, $01, $ED, $3F, $28 
DB $08, $00, $FA, $3B, $2E 
DB $08, $00, $F2, $2B, $2E 
DB $08, $00, $12, $6B, $2E 
DB $00, $00, $12, $6A, $2E 
DB $08, $00, $EA, $1B, $2E 
DB $08, $00, $E2, $0B, $2E 
DB $F8, $C3, $02, $49, $2E 
DB $F8, $C3, $F2, $29, $2E 
DB $F8, $C3, $E2, $09, $2E 

;c71d	
TM_1B3:
DW $0019  
DB $0C, $00, $D8, $3F, $28 
DB $03, $00, $1E, $4F, $28 
DB $F3, $01, $DA, $2F, $28 
DB $E9, $01, $DE, $6C, $28 
DB $11, $00, $15, $83, $28 
DB $14, $00, $04, $6F, $28 
DB $15, $00, $F2, $5F, $28 
DB $12, $00, $E1, $1F, $28 
DB $E5, $01, $FE, $6F, $28 
DB $E3, $01, $EA, $7F, $28 
DB $18, $00, $FC, $4F, $28 
DB $F0, $01, $14, $73, $28 
DB $E8, $01, $0C, $93, $28 
DB $E8, $01, $F4, $4E, $28 
DB $F0, $01, $EC, $3F, $28 
DB $00, $00, $14, $6D, $2E 
DB $08, $00, $14, $6E, $2E 
DB $08, $00, $0C, $5E, $2E 
DB $08, $00, $FC, $3E, $2E 
DB $08, $00, $F4, $2E, $2E 
DB $08, $00, $EC, $1E, $2E 
DB $08, $00, $E4, $0E, $2E 
DB $F8, $C3, $04, $4C, $2E 
DB $F8, $C3, $F4, $2C, $2E 
DB $F8, $C3, $E4, $0C, $2E 

;c79c	
TM_1B4:
DW $0019  
DB $DD, $01, $E1, $7F, $28 
DB $E0, $01, $DC, $7F, $28 
DB $03, $00, $25, $73, $28 
DB $EA, $01, $D3, $2F, $28 
DB $1D, $00, $FB, $73, $28 
DB $DF, $01, $FF, $83, $68 
DB $19, $00, $08, $6F, $28 
DB $E2, $01, $12, $93, $28 
DB $EF, $01, $19, $73, $28 
DB $13, $00, $19, $83, $28 
DB $18, $00, $F0, $5F, $28 
DB $D9, $01, $ED, $7F, $28 
DB $E4, $01, $F4, $4E, $28 
DB $18, $00, $DC, $1F, $28 
DB $E8, $01, $EC, $3F, $68 
DB $00, $00, $14, $74, $2E 
DB $00, $00, $0C, $64, $2E 
DB $F8, $01, $0C, $63, $2E 
DB $08, $00, $FC, $82, $2E 
DB $08, $00, $EC, $62, $2E 
DB $08, $00, $E4, $52, $2E 
DB $00, $00, $E4, $51, $2E 
DB $F8, $01, $E4, $50, $2E 
DB $F8, $C3, $FC, $80, $2E 
DB $F8, $C3, $EC, $60, $2E 

;c81b	
TM_1B5:
DW $0008  
DB $0E, $00, $F4, $9C, $2E 
DB $0E, $00, $EC, $8C, $2E 
DB $FE, $01, $14, $99, $2E 
DB $F6, $C3, $04, $78, $2E 
DB $F6, $01, $FC, $94, $2E 
DB $F6, $01, $F4, $84, $2E 
DB $FE, $C3, $F4, $85, $2E 
DB $FE, $C3, $E4, $65, $2E 

;c845	
TM_1B6:
DW $000B  
DB $F6, $01, $F4, $98, $2E 
DB $06, $00, $FC, $96, $2E 
DB $FE, $01, $FC, $95, $2E 
DB $06, $00, $E4, $7B, $2E 
DB $FE, $01, $E4, $7A, $2E 
DB $0E, $00, $F4, $9C, $2E 
DB $0E, $00, $EC, $8C, $2E 
DB $FE, $C3, $EC, $8A, $2E 
DB $FE, $01, $14, $99, $2E 
DB $F6, $C3, $04, $78, $2E 
DB $F6, $01, $FC, $94, $2E 

;c87e	
TM_1B7:
DW $000B  
DB $FE, $01, $FC, $95, $2E 
DB $06, $00, $FC, $96, $2E 
DB $F6, $01, $F4, $7C, $2E 
DB $06, $00, $E4, $7E, $2E 
DB $FE, $01, $E4, $7D, $2E 
DB $0E, $00, $F4, $9F, $2E 
DB $0E, $00, $EC, $8F, $2E 
DB $FE, $C3, $EC, $8D, $2E 
DB $FE, $01, $14, $99, $2E 
DB $F6, $C3, $04, $78, $2E 
DB $F6, $01, $FC, $94, $2E 

;c8b7	
TM_1B8:
DW $0009  
DB $F8, $01, $10, $41, $68 
DB $00, $00, $10, $40, $68 
DB $F0, $01, $10, $42, $68 
DB $F0, $01, $08, $32, $68 
DB $F0, $01, $00, $22, $68 
DB $F0, $01, $F8, $12, $68 
DB $F0, $01, $F0, $02, $68 
DB $F8, $C3, $00, $20, $68 
DB $F8, $C3, $F0, $00, $68 

;c8e6	
TM_1B9:
DW $0016  
DB $FB, $01, $F0, $1F, $68 
DB $F5, $01, $F6, $0F, $68 
DB $FD, $01, $F9, $0F, $68 
DB $01, $00, $F7, $5F, $68 
DB $F1, $01, $0B, $4E, $68 
DB $F9, $01, $0F, $5F, $68 
DB $01, $00, $F2, $7F, $68 
DB $FF, $01, $EF, $6C, $68 
DB $FF, $01, $EC, $2F, $68 
DB $FB, $01, $E9, $1F, $68 
DB $F2, $01, $F2, $08, $68 
DB $FF, $01, $05, $58, $68 
DB $F6, $01, $FD, $38, $68 
DB $F7, $01, $06, $4B, $68 
DB $00, $00, $0A, $43, $6E 
DB $00, $00, $02, $33, $6E 
DB $00, $00, $FA, $23, $6E 
DB $00, $00, $F2, $13, $6E 
DB $00, $00, $EA, $03, $6E 
DB $F0, $C3, $0A, $44, $6E 
DB $F0, $C3, $FA, $24, $6E 
DB $F0, $C3, $EA, $04, $6E 

;c956	
TM_1BA:
DW $001A  
DB $F5, $01, $E7, $1F, $68 
DB $F7, $01, $11, $4F, $68 
DB $F9, $01, $0A, $4E, $68 
DB $FF, $01, $07, $83, $68 
DB $F8, $01, $04, $83, $68 
DB $F2, $01, $F0, $83, $68 
DB $EC, $01, $EB, $08, $68 
DB $F1, $01, $07, $58, $28 
DB $01, $00, $FF, $4B, $68 
DB $05, $00, $F6, $38, $68 
DB $05, $00, $EE, $7F, $68 
DB $02, $00, $E9, $6C, $68 
DB $FD, $01, $E7, $2F, $68 
DB $00, $00, $F1, $3F, $68 
DB $03, $00, $07, $93, $68 
DB $00, $00, $0E, $73, $68 
DB $F2, $01, $0F, $83, $68 
DB $EF, $01, $01, $4F, $68 
DB $F0, $01, $F8, $5F, $68 
DB $F0, $01, $10, $68, $6E 
DB $F8, $01, $10, $67, $6E 
DB $F0, $01, $F0, $28, $6E 
DB $F0, $01, $E8, $18, $6E 
DB $F8, $C3, $E0, $06, $6E 
DB $F8, $C3, $00, $46, $6E 
DB $F8, $C3, $F0, $26, $6E 

;c9da	
TM_1BB:
DW $0018  
DB $ED, $01, $DD, $3F, $68 
DB $F7, $01, $17, $4F, $68 
DB $01, $00, $E0, $2F, $68 
DB $07, $00, $E1, $6C, $68 
DB $E9, $01, $E6, $1F, $68 
DB $0A, $00, $FA, $6F, $68 
DB $0B, $00, $F2, $4E, $68 
DB $0A, $00, $07, $93, $68 
DB $07, $00, $10, $73, $68 
DB $EB, $01, $10, $83, $68 
DB $EC, $01, $02, $6F, $68 
DB $E8, $01, $FB, $4F, $68 
DB $EE, $01, $F1, $5F, $68 
DB $0B, $00, $E8, $7F, $68 
DB $05, $00, $ED, $3F, $68 
DB $F0, $01, $FA, $3B, $6E 
DB $F0, $01, $F2, $2B, $6E 
DB $F0, $01, $12, $6B, $6E 
DB $F8, $01, $12, $6A, $6E 
DB $F0, $01, $EA, $1B, $6E 
DB $F0, $01, $E2, $0B, $6E 
DB $F8, $C3, $02, $49, $6E 
DB $F8, $C3, $F2, $29, $6E 
DB $F8, $C3, $E2, $09, $6E 

;ca54	
TM_1BC:
DW $0019  
DB $EC, $01, $D8, $3F, $68 
DB $F5, $01, $1E, $4F, $68 
DB $05, $00, $DA, $2F, $68 
DB $0F, $00, $DE, $6C, $68 
DB $E7, $01, $15, $83, $68 
DB $E4, $01, $04, $6F, $68 
DB $E3, $01, $F2, $5F, $68 
DB $E6, $01, $E1, $1F, $68 
DB $13, $00, $FE, $6F, $68 
DB $15, $00, $EA, $7F, $68 
DB $E0, $01, $FC, $4F, $68 
DB $08, $00, $14, $73, $68 
DB $10, $00, $0C, $93, $68 
DB $10, $00, $F4, $4E, $68 
DB $08, $00, $EC, $3F, $68 
DB $F8, $01, $14, $6D, $6E 
DB $F0, $01, $14, $6E, $6E 
DB $F0, $01, $0C, $5E, $6E 
DB $F0, $01, $FC, $3E, $6E 
DB $F0, $01, $F4, $2E, $6E 
DB $F0, $01, $EC, $1E, $6E 
DB $F0, $01, $E4, $0E, $6E 
DB $F8, $C3, $04, $4C, $6E 
DB $F8, $C3, $F4, $2C, $6E 
DB $F8, $C3, $E4, $0C, $6E 

;cad3	
TM_1BD:
DW $0019  
DB $1B, $00, $E1, $7F, $68 
DB $18, $00, $DC, $7F, $68 
DB $F5, $01, $25, $73, $68 
DB $0E, $00, $D3, $2F, $68 
DB $DB, $01, $FB, $73, $68 
DB $19, $00, $FF, $83, $28 
DB $DF, $01, $08, $6F, $68 
DB $16, $00, $12, $93, $68 
DB $09, $00, $19, $73, $68 
DB $E5, $01, $19, $83, $68 
DB $E0, $01, $F0, $5F, $68 
DB $1F, $00, $ED, $7F, $68 
DB $14, $00, $F4, $4E, $68 
DB $E0, $01, $DC, $1F, $68 
DB $10, $00, $EC, $3F, $28 
DB $F8, $01, $14, $74, $6E 
DB $F8, $01, $0C, $64, $6E 
DB $00, $00, $0C, $63, $6E 
DB $F0, $01, $FC, $82, $6E 
DB $F0, $01, $EC, $62, $6E 
DB $F0, $01, $E4, $52, $6E 
DB $F8, $01, $E4, $51, $6E 
DB $00, $00, $E4, $50, $6E 
DB $F8, $C3, $FC, $80, $6E 
DB $F8, $C3, $EC, $60, $6E 

;cb52	
TM_1BE:
DW $0008  
DB $EA, $01, $F4, $9C, $6E 
DB $EA, $01, $EC, $8C, $6E 
DB $FA, $01, $14, $99, $6E 
DB $FA, $C3, $04, $78, $6E 
DB $02, $00, $FC, $94, $6E 
DB $02, $00, $F4, $84, $6E 
DB $F2, $C3, $F4, $85, $6E 
DB $F2, $C3, $E4, $65, $6E 

;cb7c	
TM_1BF:
DW $000B  
DB $02, $00, $F4, $98, $6E 
DB $F2, $01, $FC, $96, $6E 
DB $FA, $01, $FC, $95, $6E 
DB $F2, $01, $E4, $7B, $6E 
DB $FA, $01, $E4, $7A, $6E 
DB $EA, $01, $F4, $9C, $6E 
DB $EA, $01, $EC, $8C, $6E 
DB $F2, $C3, $EC, $8A, $6E 
DB $FA, $01, $14, $99, $6E 
DB $FA, $C3, $04, $78, $6E 
DB $02, $00, $FC, $94, $6E 

;cbb5	
TM_1C0:
DW $000B  
DB $FA, $01, $FC, $95, $6E 
DB $F2, $01, $FC, $96, $6E 
DB $02, $00, $F4, $7C, $6E 
DB $F2, $01, $E4, $7E, $6E 
DB $FA, $01, $E4, $7D, $6E 
DB $EA, $01, $F4, $9F, $6E 
DB $EA, $01, $EC, $8F, $6E 
DB $F2, $C3, $EC, $8D, $6E 
DB $FA, $01, $14, $99, $6E 
DB $FA, $C3, $04, $78, $6E 
DB $02, $00, $FC, $94, $6E



;DMA TABLES
org $92CBEE
UT_DMA0:
DL $9E8000 : DW $0080, $0080  
DL $9E8100 : DW $0080, $0080  
DL $9E8200 : DW $00A0, $0080  
DL $9E8320 : DW $00A0, $0080  
DL $9E8440 : DW $0080, $0080  
DL $9E8540 : DW $00C0, $00C0  
DL $9E86C0 : DW $0080, $0080  
DL $9E87C0 : DW $0080, $0080  
DL $9E88C0 : DW $00C0, $00C0  
DL $9E8A40 : DW $00C0, $00C0  
DL $9E8BC0 : DW $0080, $0080  
DL $9E8CC0 : DW $00A0, $0080  
DL $9E8DE0 : DW $00E0, $0040  
DL $9E8F00 : DW $00E0, $0040  
DL $9E9020 : DW $00E0, $0080  
DL $9E9180 : DW $00E0, $0080  
DL $9E92E0 : DW $00C0, $0040  
DL $9E93E0 : DW $00C0, $0040  
DL $9E94E0 : DW $00C0, $0080  
DL $9E9620 : DW $00C0, $0080  
DL $9E9760 : DW $00A0, $0080  
DL $9E9880 : DW $00C0, $00C0  
DL $9E9A00 : DW $00C0, $0040  
DL $9E9B00 : DW $00C0, $0040  
DL $9E9C00 : DW $00A0, $0080  
DL $9E9D20 : DW $00A0, $0080  
DL $9E9E40 : DW $00C0, $0040  
DL $9E9F40 : DW $00E0, $0040  
DL $9EA060 : DW $0100, $00C0  
DL $9EA220 : DW $0100, $00C0  
DL $9EA3E0 : DW $0100, $0040  
DL $9EA520 : DW $0100, $0040 

;$92CCCE 
UT_DMA1:
DL $9EA660 : DW $00C0, $0080  
DL $9EA7A0 : DW $00C0, $0080  
DL $9EA8E0 : DW $00E0, $00C0  
DL $9EAA80 : DW $0100, $00C0  
DL $9EAC40 : DW $0020, $0000  
DL $9EAC60 : DW $0040, $0040  
DL $9EACE0 : DW $00C0, $0080  
DL $9EAE20 : DW $00C0, $0080  
DL $9EAF60 : DW $00E0, $0040  
DL $9EB080 : DW $00C0, $0040  
DL $9EB180 : DW $00E0, $00C0  
DL $9EB320 : DW $0100, $0080  
DL $9EB4A0 : DW $0100, $0080  
DL $9EB620 : DW $0080, $0080  
DL $9EB720 : DW $0080, $0080  
DL $9EB820 : DW $0080, $0080  
DL $9EB920 : DW $0080, $0080  
DL $9EBA20 : DW $0080, $0080  
DL $9EBB20 : DW $0080, $0080  
DL $9EBC20 : DW $0080, $0080  
DL $9EBD20 : DW $0100, $00C0  
DL $9EBEE0 : DW $0100, $00C0  
DL $9EC0A0 : DW $0020, $0000  
DL $9EC0C0 : DW $0020, $0000  
DL $9EC0E0 : DW $00E0, $0040  
DL $9EC200 : DW $00E0, $0040  
DL $9EC320 : DW $00C0, $0080  
DL $9EC460 : DW $00C0, $0080  
DL $9EC5A0 : DW $00C0, $0080  
DL $9EC6E0 : DW $00C0, $0080 

;$92CDA0
UT_DMA2:
DL $9EC820 : DW $0080, $0040  
DL $9EC8E0 : DW $0080, $0080  
DL $9EC9E0 : DW $00C0, $0080  
DL $9ECB20 : DW $0080, $0080  
DL $9ECC20 : DW $0080, $0040  
DL $9ECCE0 : DW $0080, $0080  
DL $9ECDE0 : DW $00E0, $0040  
DL $9ECF00 : DW $00E0, $0040  
DL $9ED020 : DW $00C0, $0040  
DL $9ED120 : DW $00C0, $0040  
DL $9ED220 : DW $00C0, $0040  
DL $9ED320 : DW $00C0, $0040  
DL $9ED420 : DW $00C0, $0040  
DL $9ED520 : DW $00C0, $0040  
DL $9ED620 : DW $00C0, $0040  
DL $9ED720 : DW $00C0, $0040  
DL $9ED820 : DW $00C0, $0040  
DL $9ED920 : DW $00E0, $0040  
DL $9EDA40 : DW $0100, $0040  
DL $9EDB80 : DW $0100, $0040  
DL $9EDCC0 : DW $0100, $0040  
DL $9EDE00 : DW $0100, $0040  
DL $9EDF40 : DW $00C0, $0040  
DL $9EE040 : DW $00E0, $0040  
DL $9EE160 : DW $00E0, $0040  
DL $9EE280 : DW $00E0, $0040  
DL $9EE3A0 : DW $00C0, $0040  
DL $9EE4A0 : DW $00C0, $0040  
DL $9EE5A0 : DW $00E0, $0040  
DL $9EE6C0 : DW $00C0, $0040  
DL $9EE7C0 : DW $00C0, $0040  
DL $9EE8C0 : DW $00C0, $0040 

;$92CE80  
UT_DMA3:
DL $9C9B00 : DW $00C0, $0080  
DL $9C9C40 : DW $00C0, $0080  
DL $9C9D80 : DW $00C0, $00C0  
DL $9C9F00 : DW $00C0, $00C0  
DL $9CA080 : DW $00C0, $00C0  
DL $9CA200 : DW $00C0, $00C0  
DL $9CA380 : DW $00C0, $00C0  
DL $9CA500 : DW $00C0, $0080  
DL $9CA640 : DW $00C0, $0080  
DL $9CA780 : DW $00C0, $0080  
DL $9CA8C0 : DW $00C0, $00C0  
DL $9CAA40 : DW $00C0, $00C0  
DL $9CABC0 : DW $00C0, $00C0  
DL $9CAD40 : DW $00C0, $00C0  
DL $9CAEC0 : DW $00C0, $00C0  
DL $9CB040 : DW $00C0, $0080  
DL $9CB180 : DW $00C0, $0080  

;$92CEF7
UT_DMA4:
DL $9CB2C0 : DW $0100, $00C0  
DL $9CB480 : DW $0100, $00C0  
DL $9CB640 : DW $0100, $0100  
DL $9CB840 : DW $0100, $0100  
DL $9CBA40 : DW $0100, $00E0  
DL $9CBC20 : DW $0100, $00E0  
DL $9CBE00 : DW $0100, $00E0  
DL $9CBFE0 : DW $0100, $00C0  
DL $9CC1A0 : DW $0100, $00C0  
DL $9CC360 : DW $0100, $00C0  
DL $9CC520 : DW $0100, $00E0  
DL $9CC700 : DW $0100, $0100  
DL $9CC900 : DW $0100, $0100  
DL $9CCB00 : DW $0100, $0100  
DL $9CCD00 : DW $0100, $0100  
DL $9CCF00 : DW $0100, $00E0  
DL $9CD0E0 : DW $0100, $00E0  

;$92CF6E
UT_DMA5:
DL $9DC980 : DW $00C0, $0080  
DL $9DCAC0 : DW $00C0, $0080  
DL $9DCC00 : DW $00C0, $00C0  
DL $9DCD80 : DW $00C0, $00C0  
DL $9DCF00 : DW $00C0, $00C0  
DL $9DD080 : DW $00C0, $00C0  
DL $9DD200 : DW $00C0, $00C0  
DL $9DD380 : DW $00C0, $0080  
DL $9DD4C0 : DW $00C0, $0080  
DL $9DD600 : DW $00C0, $0080  
DL $9DD740 : DW $00C0, $00C0  
DL $9DD8C0 : DW $00C0, $00C0  
DL $9DDA40 : DW $00C0, $00C0  
DL $9DDBC0 : DW $00C0, $00C0  
DL $9DDD40 : DW $00C0, $00C0  
DL $9DDEC0 : DW $00C0, $0080  
DL $9DE000 : DW $00C0, $0080 

;$92CFE5
UT_DMA6:
DL $9DE140 : DW $0100, $00C0  
DL $9DE300 : DW $0100, $00C0  
DL $9DE4C0 : DW $0100, $0100  
DL $9DE6C0 : DW $0100, $0100  
DL $9DE8C0 : DW $0100, $00E0  
DL $9DEAA0 : DW $0100, $00E0  
DL $9DEC80 : DW $0100, $00E0  
DL $9DEE60 : DW $0100, $00C0  
DL $9DF020 : DW $0100, $00C0  
DL $9DF1E0 : DW $0100, $00C0  
DL $9DF3A0 : DW $0100, $00E0  
DL $9DF580 : DW $0100, $0100  
DL $9FED80 : DW $0100, $0100  
DL $9FEF80 : DW $0100, $0100  
DL $9FF180 : DW $0100, $0100  
DL $9FF380 : DW $0100, $00E0  
DL $9FF560 : DW $0100, $00E0 

;$92D05C
UT_DMA7:
DL $9CD2C0 : DW $00E0, $0040  
DL $9CD3E0 : DW $00E0, $0040  
DL $9CD500 : DW $00E0, $0040  
DL $9CD620 : DW $0100, $0040  
DL $9CD760 : DW $0100, $0040  
DL $9CD8A0 : DW $0100, $0040  
DL $9CD9E0 : DW $00E0, $0040  
DL $9CDB00 : DW $00E0, $0040  
DL $9CDC20 : DW $00E0, $0040  
DL $9CDD40 : DW $0100, $0040  
DL $9CDE80 : DW $0100, $0040  
DL $9CDFC0 : DW $0100, $0040  
DL $9CE100 : DW $00C0, $0080  
DL $9CE240 : DW $00C0, $0080  
DL $9CE380 : DW $00C0, $0080  
DL $9CE4C0 : DW $00C0, $0080  
DL $9CE600 : DW $00C0, $0080  
DL $9CE740 : DW $00C0, $0080  
DL $9CE880 : DW $00C0, $0040  
DL $9CE980 : DW $00C0, $0040 

;$92D0E8
UT_DMA8:
DL $9BE000 : DW $0020, $0000  
DL $9BE020 : DW $0020, $0000  
DL $9BE040 : DW $0100, $0020  
DL $9BE160 : DW $00E0, $0000  
DL $9BE240 : DW $0100, $0060  
DL $9BE3A0 : DW $0100, $00E0  
DL $9BE580 : DW $0100, $0000  
DL $9BE680 : DW $0100, $0040  
DL $9BE7C0 : DW $0100, $0060  
DL $9BE920 : DW $00E0, $0000 

;$92D12E
UT_DMA9:
DL $9BEE20 : DW $0080, $0040  
DL $9BEEE0 : DW $0080, $0040  
DL $9BEFA0 : DW $00A0, $0040  
DL $9BF080 : DW $00C0, $0040  
DL $9BF180 : DW $0080, $0040  
DL $9BF240 : DW $00A0, $0040  
DL $9BF320 : DW $00C0, $0040  
DL $9BF420 : DW $00C0, $0040  
DL $9BF520 : DW $00E0, $0040  
DL $9BF640 : DW $00E0, $0040  
DL $9BF760 : DW $00C0, $0040  
DL $9BF860 : DW $0100, $0040  
DL $9BF9A0 : DW $00C0, $0040  
DL $9BFAA0 : DW $0100, $0040  
DL $9BFBE0 : DW $0080, $0040  
DL $9BFCA0 : DW $00C0, $0040 

;$92D19E
LT_DMA0:
DL $9D8000 : DW $0080, $0080  
DL $9D8100 : DW $00E0, $0080  
DL $9D8260 : DW $00E0, $00C0  
DL $9D8400 : DW $0080, $0080  
DL $9D8500 : DW $0100, $0080  
DL $9D8680 : DW $00E0, $00C0  
DL $9D8820 : DW $00C0, $00C0  
DL $9D89A0 : DW $0080, $0080  
DL $9D8AA0 : DW $00C0, $0080  
DL $9D8BE0 : DW $0100, $0080  
DL $9D8D60 : DW $00C0, $0080  
DL $9D8EA0 : DW $0100, $0080  
DL $9D9020 : DW $0100, $00C0  
DL $9D91E0 : DW $0100, $00C0  
DL $9D93A0 : DW $00C0, $00C0  
DL $9D9520 : DW $00C0, $00C0  
DL $9D96A0 : DW $00C0, $00C0  
DL $9D9820 : DW $00A0, $0040  
DL $9D9900 : DW $00A0, $0040  
DL $9D99E0 : DW $00A0, $0080  
DL $9D9B00 : DW $00A0, $0080  
DL $9D9C20 : DW $00A0, $0080  
DL $9D9D40 : DW $00A0, $0080  
DL $9D9E60 : DW $0080, $0040  
DL $9D9F20 : DW $0080, $0040  
DL $9D9FE0 : DW $0080, $0080  
DL $9DA0E0 : DW $0080, $0080  
DL $9DA1E0 : DW $00C0, $0080  
DL $9DA320 : DW $00C0, $0080  
DL $9DA460 : DW $00C0, $00C0  
DL $9DA5E0 : DW $0080, $0080  
DL $9DA6E0 : DW $0080, $0080 

;$92D27E
LT_DMA1:
DL $9DA7E0 : DW $00C0, $0080  
DL $9DA920 : DW $0080, $0080  
DL $9DAA20 : DW $0040, $0040  
DL $9DAAA0 : DW $00C0, $0080  
DL $9DABE0 : DW $0080, $0080  
DL $9DACE0 : DW $0080, $0080  
DL $9DADE0 : DW $00C0, $0080  
DL $9DAF20 : DW $00C0, $0080  
DL $9DB060 : DW $00E0, $0040  
DL $9DB180 : DW $00E0, $0040  
DL $9DB2A0 : DW $00A0, $0080  
DL $9DB3C0 : DW $00A0, $0080  
DL $9DB4E0 : DW $0080, $0080  
DL $9DB5E0 : DW $0080, $0080  
DL $9DB6E0 : DW $00C0, $0040  
DL $9DB7E0 : DW $00C0, $0040  
DL $9DB8E0 : DW $0020, $0000  
DL $9DB900 : DW $00E0, $0040  
DL $9DBA20 : DW $00E0, $0040  
DL $9DBB40 : DW $0100, $0040  
DL $9DBC80 : DW $00C0, $0040  
DL $9DBD80 : DW $00A0, $0080  
DL $9DBEA0 : DW $00A0, $0080  
DL $9DBFC0 : DW $00A0, $0080  
DL $9DC0E0 : DW $00A0, $0080  
DL $9DC200 : DW $00E0, $0080  
DL $9DC360 : DW $00E0, $0080  
DL $9DC4C0 : DW $00C0, $0080  
DL $9DC600 : DW $00C0, $0080  
DL $9DC740 : DW $0080, $0080  
DL $9DC840 : DW $0060, $0040  
DL $9DC8E0 : DW $0060, $0040 

;$92D35E
LT_DMA2:
DL $9F8000 : DW $0080, $0040  
DL $9F80C0 : DW $00E0, $0040  
DL $9F81E0 : DW $00A0, $0080  
DL $9F8300 : DW $00A0, $0040  
DL $9F83E0 : DW $00C0, $0040  
DL $9F84E0 : DW $00C0, $0040  
DL $9F85E0 : DW $0080, $0040  
DL $9F86A0 : DW $00A0, $0040  
DL $9F8780 : DW $00A0, $0040  
DL $9F8860 : DW $00C0, $0040  
DL $9F8960 : DW $00A0, $0080  
DL $9F8A80 : DW $0080, $0080  
DL $9F8B80 : DW $0080, $0080  
DL $9F8C80 : DW $0080, $0080  
DL $9F8D80 : DW $00A0, $0040  
DL $9F8E60 : DW $0080, $0080  
DL $9F8F60 : DW $0080, $0080  
DL $9F9060 : DW $00A0, $0040  
DL $9F9140 : DW $0080, $0080  
DL $9F9240 : DW $0080, $0080  
DL $9F9340 : DW $0080, $0080  
DL $9F9440 : DW $00C0, $0080  
DL $9F9580 : DW $0080, $0080  
DL $9F9680 : DW $0080, $0080 

;$92D406
LT_DMA4:
DL $9F9780 : DW $0080, $0040  
DL $9F9840 : DW $00E0, $0040  
DL $9F9960 : DW $00A0, $0080  
DL $9F9A80 : DW $00A0, $0040  
DL $9F9B60 : DW $00C0, $0040  
DL $9F9C60 : DW $00C0, $0040  
DL $9F9D60 : DW $0080, $0040  
DL $9F9E20 : DW $00A0, $0040  
DL $9F9F00 : DW $00A0, $0040  
DL $9F9FE0 : DW $00C0, $0040  
DL $9FA0E0 : DW $00A0, $0080  
DL $9FA200 : DW $0080, $0080  
DL $9FA300 : DW $0080, $0080  
DL $9FA400 : DW $0080, $0080  
DL $9FA500 : DW $00A0, $0040  
DL $9FA5E0 : DW $0080, $0080  
DL $9FA6E0 : DW $0080, $0080  
DL $9FA7E0 : DW $00A0, $0040  
DL $9FA8C0 : DW $0080, $0080  
DL $9FA9C0 : DW $0080, $0080  
DL $9FAAC0 : DW $0080, $0080  
DL $9FABC0 : DW $0080, $0080  
DL $9FACC0 : DW $0080, $0080 

;$92D4A7
LT_DMA5:
DL $9FADC0 : DW $0080, $0040  
DL $9FAE80 : DW $00E0, $0040  
DL $9FAFA0 : DW $00A0, $0080  
DL $9FB0C0 : DW $00A0, $0040  
DL $9FB1A0 : DW $00C0, $0040  
DL $9FB2A0 : DW $00C0, $0040  
DL $9FB3A0 : DW $0080, $0040  
DL $9FB460 : DW $00A0, $0040  
DL $9FB540 : DW $00A0, $0040  
DL $9FB620 : DW $00C0, $0040  
DL $9FB720 : DW $00A0, $0080  
DL $9FB840 : DW $0080, $0080  
DL $9FB940 : DW $0080, $0080  
DL $9FBA40 : DW $0080, $0080  
DL $9FBB40 : DW $00A0, $0040  
DL $9FBC20 : DW $0080, $0080  
DL $9FBD20 : DW $0080, $0080  
DL $9FBE20 : DW $00A0, $0040  
DL $9FBF00 : DW $0080, $0080  
DL $9FC000 : DW $0080, $0080  
DL $9FC100 : DW $0080, $0080  
DL $9FC200 : DW $00C0, $0080  
DL $9FC340 : DW $0080, $0080  
DL $9FC440 : DW $0080, $0080 

;$92D54F
LT_DMA6:
DL $9FC540 : DW $0080, $0040  
DL $9FC600 : DW $00E0, $0040  
DL $9FC720 : DW $00A0, $0080  
DL $9FC840 : DW $00A0, $0040  
DL $9FC920 : DW $00C0, $0040  
DL $9FCA20 : DW $00C0, $0040  
DL $9FCB20 : DW $0080, $0040  
DL $9FCBE0 : DW $00A0, $0040  
DL $9FCCC0 : DW $00A0, $0040  
DL $9FCDA0 : DW $00C0, $0040  
DL $9FCEA0 : DW $00A0, $0080  
DL $9FCFC0 : DW $0080, $0080  
DL $9FD0C0 : DW $0080, $0080  
DL $9FD1C0 : DW $0080, $0080  
DL $9FD2C0 : DW $00A0, $0040  
DL $9FD3A0 : DW $0080, $0080  
DL $9FD4A0 : DW $0080, $0080  
DL $9FD5A0 : DW $00A0, $0040  
DL $9FD680 : DW $0080, $0080  
DL $9FD780 : DW $0080, $0080  
DL $9FD880 : DW $0080, $0080  
DL $9FD980 : DW $0080, $0080  
DL $9FDA80 : DW $0080, $0080 

;$92D5F0
LT_DMA8:
DL $9BEA00 : DW $0100, $0100  
DL $9BEC00 : DW $0100, $0100  
DL $9BEE00 : DW $0020, $0000 

;$92D605
LT_DMAA:
DL $9FEB00 : DW $00C0, $0080  
DL $9FEC40 : DW $00C0, $0080 

;$92D613
UT_DMAA:
DL $9C8000 : DW $0060, $0040  
DL $9C80A0 : DW $0060, $0040  
DL $9C8140 : DW $0060, $0040  
DL $9C81E0 : DW $0060, $0040  
DL $9C8280 : DW $00A0, $0000  
DL $9C8320 : DW $0060, $0040  
DL $9C83C0 : DW $0060, $0040  
DL $9C8460 : DW $0060, $0040  
DL $9C8500 : DW $0080, $0080  
DL $9C8600 : DW $0100, $0100  
DL $9C8800 : DW $0080, $0080  
DL $9C8900 : DW $0100, $0100  
DL $9C8B00 : DW $0080, $0080  
DL $9C8C00 : DW $0100, $0100  
DL $9C8E00 : DW $0080, $0080  
DL $9C8F00 : DW $0100, $0100  
DL $9C9100 : DW $0100, $0040  
DL $9C9240 : DW $0100, $0060  
DL $9C93A0 : DW $0100, $0060  
DL $9C9500 : DW $0100, $0000  
DL $9C9600 : DW $0020, $0000 

;$92D6A6
UT_DMAB:
DL $9C9620 : DW $0020, $0000  
DL $9C9640 : DW $0060, $0040  
DL $9C96E0 : DW $0060, $0040  
DL $9C9780 : DW $0080, $0040  
DL $9C9840 : DW $00C0, $0040  
DL $9C9940 : DW $0080, $0040  
DL $9C9A00 : DW $00C0, $0040 

;$92D6D7
LT_DMA3:
DL $9EE9C0 : DW $0040, $0040  
DL $9EEA40 : DW $0080, $0080  
DL $9EEB40 : DW $0040, $0040  
DL $9EEBC0 : DW $0080, $0080  
DL $9EECC0 : DW $0040, $0040  
DL $9EED40 : DW $0080, $0080  
DL $9EEE40 : DW $0040, $0040  
DL $9EEEC0 : DW $0080, $0080  
DL $9EEFC0 : DW $0040, $0040  
DL $9EF040 : DW $0080, $0080  
DL $9EF140 : DW $0040, $0040  
DL $9EF1C0 : DW $0080, $0080  
DL $9EF2C0 : DW $0040, $0040  
DL $9EF340 : DW $0080, $0080  
DL $9EF440 : DW $0040, $0040  
DL $9EF4C0 : DW $0080, $0080  
DL $9EF5C0 : DW $0080, $0080 

;$92D74E
UT_DMAC:
DL $9FDB80 : DW $0100, $00C0  
DL $9FDD40 : DW $0100, $00C0  
DL $9FDF00 : DW $0100, $0040  
DL $9FE040 : DW $0100, $0040  
DL $9FE180 : DW $0100, $0040  
DL $9FE2C0 : DW $0100, $0040  
DL $9FE400 : DW $0100, $0040  
DL $9FE540 : DW $0100, $0040 

;$92D786
LT_DMA7:
DL $9FE680 : DW $0040, $0040  
DL $9FE700 : DW $0100, $0100  
DL $9FE900 : DW $0100, $0100 

;$92D79B
LT_DMA9:
DL $9CEA80 : DW $0100, $0100  
DL $9CEC80 : DW $0100, $0100  
DL $9CEE80 : DW $0100, $0100  
DL $9CF080 : DW $0100, $0100  
DL $9CF280 : DW $0100, $0100  
DL $9CF480 : DW $0100, $0100  
DL $9CF680 : DW $0100, $0100  
DL $9CF880 : DW $0100, $0100  



ORG $92D7D3		;THERE ARE TILEMAPS HERE FOR SOME REASON...
;d7d3	
TM_1C1:
DW $0002  
DB $FC, $01, $FE, $25, $3A 
DB $FD, $01, $FC, $43, $3A 

;d7df	
TM_1C2:
DW $0003
DB $FF, $01, $FA, $43, $3A 
DB $FB, $01, $F8, $25, $BA 
DB $FC, $01, $FD, $25, $3A 

;d7f0	
TM_1C3:
DW $0003
DB $FA, $01, $F6, $43, $3A 
DB $00, $00, $F8, $25, $3A 
DB $FD, $01, $FB, $25, $3A 

;d801	
TM_1C4:
DW $0003
DB $00, $00, $F7, $43, $3A 
DB $FC, $01, $FA, $43, $3A 
DB $FA, $01, $F3, $43, $3A 

;d812	
TM_1C5:
DW $0003
DB $00, $00, $F3, $40, $3A 
DB $FA, $01, $F1, $40, $3A 
DB $FC, $01, $F8, $43, $3A 

;d823	
TM_1C6:
DW $0003
DB $01, $00, $F1, $40, $3A 
DB $FC, $01, $F6, $40, $3A 
DB $FA, $01, $EF, $40, $3A 

;d834	
TM_1C7:
DW $0003
DB $01, $00, $EF, $40, $7A 
DB $FC, $01, $F4, $40, $3A 
DB $F9, $01, $EC, $40, $3A 

;d845	
TM_1C8:
DW $0002
DB $02, $00, $EC, $40, $7A 
DB $FC, $01, $F0, $40, $3A 

;d851	
TM_1C9:
DW $0001
DB $FC, $01, $EC, $40, $BA 

;d858	
TM_1CA:
DW $0003
DB $F8, $C3, $00, $9A, $3A 
DB $04, $00, $F8, $5E, $3A 
DB $F4, $01, $F8, $5E, $3A 

;d869	
TM_1CB:
DW $0003
DB $F8, $C3, $04, $9A, $7A 
DB $02, $00, $F8, $BA, $3A 
DB $F6, $01, $F8, $BA, $3A 

;d87a	
TM_1CC:
DW $0005
DB $F8, $C3, $04, $9A, $BA 
DB $00, $00, $F4, $BA, $3A 
DB $F8, $01, $F3, $BA, $3A 
DB $00, $00, $F8, $CA, $3A 
DB $F8, $01, $F8, $CA, $3A 

;d895	
TM_1CD:
DW $0005
DB $F8, $C3, $03, $9C, $3A 
DB $00, $00, $F8, $CA, $3A 
DB $00, $00, $F0, $BA, $3A 
DB $F8, $01, $F8, $CA, $3A 
DB $F8, $01, $F0, $BA, $3A 

;d8b0	
TM_1CE:
DW $0007
DB $F8, $C3, $01, $9C, $BA 
DB $00, $00, $F2, $BA, $3A 
DB $F8, $01, $F1, $BA, $3A 
DB $00, $00, $EB, $C7, $3A 
DB $F8, $01, $EC, $C7, $3A 
DB $00, $00, $F8, $CA, $3A 
DB $F8, $01, $F8, $CA, $3A 

;d8d5	
TM_1CF:
DW $0005
DB $F8, $C3, $00, $9C, $7A 
DB $00, $00, $EE, $C7, $3A 
DB $F8, $01, $F0, $C7, $3A 
DB $01, $00, $F9, $BA, $3A 
DB $F7, $01, $F8, $BA, $3A 

;d8f0	
TM_1D0:
DW $0004
DB $F8, $01, $F2, $C7, $3A 
DB $00, $00, $F2, $C7, $3A 
DB $02, $00, $F8, $5E, $3A 
DB $F6, $01, $F9, $5E, $3A 

;d906	
TM_1D1:
DW $0002
DB $00, $00, $F6, $C7, $3A 
DB $F8, $01, $F6, $C7, $3A 

;d912	
TM_1D2:
DW $0002
DB $00, $00, $FC, $C7, $3A 
DB $F8, $01, $FA, $C7, $3A




;DMA TABLE POINTERS USED BY ANIMATION FRAME PROGRESSION TABLE
ORG $92D91E		;TOP HALF GFX (index shall not exceed #$0C):
DW UT_DMA0, UT_DMA1, UT_DMA2, UT_DMA3, UT_DMA4, UT_DMA5, UT_DMA6
DW UT_DMA7, UT_DMA8, UT_DMA9, UT_DMAA, UT_DMAB, UT_DMAC 
            
ORG $92D938		;BOTTOM HALF GFX (index shall not exceed #$0A):
DW LT_DMA0, LT_DMA1, LT_DMA2, LT_DMA3, LT_DMA4, LT_DMA5, LT_DMA6
DW LT_DMA7, LT_DMA8, LT_DMA9, LT_DMAA


ORG $92D94E		;POSE POINTERS TO ANIMATION FRAME PROGRESSION TABLES
DW AFP_T00, AFP_T01, AFP_T02, AFP_T03, AFP_T04, AFP_T05, AFP_T06, AFP_T07, AFP_T08, AFP_T09, AFP_T0A, AFP_T0B, AFP_T0C, AFP_T0D, AFP_T0E, AFP_T0F
DW AFP_T10, AFP_T11, AFP_T12, AFP_T13, AFP_T14, AFP_T15, AFP_T16, AFP_T17, AFP_T18, AFP_T19, AFP_T1A, AFP_T1B, AFP_T1C, AFP_T1D, AFP_T1E, AFP_T1F
DW AFP_T20, AFP_T21, AFP_T22, AFP_T23, AFP_T24, AFP_T25, AFP_T26, AFP_T27, AFP_T28, AFP_T29, AFP_T2A, AFP_T2B, AFP_T2C, AFP_T2D, AFP_T2E, AFP_T2F
DW AFP_T30, AFP_T31, AFP_T32, AFP_T33, AFP_T34, AFP_T35, AFP_T36, AFP_T37, AFP_T38, AFP_T39, AFP_T3A, AFP_T3B, AFP_T3C, AFP_T3D, AFP_T3E, AFP_T3F
DW AFP_T40, AFP_T41, AFP_T42, AFP_T43, AFP_T44, AFP_T45, AFP_T46, AFP_T47, AFP_T48, AFP_T49, AFP_T4A, AFP_T4B, AFP_T4C, AFP_T4D, AFP_T4E, AFP_T4F
DW AFP_T50, AFP_T51, AFP_T52, AFP_T53, AFP_T54, AFP_T55, AFP_T56, AFP_T57, AFP_T58, AFP_T59, AFP_T5A, AFP_T5B, AFP_T5C, AFP_T5D, AFP_T5E, AFP_T5F
DW AFP_T60, AFP_T61, AFP_T62, AFP_T63, AFP_T64, AFP_T65, AFP_T66, AFP_T67, AFP_T68, AFP_T69, AFP_T6A, AFP_T6B, AFP_T6C, AFP_T6D, AFP_T6E, AFP_T6F
DW AFP_T70, AFP_T71, AFP_T72, AFP_T73, AFP_T74, AFP_T75, AFP_T76, AFP_T77, AFP_T78, AFP_T79, AFP_T7A, AFP_T7B, AFP_T7C, AFP_T7D, AFP_T7E, AFP_T7F
DW AFP_T80, AFP_T81, AFP_T82, AFP_T83, AFP_T84, AFP_T85, AFP_T86, AFP_T87, AFP_T88, AFP_T89, AFP_T8A, AFP_T8B, AFP_T8C, AFP_T8D, AFP_T8E, AFP_T8F
DW AFP_T90, AFP_T91, AFP_T92, AFP_T93, AFP_T94, AFP_T95, AFP_T96, AFP_T97, AFP_T98, AFP_T99, AFP_T9A, AFP_T9B, AFP_T9C, AFP_T9D, AFP_T9E, AFP_T9F
DW AFP_TA0, AFP_TA1, AFP_TA2, AFP_TA3, AFP_TA4, AFP_TA5, AFP_TA6, AFP_TA7, AFP_TA8, AFP_TA9, AFP_TAA, AFP_TAB, AFP_TAC, AFP_TAD, AFP_TAE, AFP_TAF
DW AFP_TB0, AFP_TB1, AFP_TB2, AFP_TB3, AFP_TB4, AFP_TB5, AFP_TB6, AFP_TB7, AFP_TB8, AFP_TB9, AFP_TBA, AFP_TBB, AFP_TBC, AFP_TBD, AFP_TBE, AFP_TBF
DW AFP_TC0, AFP_TC1, AFP_TC2, AFP_TC3, AFP_TC4, AFP_TC5, AFP_TC6, AFP_TC7, AFP_TC8, AFP_TC9, AFP_TCA, AFP_TCB, AFP_TCC, AFP_TCD, AFP_TCE, AFP_TCF
DW AFP_TD0, AFP_TD1, AFP_TD2, AFP_TD3, AFP_TD4, AFP_TD5, AFP_TD6, AFP_TD7, AFP_TD8, AFP_TD9, AFP_TDA, AFP_TDB, AFP_TDC, AFP_TDD, AFP_TDE, AFP_TDF
DW AFP_TE0, AFP_TE1, AFP_TE2, AFP_TE3, AFP_TE4, AFP_TE5, AFP_TE6, AFP_TE7, AFP_TE8, AFP_TE9, AFP_TEA, AFP_TEB, AFP_TEC, AFP_TED, AFP_TEE, AFP_TEF
DW AFP_TF0, AFP_TF1, AFP_TF2, AFP_TF3, AFP_TF4, AFP_TF5, AFP_TF6, AFP_TF7, AFP_TF8, AFP_TF9, AFP_TFA, AFP_TFB, AFP_TFC

;DB48
AFP_T01:;Facing right, normal
AFP_T47:;Standing, facing right. Unused?
AFP_T89:;Ran into a wall on right (facing right)
AFP_TA8:;Just standing, facing right. Unused? (Grapple movement)
DB $07, $0C, $00, $06 
DB $07, $0D, $00, $0E 
DB $07, $0E, $00, $0F 
DB $07, $0D, $00, $0E 
DB $00, $00, $00, $00 
DB $07, $0C, $00, $06 
DB $07, $0D, $00, $0E 
DB $07, $12, $00, $0F 
DB $07, $0D, $00, $0E

;DB6C
AFP_T02:;Facing left, normal
AFP_T48:;Standing, facing left. Unused?
AFP_T8A:;Ran into a wall on left (facing left)
AFP_TA9:;Just standing, facing left. Unused? (Grapple movement)
DB $07, $0F, $00, $06 
DB $07, $10, $00, $10 
DB $07, $11, $00, $1D 
DB $07, $10, $00, $10 
DB $00, $00, $00, $00 
DB $07, $0F, $00, $06 
DB $07, $10, $00, $10 
DB $07, $13, $00, $1D 
DB $07, $10, $00, $10

;DB90
AFP_TA4:;Landing from normal jump, facing right
DB $02, $00, $01, $06 
DB $02, $04, $00, $06

;DB98
AFP_TA5:;Landing from normal jump, facing left
DB $02, $01, $01, $07 
DB $02, $05, $00, $06

;DBA0
AFP_TA6:;Landing from spin jump, facing right
DB $02, $04, $01, $19 
DB $02, $00, $01, $06 
DB $02, $04, $00, $06

;DBAC
AFP_TA7:;Landing from spin jump, facing left
DB $02, $05, $01, $1A 
DB $02, $01, $01, $07 
DB $02, $05, $00, $06

;DBB8
AFP_TE0:;Landing from normal jump, facing right and aiming up
DB $00, $16, $01, $06 
DB $00, $16, $00, $06

;DBC0
AFP_TE1:;Landing from normal jump, facing left and aiming up
DB $00, $17, $01, $07 
DB $00, $17, $00, $06 

;DBC8
AFP_TE2:;Landing from normal jump, facing right and aiming upright
DB $00, $12, $01, $06 
DB $00, $12, $00, $06 

;DBD0
AFP_TE3:;Landing from normal jump, facing left and aiming upleft
DB $00, $13, $01, $07 
DB $00, $13, $00, $06 

;DBD8
AFP_TE4:;Landing from normal jump, facing right and aiming Downright
DB $00, $0E, $01, $06 
DB $00, $0E, $00, $06 

;DBE0
AFP_TE5:;Landing from normal jump, facing left and aiming Downleft
DB $00, $0F, $01, $07 
DB $00, $0F, $00, $06 

;DBE8
AFP_TE6:;Landing from normal jump, facing right, firing
DB $00, $10, $01, $06 
DB $00, $10, $00, $06 

;DBF0
AFP_TE7:;Landing from normal jump, facing left, firing
DB $00, $11, $01, $07 
DB $00, $11, $00, $06

;DBF8
AFP_TD5:;X-raying right, standing
DB $02, $09, $00, $06 
DB $02, $08, $00, $06 
DB $00, $10, $00, $06 
DB $02, $0A, $00, $06 
DB $02, $0B, $00, $06

;DC0C
AFP_TD6:;X-raying left, standing
DB $02, $0D, $00, $06 
DB $02, $0C, $00, $06 
DB $00, $11, $00, $06 
DB $02, $0E, $00, $06 
DB $02, $0F, $00, $06

;DC20
AFP_TD9:;X-raying right, crouching
DB $02, $09, $00, $07 
DB $02, $08, $00, $07 
DB $00, $10, $00, $07 
DB $02, $0A, $00, $07 
DB $02, $0B, $00, $07

;DC34
AFP_TDA:;X-raying left, crouching
DB $02, $0D, $00, $07 
DB $02, $0C, $00, $07 
DB $00, $11, $00, $07 
DB $02, $0E, $00, $07 
DB $02, $0F, $00, $07

;DC48
AFP_T09:;Moving right, not aiming
DB $00, $00, $00, $00 
DB $01, $0D, $00, $08 
DB $00, $02, $00, $01 
DB $00, $03, $00, $09 
DB $00, $01, $00, $02 
DB $00, $00, $00, $03 
DB $01, $0E, $00, $0A 
DB $00, $05, $00, $04 
DB $00, $18, $00, $0B 
DB $00, $04, $00, $05

;DC70
AFP_T0A:;Moving left, not aiming
DB $00, $06, $00, $00 
DB $01, $0F, $00, $08 
DB $00, $08, $00, $01 
DB $00, $09, $00, $09 
DB $00, $07, $00, $02 
DB $00, $06, $00, $03 
DB $01, $10, $00, $0A 
DB $00, $0B, $00, $04 
DB $00, $19, $00, $0B 
DB $00, $0A, $00, $05

;DC98
AFP_T0B:;Moving right, gun extended forward (not aiming)
DB $09, $00, $00, $00 
DB $09, $0E, $00, $08 
DB $09, $02, $00, $01 
DB $09, $03, $00, $09 
DB $09, $01, $00, $02 
DB $09, $00, $00, $03 
DB $09, $04, $00, $0A 
DB $09, $05, $00, $04 
DB $09, $0C, $00, $0B 
DB $09, $04, $00, $05

;DCC0
AFP_T0C:;Moving left, gun extended forward (not aiming)
DB $09, $06, $00, $00 
DB $09, $0F, $00, $08 
DB $09, $09, $00, $01 
DB $09, $08, $00, $09 
DB $09, $07, $00, $02 
DB $09, $06, $00, $03 
DB $09, $0A, $00, $0A 
DB $09, $0D, $00, $04 
DB $09, $0B, $00, $0B 
DB $09, $0A, $00, $05

;DCE8
AFP_T49:;Moonwalk, facing left
DB $00, $11, $01, $03 
DB $02, $1B, $01, $04 
DB $02, $1B, $01, $15 
DB $00, $11, $01, $00 
DB $02, $1B, $01, $05 
DB $02, $1B, $01, $16

;DD00
AFP_T4A:;Moonwalk, facing right
DB $00, $10, $01, $03 
DB $02, $1A, $01, $04 
DB $02, $1A, $01, $17 
DB $00, $10, $01, $00 
DB $02, $1A, $01, $05 
DB $02, $1A, $01, $18

;DD18
AFP_T17:;Normal jump facing right, aiming Down
AFP_TAE:;jumping, facing right, aiming Down. Unused? (Grapple mo
DB $00, $0C, $01, $0A 
DB $01, $1A, $01, $11

;DD20
AFP_T18:;Normal jump facing left, aiming Down
AFP_TAF:;jumping, facing left, aiming Down. Unused? (Grapple movement)
DB $00, $0D, $01, $0B 
DB $01, $1B, $01, $12 

;DD28
AFP_T13:;Normal jump facing right, gun extended, not aiming or moving
AFP_TAC:;jumping, facing right, gun extended. Unused? (Grapple movement)
DB $00, $10, $01, $0A 
DB $00, $10, $01, $19 

;DD30
AFP_T14:;Normal jump facing left, gun extended, not aiming or moving
AFP_TAD:;jumping, facing left, gun extended. Unused? (Grapple movement)
DB $00, $11, $01, $0B 
DB $00, $11, $01, $1A 

;DD38
AFP_T15:;Normal jump facing right, aiming up
DB $00, $12, $01, $0A 
DB $00, $16, $00, $13 

;DD40
AFP_T16:;Normal jump facing left, aiming up
DB $00, $13, $01, $0B 
DB $00, $17, $00, $14 

;DD48
AFP_T51:;Normal jump facing right, moving forward (gun extended)
DB $00, $10, $01, $0A 
DB $00, $10, $01, $19 

;DD50
AFP_T52:;Normal jump facing left, moving forward (gun extended)
DB $00, $11, $01, $0B 
DB $00, $11, $01, $1A 

;DD58
AFP_T69:;Normal jump facing right, aiming upright. Moving optional
DB $00, $1A, $01, $0A 
DB $00, $1A, $00, $13 

;DD60
AFP_T6A:;Normal jump facing left, aiming upleft. Moving optional
DB $00, $1B, $01, $0B 
DB $00, $1B, $00, $14 

;DD68
AFP_T6B:;Normal jump facing right, aiming Downright. Moving optional
AFP_TB0:;jumping, facing right, aiming Downright. Unused? (Grapple movement)
DB $00, $0C, $01, $0A 
DB $00, $0C, $01, $19 

;DD70
AFP_T6C:;Normal jump facing left, aiming Downleft. Moving optional
AFP_TB1:;jumping, facing left, aiming Downleft. Unused? (Grapple movement)
DB $00, $0D, $01, $0B 
DB $00, $0D, $01, $1A

;DD78
AFP_T4B:;Normal jump transition from ground(standing or crouching), facing right
DB $02, $00, $01, $06

;DD7C
AFP_T4C:;Normal jump transition from ground(standing or crouching), facing left
DB $02, $01, $01, $07

;DD80
AFP_T55:;Normal jump transition from ground, facing right and aiming up
AFP_TF1:;Crouch transition, facing right and aiming up
AFP_TF7:;Crouching to standing, facing right and aiming up
DB $00, $16, $01, $06 

;DD84
AFP_T56:;Normal jump transition from ground, facing left and aiming up
AFP_TF2:;Crouch transition, facing left and aiming up
AFP_TF8:;Crouching to standing, facing left and aiming up
DB $00, $17, $01, $07 

;DD88
AFP_T57:;Normal jump transition from ground, facing right and aiming upright
AFP_TF3:;Crouch transition, facing right and aiming upright
AFP_TF9:;Crouching to standing, facing right and aiming upright
DB $00, $12, $01, $06 

;DD8C
AFP_T58:;Normal jump transition from ground, facing left and aiming upleft
AFP_TF4:;Crouch transition, facing left and aiming upleft
AFP_TFA:;Crouching to standing, facing left and aiming upleft
DB $00, $13, $01, $07 

;DD90
AFP_T59:;Normal jump transition from ground, facing right and aiming Downright
AFP_TF5:;Crouch transition, facing right and aiming Downright
AFP_TFB:;Crouching to standing, facing right and aiming Downright
DB $00, $0E, $01, $06 

;DD94
AFP_T5A:;Normal jump transition from ground, facing left and aiming Downleft
AFP_TF6:;Crouch transition, facing left and aiming Downleft
AFP_TFC:;Crouching to standing, facing left and aiming Downleft
DB $00, $0F, $01, $07

;DD98
AFP_T4D:;Normal jump facing right, gun not extended, not aiming, not moving
AFP_TC7:;Super jump windup, facing right
DB $00, $04, $00, $03 
DB $00, $05, $01, $0E 
DB $00, $04, $01, $08 
DB $00, $00, $01, $08 
DB $00, $01, $01, $0A 
DB $00, $14, $01, $0C

;DDB0
AFP_T4E:;Normal jump facing left, gun not extended, not aiming, not moving
AFP_TC8:;Super jump windup, facing left
DB $00, $0A, $00, $03 
DB $00, $0B, $01, $0F 
DB $00, $0A, $01, $09 
DB $00, $06, $01, $09 
DB $00, $07, $01, $0B 
DB $00, $15, $01, $0D

;DDC8
AFP_T4F:;Hurt roll back, moving right/facing left
DB $02, $05, $00, $11 
DB $02, $05, $01, $0B 
DB $0A, $0F, $00, $00 
DB $0A, $0E, $00, $00 
DB $0A, $0D, $00, $00 
DB $0A, $0C, $00, $00 
DB $0A, $0B, $00, $00 
DB $0A, $0A, $00, $00 
DB $0A, $09, $00, $00 
DB $02, $1F, $01, $1A

;DDF0
AFP_T50:;Hurt roll back, moving left/facing right
DB $02, $04, $00, $12 
DB $02, $04, $01, $0A 
DB $0A, $0F, $00, $00 
DB $0A, $0E, $00, $00 
DB $0A, $0D, $00, $00 
DB $0A, $0C, $00, $00 
DB $0A, $0B, $00, $00 
DB $0A, $0A, $00, $00 
DB $0A, $09, $00, $00 
DB $02, $1D, $01, $19

;DE18
AFP_T27:;Crouching, facing right
AFP_TB4:;Crouching, facing right. Unused? (Grapple movement)
DB $07, $0C, $00, $07 
DB $07, $0D, $00, $07 
DB $07, $0E, $00, $07 
DB $07, $0D, $00, $07 
DB $00, $00, $00, $00 
DB $07, $0C, $00, $07 
DB $07, $0D, $00, $07 
DB $07, $12, $00, $07 
DB $07, $0D, $00, $07

;DE3C
AFP_T28:;Crouching, facing left
AFP_TB5:;Crouching, facing left. Unused? (Grapple movement)
DB $07, $0F, $00, $07 
DB $07, $10, $00, $07 
DB $07, $11, $00, $07 
DB $07, $10, $00, $07 
DB $00, $00, $00, $00 
DB $07, $0F, $00, $07 
DB $07, $10, $00, $07 
DB $07, $13, $00, $07 
DB $07, $10, $00, $07

;DE60
AFP_T29:;Falling facing right, normal pose
DB $02, $04, $01, $0A 
DB $02, $1C, $01, $0C 
DB $02, $1D, $01, $0C 
DB $00, $00, $00, $00 
DB $00, $00, $00, $00 
DB $02, $1C, $01, $0A 
DB $02, $04, $01, $19

;DE7C
AFP_T2A:;Falling facing left, normal pose
DB $02, $05, $01, $0B 
DB $02, $1E, $01, $0D 
DB $02, $1F, $01, $0D 
DB $00, $00, $00, $00 
DB $00, $00, $00, $00 
DB $02, $1E, $01, $0B 
DB $02, $05, $01, $1A

;DE98
AFP_T2B:;Falling facing right, aiming up
DB $00, $12, $01, $0A 
DB $00, $16, $01, $0C 
DB $00, $16, $01, $19

;DEA4
AFP_T2C:;Falling facing left, aiming up
DB $00, $13, $01, $0B 
DB $00, $17, $01, $0D 
DB $00, $17, $01, $1A

;DEB0
AFP_T2D:;Falling facing right, aiming Down
DB $00, $0C, $01, $0A 
DB $01, $1A, $01, $11 

;DEB8
AFP_T2E:;Falling facing left, aiming Down
DB $00, $0D, $01, $0B 
DB $01, $1B, $01, $12

;DEC0
AFP_T67:;Facing right, falling, fired a shot
DB $00, $10, $01, $0A 
DB $00, $10, $01, $0C 
DB $00, $10, $01, $0C 
DB $00, $00, $00, $00 
DB $00, $00, $00, $00 
DB $00, $10, $01, $0A 
DB $00, $10, $01, $19

;DEDC
AFP_T68:;Facing left, falling, fired a shot
DB $00, $11, $01, $0B 
DB $00, $11, $01, $0D 
DB $00, $11, $01, $0D 
DB $00, $00, $00, $00 
DB $00, $00, $00, $00 
DB $00, $11, $01, $0B 
DB $00, $11, $01, $1A

;DEF8
AFP_T6D:;Falling facing right, aiming upright
DB $00, $1A, $01, $0A 
DB $00, $1A, $01, $0C 
DB $00, $1A, $01, $19

;DF04
AFP_T6E:;Falling facing left, aiming upleft
DB $00, $1B, $01, $0B 
DB $00, $1B, $01, $0D 
DB $00, $1B, $01, $1A

;DF10
AFP_T6F:;Falling facing right, aiming Downright
DB $00, $0C, $01, $0A 
DB $00, $0C, $01, $0C 
DB $00, $0C, $01, $19

;DF1C
AFP_T70:;Falling facing left, aiming Downleft
DB $00, $0D, $01, $0B 
DB $00, $0D, $01, $0D 
DB $00, $0D, $01, $1A

;DF28
AFP_T0D:;Moving right, aiming straight up (unused?)
DB $00, $16, $00, $00 
DB $00, $16, $00, $08 
DB $02, $0E, $00, $01 
DB $02, $1E, $00, $09 
DB $02, $0E, $00, $02 
DB $00, $16, $00, $03 
DB $00, $16, $00, $0A 
DB $02, $0E, $00, $04 
DB $02, $1E, $00, $0B 
DB $02, $0E, $00, $05

;DF50
AFP_T0E:;Moving left, aiming straight up (unused?)
DB $00, $17, $00, $00 
DB $00, $17, $00, $08 
DB $02, $0F, $00, $01 
DB $02, $1F, $00, $09 
DB $02, $0F, $00, $02 
DB $00, $17, $00, $03 
DB $00, $17, $00, $0A 
DB $02, $0F, $00, $04 
DB $02, $1F, $00, $0B 
DB $02, $0F, $00, $05

;DF78
AFP_T0F:;Moving right, aiming upright
DB $00, $1A, $00, $00 
DB $00, $1A, $00, $08 
DB $02, $10, $00, $01 
DB $02, $16, $00, $09 
DB $02, $10, $00, $02 
DB $00, $1A, $00, $03 
DB $00, $1A, $00, $0A 
DB $02, $10, $00, $04 
DB $02, $16, $00, $0B 
DB $02, $10, $00, $05

;DFA0
AFP_T10:;Moving left, aiming upleft
DB $00, $1B, $00, $00 
DB $00, $1B, $00, $08 
DB $02, $11, $00, $01 
DB $02, $17, $00, $09 
DB $02, $11, $00, $02 
DB $00, $1B, $00, $03 
DB $00, $1B, $00, $0A 
DB $02, $11, $00, $04 
DB $02, $17, $00, $0B 
DB $02, $11, $00, $05

;DFC8
AFP_T11:;Moving right, aiming Downright
DB $00, $0C, $00, $00 
DB $00, $0C, $00, $08 
DB $02, $06, $00, $01 
DB $02, $18, $00, $09 
DB $02, $06, $00, $02 
DB $00, $0C, $00, $03 
DB $00, $0C, $00, $0A 
DB $02, $06, $00, $04 
DB $02, $18, $00, $0B 
DB $02, $06, $00, $05

;DFF0
AFP_T12:;Moving left, aiming Downleft
DB $00, $0D, $00, $00 
DB $00, $0D, $00, $08 
DB $02, $07, $00, $01 
DB $02, $19, $00, $09 
DB $02, $07, $00, $02 
DB $00, $0D, $00, $03 
DB $00, $0D, $00, $0A 
DB $02, $07, $00, $04 
DB $02, $19, $00, $0B 
DB $02, $07, $00, $05

;E018
AFP_T03:;Facing right, aiming up
DB $00, $12, $0A, $00 
DB $00, $16, $0A, $00

;E020
AFP_T04:;Facing left, aiming up
DB $00, $13, $0A, $01 
DB $00, $17, $0A, $01

;E028
AFP_T05:;Facing right, aiming upright
AFP_TCF:;Samus ran right into a wall, is still holding right and is now aiming diagonal up
DB $00, $12, $0A, $00

;E02C
AFP_T06:;Facing left, aiming upleft
AFP_TD0:;Samus ran left into a wall, is still holding left and is now aiming diagonal up
DB $00, $13, $0A, $01

;E030
AFP_T07:;Facing right, aiming Downright
AFP_TAA:;Just standing, facing right aiming Downright. Unused? (Grapple movement)
AFP_TD1:;Samus ran right into a wall, is still holding right and is now aiming diagonal Down
DB $00, $0E, $0A, $00 

;E034
AFP_T08:;Facing left, aiming Downleft
AFP_TAB:;Just standing, facing left aiming Downleft. Unused? (Grapple movement)
AFP_TD2:;Samus ran left into a wall, is still holding left and is now aiming diagonal Down
DB $00, $0F, $0A, $01

;E038
AFP_T53:;Hurt, facing right
DB $00, $1D, $01, $0C 
DB $00, $1D, $01, $1B

;E040
AFP_T54:;Hurt, facing left
DB $00, $1C, $01, $0D 
DB $00, $1C, $01, $1C

;E048
AFP_T45:;running, facing right, shooting left. Unused? (Fast moonwalk)
AFP_T46:;running, facing left, shooting right. Unused? (Fast moonwalk)
AFP_T5B:;Something for grapple (wall jump?), probably unused
AFP_TB8:;Grapple, attached to a wall on right, facing left
DB $01, $0C, $00, $1A

;E04C
AFP_T5C:;Something for grapple (wall jump?), probably unused
AFP_TB9:;Grapple, attached to a wall on left, facing right
DB $01, $0B, $00, $19

;E050
AFP_T5D:;Broken grapple? Facing clockwise, maybe unused
AFP_T5E:;Broken grapple? Facing clockwise, maybe unused
AFP_T5F:;Broken grapple? Facing clockwise, maybe unused
AFP_T60:;Better broken grapple. Facing clockwise, maybe unused
AFP_T61:;Nearly normal grapple. Facing clockwise, maybe unused
AFP_TB2:;Grapple, facing clockwise
DB $05, $08, $04, $05 
DB $05, $07, $04, $04 
DB $05, $06, $04, $03 
DB $05, $05, $04, $02 
DB $05, $04, $04, $02 
DB $05, $03, $04, $01 
DB $05, $02, $04, $01 
DB $05, $01, $04, $00 
DB $05, $00, $04, $00 
DB $03, $0F, $04, $00 
DB $03, $0E, $02, $09 
DB $03, $0D, $02, $09 
DB $03, $0C, $02, $08 
DB $03, $0B, $02, $08 
DB $03, $0A, $02, $07 
DB $03, $09, $02, $06 
DB $03, $08, $02, $05 
DB $03, $07, $02, $04 
DB $03, $06, $02, $03 
DB $03, $05, $02, $02 
DB $03, $04, $02, $02 
DB $03, $03, $02, $01 
DB $03, $02, $02, $01 
DB $03, $01, $02, $00 
DB $03, $00, $02, $00 
DB $05, $0F, $02, $00 
DB $05, $0E, $04, $09 
DB $05, $0D, $04, $09 
DB $05, $0C, $04, $08 
DB $05, $0B, $04, $08 
DB $05, $0A, $04, $07 
DB $05, $09, $04, $06 
DB $05, $08, $04, $12 
DB $05, $07, $04, $11 
DB $05, $06, $04, $10 
DB $05, $05, $04, $0F 
DB $05, $04, $04, $0F 
DB $05, $03, $04, $0E 
DB $05, $02, $04, $0E 
DB $05, $01, $04, $0D 
DB $05, $00, $04, $0D 
DB $03, $0F, $04, $0D 
DB $03, $0E, $02, $16 
DB $03, $0D, $02, $16 
DB $03, $0C, $02, $15 
DB $03, $0B, $02, $15 
DB $03, $0A, $02, $14 
DB $03, $09, $02, $13 
DB $03, $08, $02, $12 
DB $03, $07, $02, $11 
DB $03, $06, $02, $10 
DB $03, $05, $02, $0F 
DB $03, $04, $02, $0F 
DB $03, $03, $02, $0E 
DB $03, $02, $02, $0E 
DB $03, $01, $02, $0D 
DB $03, $00, $02, $0D 
DB $05, $0F, $02, $0D 
DB $05, $0E, $04, $15 
DB $05, $0D, $04, $15 
DB $05, $0C, $04, $14 
DB $05, $0B, $04, $14 
DB $05, $0A, $04, $13 
DB $05, $09, $04, $12 
DB $03, $08, $02, $0B 
DB $03, $08, $02, $0C

;E158
AFP_T62:;Nearly normal grapple. Facing counterclockwise, maybe unused
AFP_TB3:;Grapple, facing counterclockwise
DB $06, $08, $06, $05 
DB $06, $09, $06, $06 
DB $06, $0A, $06, $07 
DB $06, $0B, $06, $08 
DB $06, $0C, $06, $08 
DB $06, $0D, $06, $09 
DB $06, $0E, $06, $09 
DB $06, $0F, $05, $00 
DB $04, $00, $05, $00 
DB $04, $01, $05, $00 
DB $04, $02, $05, $01 
DB $04, $03, $05, $01 
DB $04, $04, $05, $02 
DB $04, $05, $05, $02 
DB $04, $06, $05, $03 
DB $04, $07, $05, $04 
DB $04, $08, $05, $05 
DB $04, $09, $05, $06 
DB $04, $0A, $05, $07 
DB $04, $0B, $05, $08 
DB $04, $0C, $05, $08 
DB $04, $0D, $05, $09 
DB $04, $0E, $05, $09 
DB $04, $0F, $06, $00 
DB $06, $00, $06, $00 
DB $06, $01, $06, $00 
DB $06, $02, $06, $01 
DB $06, $03, $06, $01 
DB $06, $04, $06, $02 
DB $06, $05, $06, $02 
DB $06, $06, $06, $03 
DB $06, $07, $06, $04 
DB $06, $08, $06, $12 
DB $06, $09, $06, $13 
DB $06, $0A, $06, $14 
DB $06, $0B, $06, $15 
DB $06, $0C, $06, $15 
DB $06, $0D, $06, $16 
DB $06, $0E, $06, $16 
DB $06, $0F, $05, $0D 
DB $04, $00, $05, $0D 
DB $04, $01, $05, $0D 
DB $04, $02, $05, $0E 
DB $04, $03, $05, $0E 
DB $04, $04, $05, $0F 
DB $04, $05, $05, $0F 
DB $04, $06, $05, $10 
DB $04, $07, $05, $11 
DB $04, $08, $05, $12 
DB $04, $09, $05, $13 
DB $04, $0A, $05, $14 
DB $04, $0B, $05, $15 
DB $04, $0C, $05, $15 
DB $04, $0D, $05, $16 
DB $04, $0E, $05, $16 
DB $04, $0F, $06, $0D 
DB $06, $00, $06, $0D 
DB $06, $01, $06, $0D 
DB $06, $02, $06, $0E 
DB $06, $03, $06, $0E 
DB $06, $04, $06, $0F 
DB $06, $05, $06, $0F 
DB $06, $06, $06, $10 
DB $06, $07, $06, $11 
DB $04, $08, $05, $0B 
DB $04, $08, $05, $0C

;E260
AFP_T63:;Facing left on grapple blocks, ready to jump. Unused?
DB $01, $14, $01, $15 
DB $01, $0C, $00, $1A

;E268
AFP_T64:;Facing right on grapple blocks, ready to jump. Unused?
DB $01, $15, $01, $16 
DB $01, $0B, $00, $19

;E270
AFP_T65:;Glitchy jump, facing left. Used by unused grapple jump?
DB $01, $12, $01, $13 
DB $0A, $10, $00, $00 
DB $0A, $11, $00, $00 
DB $0A, $12, $00, $00 
DB $0A, $13, $00, $00 
DB $0A, $14, $00, $00 
DB $0A, $15, $00, $00 
DB $0A, $16, $00, $00 
DB $0A, $17, $00, $00

;E294
AFP_T66:;Glitchy jump, facing right. Used by unused grapple jump?
DB $01, $13, $01, $14 
DB $0A, $10, $00, $00 
DB $0A, $11, $00, $00 
DB $0A, $12, $00, $00 
DB $0A, $13, $00, $00 
DB $0A, $14, $00, $00 
DB $0A, $15, $00, $00 
DB $0A, $16, $00, $00 
DB $0A, $17, $00, $00

;E2B8
AFP_T83:;Walljump right
DB $01, $12, $01, $13 
DB $02, $04, $01, $19 
DB $00, $00, $00, $00 
DB $0A, $08, $00, $00 
DB $0A, $09, $00, $00 
DB $0A, $0A, $00, $00 
DB $0A, $0B, $00, $00 
DB $0A, $0C, $00, $00 
DB $0A, $0D, $00, $00 
DB $0A, $0E, $00, $00 
DB $0A, $0F, $00, $00 
DB $00, $00, $00, $00 
DB $00, $00, $00, $00 
DB $0A, $14, $09, $00 
DB $0A, $14, $09, $01 
DB $0A, $14, $09, $02 
DB $0A, $14, $09, $03 
DB $0A, $14, $09, $04 
DB $0A, $14, $09, $05 
DB $0A, $14, $09, $06 
DB $0A, $14, $09, $07 
DB $00, $00, $00, $00 
DB $00, $00, $00, $00 
DB $0A, $10, $09, $00 
DB $0A, $10, $09, $01 
DB $0A, $10, $09, $02 
DB $0A, $14, $09, $03 
DB $0A, $14, $09, $04 
DB $0A, $14, $09, $05 
DB $0A, $11, $09, $06 
DB $0A, $11, $09, $07 
DB $0A, $11, $09, $00 
DB $0A, $14, $09, $01 
DB $0A, $14, $09, $02 
DB $0A, $14, $09, $03 
DB $0A, $12, $09, $04 
DB $0A, $12, $09, $05 
DB $0A, $12, $09, $06 
DB $0A, $14, $09, $07 
DB $0A, $14, $09, $00 
DB $0A, $14, $09, $01 
DB $0A, $13, $09, $02 
DB $0A, $13, $09, $03 
DB $0A, $13, $09, $04 
DB $0A, $14, $09, $05 
DB $0A, $14, $09, $06 
DB $0A, $14, $09, $07

;E374
AFP_T84:;Walljump left
DB $01, $13, $01, $14 
DB $02, $05, $01, $1A 
DB $00, $00, $00, $00 
DB $0A, $08, $00, $00 
DB $0A, $09, $00, $00 
DB $0A, $0A, $00, $00 
DB $0A, $0B, $00, $00 
DB $0A, $0C, $00, $00 
DB $0A, $0D, $00, $00 
DB $0A, $0E, $00, $00 
DB $0A, $0F, $00, $00 
DB $00, $00, $00, $00 
DB $00, $00, $00, $00 
DB $0A, $14, $09, $00 
DB $0A, $14, $09, $01 
DB $0A, $14, $09, $02 
DB $0A, $14, $09, $03 
DB $0A, $14, $09, $04 
DB $0A, $14, $09, $05 
DB $0A, $14, $09, $06 
DB $0A, $14, $09, $07 
DB $00, $00, $00, $00 
DB $00, $00, $00, $00 
DB $0A, $10, $09, $00 
DB $0A, $10, $09, $01 
DB $0A, $10, $09, $02 
DB $0A, $14, $09, $03 
DB $0A, $14, $09, $04 
DB $0A, $14, $09, $05 
DB $0A, $11, $09, $06 
DB $0A, $11, $09, $07 
DB $0A, $11, $09, $00 
DB $0A, $14, $09, $01 
DB $0A, $14, $09, $02 
DB $0A, $14, $09, $03 
DB $0A, $12, $09, $04 
DB $0A, $12, $09, $05 
DB $0A, $12, $09, $06 
DB $0A, $14, $09, $07 
DB $0A, $14, $09, $00 
DB $0A, $14, $09, $01 
DB $0A, $13, $09, $02 
DB $0A, $13, $09, $03 
DB $0A, $13, $09, $04 
DB $0A, $14, $09, $05 
DB $0A, $14, $09, $06 
DB $0A, $14, $09, $07

;E430
AFP_T71:;Standing to crouching, facing right and aiming upright
DB $00, $12, $00, $07

;E434
AFP_T72:;Standing to crouching, facing left and aiming upleft
DB $00, $13, $00, $07

;E438
AFP_T73:;Standing to crouching, facing right and aiming Downright
AFP_TB6:;Crouching, facing right, aiming Downright. Unused? (Grapple movement)
DB $00, $0E, $00, $07

;E43C
AFP_T74:;Standing to crouching, facing left and aiming Downlef
AFP_TB7:;Crouching, facing left, aiming Downleft. Unused? (Grapple movement)
DB $00, $0F, $00, $07

;E440
AFP_T85:;Crouching, facing right aiming up
DB $00, $12, $00, $07 
DB $00, $16, $00, $07

;E448
AFP_T86:;Crouching, facing left aiming up
DB $00, $13, $00, $07 
DB $00, $17, $00, $07

;E450
AFP_T75:;Moonwalk, facing left aiming upleft
DB $00, $1B, $01, $03 
DB $02, $11, $01, $04 
DB $02, $11, $01, $17 
DB $00, $1B, $01, $00 
DB $02, $11, $01, $05 
DB $02, $11, $01, $18

;E468
AFP_T76:;Moonwalk, facing right aiming upright
DB $00, $1A, $01, $03 
DB $02, $10, $01, $04 
DB $02, $10, $01, $17 
DB $00, $1A, $01, $00 
DB $02, $10, $01, $05 
DB $02, $10, $01, $18

;E480
AFP_T77:;Moonwalk, facing left aiming Downleft
DB $00, $0D, $01, $03 
DB $02, $07, $01, $04 
DB $02, $07, $01, $17 
DB $00, $0D, $01, $00 
DB $02, $07, $01, $05 
DB $02, $07, $01, $18

;E498
AFP_T78:;Moonwalk, facing right aiming Downright
DB $00, $0C, $01, $03 
DB $02, $06, $01, $04 
DB $02, $06, $01, $17 
DB $00, $0C, $01, $00 
DB $02, $06, $01, $05 
DB $02, $06, $01, $18

;E4B0
AFP_T35:;Crouch transition, facing right
AFP_T3B:;Standing from crouching, facing right
DB $00, $10, $01, $06

;E4B4
AFP_T36:;Crouch transition, facing left
AFP_T3C:;Standing from crouching, facing left
DB $00, $11, $01, $07

;E4B8
AFP_T37:;Morphing into ball, facing right. Ground and mid-air
DB $0B, $06, $00, $00 
DB $0B, $05, $00, $00

;E4C0
AFP_T38:;Morphing into ball, facing left. Ground and mid-air
DB $0B, $04, $00, $00 
DB $0B, $03, $00, $00

;E4C8
AFP_T3D:;Demorph while facing right. Mid-air and on ground
DB $0B, $05, $00, $00 
DB $0B, $06, $00, $00

;E4D0
AFP_T3E:;Demorph while facing left. Mid-air and on ground
DB $0B, $03, $00, $00 
DB $0B, $04, $00, $00

;E4D8
AFP_TDB:;Standing transition to morphball, facing right? Unused?
DB $00, $10, $01, $06 
DB $0B, $06, $00, $00 
DB $0B, $05, $00, $00

;E4E4
AFP_TDC:;Standing transition to morphball, facing left? Unused?
DB $00, $11, $01, $06 
DB $0B, $04, $00, $00 
DB $0B, $03, $00, $00

;E4F0
AFP_TDD:;Morphball transition to standing, facing right? Unused?
DB $0B, $05, $00, $00 
DB $0B, $06, $00, $00 
DB $00, $10, $01, $06

;E4FC
AFP_TDE:;Morphball transition to standing, facing left? Unused?
DB $0B, $03, $00, $00 
DB $0B, $04, $00, $00 
DB $00, $11, $01, $06

;E508
AFP_T1D:;Facing right as morphball, no springball
AFP_T31:;Midair morphball facing right without springball
AFP_T32:;Midair morphball facing left without springball
AFP_T3F:;Some transition with morphball, facing right. Maybe unused
AFP_T40:;Some transition with morphball, facing left. Maybe unused
DB $0A, $00, $00, $00 
DB $0A, $04, $00, $00 
DB $0A, $01, $00, $00 
DB $0A, $05, $00, $00 
DB $0A, $02, $00, $00 
DB $0A, $06, $00, $00 
DB $0A, $03, $00, $00 
DB $0A, $07, $00, $00 
DB $00, $00, $00, $00 
DB $0B, $01, $00, $00

;E530
AFP_T41:;Staying still with morphball, facing left, no springball
AFP_TC5:;Morph ball, facing right. Unused? (Grabbed by Draygon movement)
AFP_TDF:;Samus is facing left as a morphball. Unused? (Grabbed by Draygon movement)
DB $0A, $07, $00, $00 
DB $0A, $03, $00, $00 
DB $0A, $06, $00, $00 
DB $0A, $02, $00, $00 
DB $0A, $05, $00, $00 
DB $0A, $01, $00, $00 
DB $0A, $04, $00, $00 
DB $0A, $00, $00, $00 
DB $00, $00, $00, $00 
DB $0B, $01, $00, $00

;E558
AFP_T1E:;Moving right as a morphball on ground without springball
DB $0A, $00, $00, $00 
DB $0A, $04, $00, $00 
DB $0A, $01, $00, $00 
DB $0A, $05, $00, $00 
DB $0A, $02, $00, $00 
DB $0A, $06, $00, $00 
DB $0A, $03, $00, $00 
DB $0A, $07, $00, $00 
DB $00, $00, $00, $00 
DB $0B, $01, $00, $00

;E580
AFP_T1F:;Moving left as a morphball on ground without springball
DB $0A, $07, $00, $00 
DB $0A, $03, $00, $00 
DB $0A, $06, $00, $00 
DB $0A, $02, $00, $00 
DB $0A, $05, $00, $00 
DB $0A, $01, $00, $00 
DB $0A, $04, $00, $00 
DB $0A, $00, $00, $00 
DB $00, $00, $00, $00 
DB $0B, $01, $00, $00

;E5A8
AFP_T79:;Spring ball on ground, facing right
AFP_T7B:;Spring ball on ground, moving right
AFP_T7D:;Spring ball falling, facing/moving right
AFP_T7F:;Spring ball jump in air, facing/moving right
DB $0A, $00, $00, $00 
DB $0A, $04, $00, $00 
DB $0A, $01, $00, $00 
DB $0A, $05, $00, $00 
DB $0A, $02, $00, $00 
DB $0A, $06, $00, $00 
DB $0A, $03, $00, $00 
DB $0A, $07, $00, $00 
DB $00, $00, $00, $00 
DB $0B, $01, $00, $00

;E5D0
AFP_T7A:;Spring ball on ground, facing left
AFP_T7C:;Spring ball on ground, moving left
AFP_T7E:;Spring ball falling, facing/moving left
AFP_T80:;Spring ball jump in air, facing/moving left
DB $0A, $07, $00, $00 
DB $0A, $03, $00, $00 
DB $0A, $06, $00, $00 
DB $0A, $02, $00, $00 
DB $0A, $05, $00, $00 
DB $0A, $01, $00, $00 
DB $0A, $04, $00, $00 
DB $0A, $00, $00, $00 
DB $00, $00, $00, $00 
DB $0B, $01, $00, $00

;E5F8
AFP_T19:;Spin jump right
AFP_T20:;Spinjump right. Unused?
AFP_T21:;Spinjump right. Unused?
AFP_T22:;Spinjump right. Unused?
AFP_T23:;Spinjump right. Unused?
AFP_T24:;Spinjump right. Unused?
AFP_T33:;Spinjump right. Unused?
AFP_T34:;Spinjump right. Unused?
AFP_T39:;Midair morphing into ball, facing right? May be unused
AFP_T3A:;Midair morphing into ball, facing left? May be unused
AFP_T42:;Spinjump right. Unused?
DB $02, $04, $01, $19 
DB $0A, $08, $00, $00 
DB $0A, $09, $00, $00 
DB $0A, $0A, $00, $00 
DB $0A, $0B, $00, $00 
DB $0A, $0C, $00, $00 
DB $0A, $0D, $00, $00 
DB $0A, $0E, $00, $00 
DB $0A, $0F, $00, $00 
DB $00, $00, $00, $00 
DB $00, $00, $00, $00 
DB $01, $1C, $00, $1E

;E628
AFP_T1A:;Spin jump left
DB $02, $05, $01, $1A 
DB $0A, $08, $00, $00 
DB $0A, $09, $00, $00 
DB $0A, $0A, $00, $00 
DB $0A, $0B, $00, $00 
DB $0A, $0C, $00, $00 
DB $0A, $0D, $00, $00 
DB $0A, $0E, $00, $00 
DB $0A, $0F, $00, $00 
DB $00, $00, $00, $00 
DB $00, $00, $00, $00 
DB $01, $1D, $00, $1F

;E658
AFP_T1B:;Space jump right
DB $02, $04, $01, $19 
DB $0A, $14, $09, $00 
DB $0A, $14, $09, $01 
DB $0A, $14, $09, $02 
DB $0A, $14, $09, $03 
DB $0A, $14, $09, $04 
DB $0A, $14, $09, $05 
DB $0A, $14, $09, $06 
DB $0A, $14, $09, $07 
DB $00, $00, $00, $00 
DB $00, $00, $00, $00 
DB $01, $1C, $00, $1E

;E688
AFP_T1C:;Space jump left
DB $02, $05, $01, $1A 
DB $0A, $14, $09, $00 
DB $0A, $14, $09, $01 
DB $0A, $14, $09, $02 
DB $0A, $14, $09, $03 
DB $0A, $14, $09, $04 
DB $0A, $14, $09, $05 
DB $0A, $14, $09, $06 
DB $0A, $14, $09, $07 
DB $00, $00, $00, $00 
DB $00, $00, $00, $00 
DB $01, $1D, $00, $1F

;E6B8
AFP_T81:;Screw attack right
DB $02, $04, $01, $19 
DB $0A, $10, $09, $00 
DB $0A, $10, $09, $01 
DB $0A, $10, $09, $02 
DB $0A, $14, $09, $03 
DB $0A, $14, $09, $04 
DB $0A, $14, $09, $05 
DB $0A, $11, $09, $06 
DB $0A, $11, $09, $07 
DB $0A, $11, $09, $00 
DB $0A, $14, $09, $01 
DB $0A, $14, $09, $02 
DB $0A, $14, $09, $03 
DB $0A, $12, $09, $04 
DB $0A, $12, $09, $05 
DB $0A, $12, $09, $06 
DB $0A, $14, $09, $07 
DB $0A, $14, $09, $00 
DB $0A, $14, $09, $01 
DB $0A, $13, $09, $02 
DB $0A, $13, $09, $03 
DB $0A, $13, $09, $04 
DB $0A, $14, $09, $05 
DB $0A, $14, $09, $06 
DB $0A, $14, $09, $07 
DB $00, $00, $00, $00 
DB $00, $00, $00, $00 
DB $01, $1C, $00, $1E

;E728
AFP_T82:;Screw attack left
DB $02, $05, $01, $1A 
DB $0A, $10, $09, $00 
DB $0A, $10, $09, $01 
DB $0A, $10, $09, $02 
DB $0A, $14, $09, $03 
DB $0A, $14, $09, $04 
DB $0A, $14, $09, $05 
DB $0A, $11, $09, $06 
DB $0A, $11, $09, $07 
DB $0A, $11, $09, $00 
DB $0A, $14, $09, $01 
DB $0A, $14, $09, $02 
DB $0A, $14, $09, $03 
DB $0A, $12, $09, $04 
DB $0A, $12, $09, $05 
DB $0A, $12, $09, $06 
DB $0A, $14, $09, $07 
DB $0A, $14, $09, $00 
DB $0A, $14, $09, $01 
DB $0A, $13, $09, $02 
DB $0A, $13, $09, $03 
DB $0A, $13, $09, $04 
DB $0A, $14, $09, $05 
DB $0A, $14, $09, $06 
DB $0A, $14, $09, $07 
DB $00, $00, $00, $00 
DB $00, $00, $00, $00 
DB $01, $1D, $00, $1F

;E798
AFP_T25:;starting standing right, turning left
AFP_TBF:;jump/Turn right to left while moonwalking.
AFP_TC6:;Morph ball, facing left. Unused? (Grabbed by Draygon movement)
DB $01, $07, $00, $16 
DB $01, $0A, $01, $01 
DB $01, $06, $00, $15

;E7A4
AFP_T26:;starting standing left, turning right
AFP_TC0:;jump/Turn left to right while moonwalking.
DB $01, $06, $00, $15 
DB $01, $0A, $01, $01 
DB $01, $07, $00, $16

;E7B0
AFP_T8B:;Turning around from right to left while aiming straight up while standing
AFP_T9C:;Turning around from right to left while aiming diagonal up while standing
AFP_TC1:;jump/Turn right to left while moonwalking and aiming diagonal up.
DB $01, $09, $00, $16 
DB $01, $02, $01, $01 
DB $01, $08, $00, $15

;E7BC
AFP_T8C:;Turning around from left to right while aiming straight up while standing
AFP_T9D:;Turning around from left to right while aiming diagonal up while standing
AFP_TC2:;jump/Turn left to right while moonwalking and aiming diagonal up.
DB $01, $08, $00, $15 
DB $01, $02, $01, $01 
DB $01, $09, $00, $16

;E7C8
AFP_T8D:;Turn around from right to left while aiming diagonal Down while standing
AFP_TC3:;jump/Turn right to left while moonwalking and aiming diagonal Down.
DB $01, $19, $00, $16 
DB $01, $03, $01, $01 
DB $01, $18, $00, $15

;E7D4
AFP_T8E:;Turn around from left to right while aiming diagonal Down while standing
AFP_TC4:;jump/Turn left to right while moonwalking and aiming diagonal Down.
DB $01, $18, $00, $15 
DB $01, $03, $01, $01 
DB $01, $19, $00, $16

;E7E0
AFP_T2F:;starting with normal jump facing right, turning left
AFP_T43:;starting from crouching right, turning left
AFP_T87:;Turning from right to left while falling
DB $01, $07, $00, $18 
DB $01, $0A, $01, $02 
DB $01, $06, $00, $17

;E7EC
AFP_T30:;starting with normal jump facing left, turning right
AFP_T44:;starting from crouching left, turning right
AFP_T88:;Turning from left to right while falling
DB $01, $06, $00, $17 
DB $01, $0A, $01, $02 
DB $01, $07, $00, $18

;E7F8
AFP_T8F:;Turning around from right to left while aiming straight up in mida
AFP_T93:;Turning around from right to left while aiming straight up while falling
AFP_T97:;Turning around from right to left while aiming straight up while crouching
AFP_T9E:;Turning around from right to left while aiming diagonal up in midair
AFP_TA0:;Turning around from right to left while aiming diagonal up while falling
AFP_TA2:;Turn around from right to left while aiming diagonal up while crouching
DB $01, $09, $00, $18 
DB $01, $02, $01, $02 
DB $01, $08, $00, $17

;E804
AFP_T90:;Turning around from left to right while aiming straight up in midair
AFP_T94:;Turning around from left to right while aiming straight up while falling
AFP_T98:;Turning around from left to right while aiming straight up while crouching
AFP_T9F:;Turning around from left to right while aiming diagonal up in midair
AFP_TA1:;Turning around from left to right while aiming diagonal up while falling
AFP_TA3:;Turn around from left to right while aiming diagonal up while crouching
DB $01, $08, $00, $17 
DB $01, $02, $01, $02 
DB $01, $09, $00, $18

;E810
AFP_T91:;Turning around from right to left while aiming Down or diagonal Down in midair
AFP_T95:;Turning around from right to left while aiming Down or diagonal Down while fallin
AFP_T99:;Turning around from right to left while aiming diagonal Down while crouching
DB $01, $19, $00, $18 
DB $01, $03, $01, $02 
DB $01, $18, $00, $17

;E81C
AFP_T92:;Turning around from left to right while aiming Down or diagonal Down in midair
AFP_T96:;Turning around from left to right while aiming Down or diagonal Down while falling
AFP_T9A:;Turning around from left to right while aiming diagonal Down while crouching
DB $01, $18, $00, $17 
DB $01, $03, $01, $02 
DB $01, $19, $00, $18

;E828
AFP_TEC:;Grabbed by Draygon, facing right. Not moving
DB $02, $04, $01, $1B

;E82C
AFP_TED:;Grabbed by Draygon, facing right aiming upright. Not moving
DB $00, $1A, $01, $1B

;E830
AFP_TEE:;Grabbed by Draygon, facing right and firing.
DB $00, $10, $01, $1B

;E834
AFP_TEF:;Grabbed by Draygon, facing right aiming Downright. Not moving
DB $00, $0C, $01, $1B

;E838
AFP_TBA:;Grabbed by Draygon, facing left, not moving
DB $02, $05, $01, $1C

;E83C
AFP_TBB:;Grabbed by Draygon, facing left aiming upleft, not moving
DB $00, $1B, $01, $1C

;E840
AFP_TBC:;Grabbed by Draygon, facing left and firing
DB $00, $11, $01, $1C

;E844
AFP_TBD:;Grabbed by Draygon, facing left aiming Downleft, not moving
DB $00, $0D, $01, $1C

;E848
AFP_TF0:;Grabbed by Draygon, facing right. Moving
DB $00, $01, $01, $0C 
DB $00, $02, $01, $1B 
DB $00, $00, $01, $19 
DB $00, $04, $01, $0C 
DB $00, $05, $01, $0E 
DB $00, $00, $01, $08

;E860 
AFP_TBE:;Grabbed by Draygon, facing left, moving
DB $00, $07, $01, $0D 
DB $00, $08, $01, $1C 
DB $00, $06, $01, $1A 
DB $00, $0A, $01, $0D 
DB $00, $0B, $01, $0F 
DB $00, $06, $01, $09

;E878
AFP_TCB:;Vertical super jump, facing right
DB $0C, $00, $00, $00

;E87C
AFP_TCC:;Vertical super jump, facing left
DB $0C, $01, $00, $00

;E880
AFP_TC9:;Horizontal super jump, right
DB $01, $14, $00, $1B

;E884
AFP_TCA:;Horizontal super jump, left
DB $01, $15, $00, $1C

;E888
AFP_TCD:;Diagonal super jump, right
DB $01, $14, $00, $1B

;E88C
AFP_TCE:;Diagonal super jump, left
DB $01, $15, $00, $1C

;E890
AFP_TD3:;Crystal flash, facing right
DB $0B, $05, $07, $00 
DB $0B, $06, $07, $01 
DB $0C, $05, $07, $02 
DB $0B, $06, $07, $02 
DB $00, $00, $00, $00 
DB $00, $00, $00, $00 
DB $0C, $05, $07, $02 
DB $0C, $06, $07, $02 
DB $0C, $07, $07, $02 
DB $0C, $06, $07, $02 
DB $00, $00, $00, $00 
DB $00, $00, $00, $00 
DB $0B, $06, $07, $01 
DB $0B, $06, $07, $00 
DB $00, $10, $01, $06

;E8CC
AFP_TD4:;Crystal flash, facing left
DB $0B, $03, $07, $00 
DB $0B, $04, $07, $01 
DB $0C, $02, $07, $02 
DB $0B, $04, $07, $02 
DB $00, $00, $00, $00 
DB $00, $00, $00, $00 
DB $0C, $02, $07, $02 
DB $0C, $03, $07, $02 
DB $0C, $04, $07, $02 
DB $0C, $03, $07, $02 
DB $00, $00, $00, $00 
DB $00, $00, $00, $00 
DB $0B, $04, $07, $01 
DB $0B, $04, $07, $00 
DB $00, $11, $01, $07

;E908
AFP_TD7:;Crystal flash ending, facing right
DB $0A, $00, $01, $06 
DB $0B, $05, $01, $06 
DB $0B, $06, $01, $06 
DB $00, $10, $01, $06 
DB $00, $1D, $01, $0C 
DB $00, $1D, $01, $1B

;E920
AFP_TD8:;Crystal flash ending, facing left
DB $0A, $1F, $01, $06 
DB $0B, $03, $01, $06 
DB $0B, $04, $01, $06 
DB $00, $11, $01, $07 
DB $00, $1C, $01, $0D 
DB $00, $1C, $01, $1C

;E938
AFP_TE8:;Samus exhausted(Metroid drain, MB attack), facing right
DB $0A, $00, $01, $06 
DB $0B, $05, $01, $06 
DB $0B, $06, $01, $06 
DB $00, $1D, $01, $0C 
DB $00, $1D, $01, $0C 
DB $00, $1D, $01, $0C 
DB $00, $1D, $01, $0C 
DB $00, $1D, $01, $0C 
DB $07, $03, $01, $1F 
DB $07, $04, $01, $1F 
DB $07, $05, $01, $1F 
DB $07, $04, $01, $1F 
DB $00, $00, $00, $00 
DB $00, $00, $00, $00 
DB $00, $10, $01, $06

;E974
AFP_TE9:;Samus exhausted(Metroid drain, MB attack), facing left
DB $0B, $03, $01, $06 
DB $0B, $04, $01, $06 
DB $00, $1C, $01, $0D 
DB $00, $1C, $01, $0D 
DB $00, $1C, $01, $0D 
DB $00, $1C, $01, $0D 
DB $00, $1C, $01, $0D 
DB $07, $01, $01, $07 
DB $07, $00, $01, $1E 
DB $07, $01, $01, $1E 
DB $07, $02, $01, $1E 
DB $07, $01, $01, $1E 
DB $00, $00, $00, $00 
DB $00, $00, $00, $00 
DB $07, $01, $01, $1A 
DB $07, $07, $01, $07 
DB $02, $03, $0A, $01 
DB $00, $00, $00, $00 
DB $00, $00, $00, $00 
DB $07, $01, $01, $1A 
DB $07, $07, $01, $07 
DB $02, $03, $0A, $01 
DB $07, $07, $01, $07 
DB $07, $01, $01, $1A 
DB $00, $00, $00, $00 
DB $00, $00, $00, $00 
DB $07, $00, $01, $1E 
DB $00, $00, $00, $00 
DB $00, $00, $00, $00 
DB $07, $00, $01, $1E 
DB $00, $00, $00, $00 
DB $00, $00, $00, $00

;E9F4
AFP_TEA:;Samus exhausted, looking up to watch Metroid attack MB, facing right
DB $07, $09, $01, $1F 
DB $07, $0A, $01, $1F 
DB $07, $0B, $01, $1F 
DB $07, $0A, $01, $1F 
DB $00, $00, $00, $00 
DB $00, $10, $01, $06

;EA0C
AFP_TEB:;Samus exhausted, looking up to watch Metroid attack MB, facing left
DB $07, $06, $01, $1E 
DB $07, $07, $01, $1E 
DB $07, $08, $01, $1E 
DB $07, $07, $01, $1E 
DB $00, $00, $00, $00 
DB $00, $11, $01, $07

;EA24
AFP_T00:;Facing forward, ala Elevator pose (power suit)
DB $01, $11, $00, $0C 
DB $00, $00, $00, $00 
DB $08, $02, $08, $00 
DB $08, $00, $08, $00 
DB $08, $03, $08, $00 
DB $08, $00, $08, $00 
DB $08, $04, $08, $00 
DB $08, $00, $08, $00 
DB $08, $02, $08, $00 
DB $08, $00, $08, $00 
DB $08, $03, $08, $00 
DB $08, $00, $08, $00 
DB $08, $04, $08, $00 
DB $08, $00, $08, $00 
DB $08, $02, $08, $00 
DB $08, $00, $08, $00 
DB $08, $03, $08, $00 
DB $08, $00, $08, $00 
DB $08, $04, $08, $00 
DB $08, $00, $08, $00 
DB $08, $02, $08, $00 
DB $08, $00, $08, $00 
DB $08, $03, $08, $00 
DB $08, $00, $08, $00 
DB $08, $04, $08, $00 
DB $08, $00, $08, $00 
DB $08, $02, $08, $00 
DB $08, $00, $08, $00 
DB $08, $03, $08, $00 
DB $08, $00, $08, $00 
DB $08, $04, $08, $00 
DB $08, $00, $08, $00 
DB $08, $02, $08, $00 
DB $08, $00, $08, $00 
DB $08, $03, $08, $00 
DB $08, $00, $08, $00 
DB $08, $04, $08, $00 
DB $08, $00, $08, $00 
DB $08, $02, $08, $00 
DB $08, $00, $08, $00 
DB $08, $03, $08, $00 
DB $08, $00, $08, $00 
DB $08, $04, $08, $00 
DB $08, $00, $08, $00 
DB $08, $02, $08, $00 
DB $08, $00, $08, $00 
DB $08, $03, $08, $00 
DB $08, $00, $08, $00 
DB $08, $04, $08, $00 
DB $08, $00, $08, $00 
DB $08, $02, $08, $00 
DB $08, $00, $08, $00 
DB $08, $03, $08, $00 
DB $08, $00, $08, $00 
DB $08, $04, $08, $00 
DB $08, $00, $08, $00 
DB $08, $02, $08, $00 
DB $08, $00, $08, $00 
DB $08, $03, $08, $00 
DB $08, $00, $08, $00 
DB $08, $04, $08, $00 
DB $08, $00, $08, $00 
DB $08, $02, $08, $00 
DB $08, $00, $08, $00 
DB $08, $03, $08, $00 
DB $08, $00, $08, $00 
DB $08, $04, $08, $00 
DB $08, $00, $08, $00 
DB $08, $02, $08, $00 
DB $08, $00, $08, $00 
DB $08, $03, $08, $00 
DB $08, $00, $08, $00 
DB $08, $04, $08, $00 
DB $08, $00, $08, $00 
DB $08, $02, $08, $00 
DB $08, $00, $08, $00 
DB $08, $03, $08, $00 
DB $08, $00, $08, $00 
DB $08, $04, $08, $00 
DB $08, $00, $08, $00 
DB $08, $05, $08, $00 
DB $08, $00, $08, $00 
DB $08, $06, $08, $00 
DB $08, $00, $08, $00 
DB $08, $07, $08, $00 
DB $08, $00, $08, $00 
DB $08, $08, $08, $00 
DB $08, $00, $08, $00 
DB $08, $09, $08, $00 
DB $08, $00, $08, $00 
DB $08, $07, $08, $00 
DB $08, $00, $08, $00 
DB $08, $08, $08, $00 
DB $08, $00, $08, $00 
DB $08, $09, $08, $00 
DB $08, $00, $08, $00

;EBA4
AFP_T9B:;Facing forward, ala Elevator pose (Varia and/or Gravity Suit)
DB $01, $05, $00, $0D 
DB $00, $00, $00, $00 
DB $08, $02, $08, $01 
DB $08, $00, $08, $01 
DB $08, $03, $08, $01 
DB $08, $00, $08, $01 
DB $08, $04, $08, $01 
DB $08, $00, $08, $01 
DB $08, $02, $08, $01 
DB $08, $00, $08, $01 
DB $08, $03, $08, $01 
DB $08, $00, $08, $01 
DB $08, $04, $08, $01 
DB $08, $00, $08, $01 
DB $08, $02, $08, $01 
DB $08, $00, $08, $01 
DB $08, $03, $08, $01 
DB $08, $00, $08, $01 
DB $08, $04, $08, $01 
DB $08, $00, $08, $01 
DB $08, $02, $08, $01 
DB $08, $00, $08, $01 
DB $08, $03, $08, $01 
DB $08, $00, $08, $01 
DB $08, $04, $08, $01 
DB $08, $00, $08, $01 
DB $08, $02, $08, $01 
DB $08, $00, $08, $01 
DB $08, $03, $08, $01 
DB $08, $00, $08, $01 
DB $08, $04, $08, $01 
DB $08, $00, $08, $01 
DB $08, $02, $08, $01 
DB $08, $00, $08, $01 
DB $08, $03, $08, $01 
DB $08, $00, $08, $01 
DB $08, $04, $08, $01 
DB $08, $00, $08, $01 
DB $08, $02, $08, $01 
DB $08, $00, $08, $01 
DB $08, $03, $08, $01 
DB $08, $00, $08, $01 
DB $08, $04, $08, $01 
DB $08, $00, $08, $01 
DB $08, $02, $08, $01 
DB $08, $00, $08, $01 
DB $08, $03, $08, $01 
DB $08, $00, $08, $01 
DB $08, $04, $08, $01 
DB $08, $00, $08, $01 
DB $08, $02, $08, $01 
DB $08, $00, $08, $01 
DB $08, $03, $08, $01 
DB $08, $00, $08, $01 
DB $08, $04, $08, $01 
DB $08, $00, $08, $01 
DB $08, $02, $08, $01 
DB $08, $00, $08, $01 
DB $08, $03, $08, $01 
DB $08, $00, $08, $01 
DB $08, $04, $08, $01 
DB $08, $00, $08, $01 
DB $08, $02, $08, $01 
DB $08, $00, $08, $01 
DB $08, $03, $08, $01 
DB $08, $00, $08, $01 
DB $08, $04, $08, $01 
DB $08, $00, $08, $01 
DB $08, $02, $08, $01 
DB $08, $00, $08, $01 
DB $08, $03, $08, $01 
DB $08, $00, $08, $01 
DB $08, $04, $08, $01 
DB $08, $00, $08, $01 
DB $08, $02, $08, $01 
DB $08, $00, $08, $01 
DB $08, $03, $08, $01 
DB $08, $00, $08, $01 
DB $08, $04, $08, $01 
DB $08, $00, $08, $01 
DB $08, $05, $08, $01 
DB $08, $00, $08, $01 
DB $08, $06, $08, $01 
DB $08, $00, $08, $01 
DB $08, $07, $08, $01 
DB $08, $00, $08, $01 
DB $08, $08, $08, $01 
DB $08, $00, $08, $01 
DB $08, $09, $08, $01 
DB $08, $00, $08, $01 
DB $08, $07, $08, $01 
DB $08, $00, $08, $01 
DB $08, $08, $08, $01 
DB $08, $00, $08, $01 
DB $08, $09, $08, $01 
DB $08, $00, $08, $01 

;$92ED24 - $92EDF3 = code
;$92EDF4 - $92FFFF = freespace $120C bytes


;-----------------------------------------------------------------------------



;OAM data for arm cannon opening gfx display

;$90:C5DC	LDA $C7DF,x[$90:C7E3]
;$90:C5F7	LDA $C7D9,x[$90:C7DA]
;$90:C67F	LDA $C7DF,x[$90:C7E3]
;$90:C6BC	LDA $C791,x[$90:C79F]
;$90:C738	LDA $C7DF,x[$90:C7E3]
;$90:C75E	LDA $C7A5,x[$90:C7B3]

ORG $90C791				;OAM data - 2 byte pairs.  based on direction index of arm cannon
						;first byte is tile in VRAM to use (last tile of part2 in lower half samus gfx)
						;second byte is property bits (flip, priority, palette, etc.)
DB $1F, $28 
DB $1F, $28 
DB $1F, $28 
DB $1F, $68 
DB $1F, $A8 
DB $1F, $E8 
DB $1F, $28 
DB $1F, $68 
DB $1F, $68 
DB $1F, $68


ORG $90C7A5				;pointers to uncompressed arm cannon opening gfx in ROM (mirrored versions are defined by tile flip)
						;table is based on direction index of arm cannon (firing angle) 
						;table entries contain 2-byte pointers to location in $9A, 4 frames per entry, first frame is null
DW VUR_GFX, AUR_GFX, HR_GFX, ADR_GFX, VDR_GFX, VDL_GFX, ADL_GFX, HL_GFX, AUL_GFX, VUL_GFX

VUR_GFX:
VDR_GFX:
VDL_GFX:
VUL_GFX:
DW $0000, $9A00, $9C00, $9E00  	;vertical - up

HR_GFX:
HL_GFX:
DW $0000, $A000, $A200, $A400  	;horizontal - right

ADR_GFX:
ADL_GFX:
DW $0000, $A600, $A800, $AA00  	;angled - down left

AUR_GFX:
AUL_GFX:
DW $0000, $AC00, $AE00, $B000 	;angled - up right


if !BombLauncher_Ob == 0
ORG $90C7D9             ;which HUD selection the arm cannon should open for
DB $00, $01, $01, $00, $01, $00 
endif


ORG $90C7DF             ;pose table pointers for x/y offsets for arm cannon during animation
DW XY_P00, XY_P01, XY_P02, XY_P03, XY_P04, XY_P05, XY_P06, XY_P07, XY_P08, XY_P09, XY_P0A, XY_P0B, XY_P0C, XY_P0D, XY_P0E, XY_P0F
DW XY_P10, XY_P11, XY_P12, XY_P13, XY_P14, XY_P15, XY_P16, XY_P17, XY_P18, XY_P19, XY_P1A, XY_P1B, XY_P1C, XY_P1D, XY_P1E, XY_P1F
DW XY_P20, XY_P21, XY_P22, XY_P23, XY_P24, XY_P25, XY_P26, XY_P27, XY_P28, XY_P29, XY_P2A, XY_P2B, XY_P2C, XY_P2D, XY_P2E, XY_P2F
DW XY_P30, XY_P31, XY_P32, XY_P33, XY_P34, XY_P35, XY_P36, XY_P37, XY_P38, XY_P39, XY_P3A, XY_P3B, XY_P3C, XY_P3D, XY_P3E, XY_P3F
DW XY_P40, XY_P41, XY_P42, XY_P43, XY_P44, XY_P45, XY_P46, XY_P47, XY_P48, XY_P49, XY_P4A, XY_P4B, XY_P4C, XY_P4D, XY_P4E, XY_P4F
DW XY_P50, XY_P51, XY_P52, XY_P53, XY_P54, XY_P55, XY_P56, XY_P57, XY_P58, XY_P59, XY_P5A, XY_P5B, XY_P5C, XY_P5D, XY_P5E, XY_P5F
DW XY_P60, XY_P61, XY_P62, XY_P63, XY_P64, XY_P65, XY_P66, XY_P67, XY_P68, XY_P69, XY_P6A, XY_P6B, XY_P6C, XY_P6D, XY_P6E, XY_P6F
DW XY_P70, XY_P71, XY_P72, XY_P73, XY_P74, XY_P75, XY_P76, XY_P77, XY_P78, XY_P79, XY_P7A, XY_P7B, XY_P7C, XY_P7D, XY_P7E, XY_P7F
DW XY_P80, XY_P81, XY_P82, XY_P83, XY_P84, XY_P85, XY_P86, XY_P87, XY_P88, XY_P89, XY_P8A, XY_P8B, XY_P8C, XY_P8D, XY_P8E, XY_P8F
DW XY_P90, XY_P91, XY_P92, XY_P93, XY_P94, XY_P95, XY_P96, XY_P97, XY_P98, XY_P99, XY_P9A, XY_P9B, XY_P9C, XY_P9D, XY_P9E, XY_P9F
DW XY_PA0, XY_PA1, XY_PA2, XY_PA3, XY_PA4, XY_PA5, XY_PA6, XY_PA7, XY_PA8, XY_PA9, XY_PAA, XY_PAB, XY_PAC, XY_PAD, XY_PAE, XY_PAF
DW XY_PB0, XY_PB1, XY_PB2, XY_PB3, XY_PB4, XY_PB5, XY_PB6, XY_PB7, XY_PB8, XY_PB9, XY_PBA, XY_PBB, XY_PBC, XY_PBD, XY_PBE, XY_PBF
DW XY_PC0, XY_PC1, XY_PC2, XY_PC3, XY_PC4, XY_PC5, XY_PC6, XY_PC7, XY_PC8, XY_PC9, XY_PCA, XY_PCB, XY_PCC, XY_PCD, XY_PCE, XY_PCF
DW XY_PD0, XY_PD1, XY_PD2, XY_PD3, XY_PD4, XY_PD5, XY_PD6, XY_PD7, XY_PD8, XY_PD9, XY_PDA, XY_PDB, XY_PDC, XY_PDD, XY_PDE, XY_PDF
DW XY_PE0, XY_PE1, XY_PE2, XY_PE3, XY_PE4, XY_PE5, XY_PE6, XY_PE7, XY_PE8, XY_PE9, XY_PEA, XY_PEB, XY_PEC, XY_PED, XY_PEE, XY_PEF
DW XY_PF0, XY_PF1, XY_PF2, XY_PF3, XY_PF4, XY_PF5, XY_PF6, XY_PF7, XY_PF8, XY_PF9, XY_PFA, XY_PFB, XY_PFC

;OAM x/y positioning of arm cannon opening gfx relative to Samus
;first byte - if high nybble is negative ($80+), use 2nd argument
;             if positive use as arm cannon firing direction index (00-09)
;second byte - unknown purpose
;second argument - first byte - high nybble is ignored, low nybble used as arm cannon firing direction index
;                  second byte unknown purpose
;string of bytes after opening argument/s are x/y offset pairs

;c9d9 - null pointer for poses where armcannon opening is not displayed
XY_P09:		;09:;Moving right, not aiming
XY_P0A:		;0A:;Moving left, not aiming
XY_P0D:		;0D:;Moving right, aiming straight up (unused?)
XY_P0E:		;0E:;Moving left, aiming straight up (unused?)
XY_P19:		;19:;Spin jump right
XY_P1A:		;1A:;Spin jump left
XY_P1B:		;1B:;Space jump right
XY_P1C:		;1C:;Space jump left
XY_P1D:		;1D:;Facing right as morphball, no springball
XY_P1E:		;1E:;Moving right as a morphball on ground without springball
XY_P1F:		;1F:;Moving left as a morphball on ground without springball
XY_P20:		;20:;Spinjump right. Unused?
XY_P21:		;21:;Spinjump right. Unused?
XY_P22:		;22:;Spinjump right. Unused?
XY_P23:		;23:;Spinjump right. Unused?
XY_P24:		;24:;Spinjump right. Unused?
XY_P25:		;25:;starting standing right, turning left
XY_P26:		;26:;starting standing left, turning right
XY_P29:		;29:;Falling facing right, normal pose
XY_P2A:		;2A:;Falling facing left, normal pose
XY_P2F:		;2F:;starting with normal jump facing right, turning left
XY_P30:		;30:;starting with normal jump facing left, turning right
XY_P31:		;31:;Midair morphball facing right without springball
XY_P32:		;32:;Midair morphball facing left without springball
XY_P33:		;33:;Spinjump right. Unused?
XY_P34:		;34:;Spinjump right. Unused?
XY_P35:		;35:;Crouch transition, facing right
XY_P36:		;36:;Crouch transition, facing left
XY_P37:		;37:;Morphing into ball, facing right. Ground and mid-air
XY_P38:		;38:;Morphing into ball, facing left. Ground and mid-air
XY_P39:		;39:;Midair morphing into ball, facing right? May be unused
XY_P3A:		;3A:;Midair morphing into ball, facing left? May be unused
XY_P3B:		;3B:;Standing from crouching, facing right
XY_P3C:		;3C:;Standing from crouching, facing left
XY_P3D:		;3D:;Demorph while facing right. Mid-air and on ground
XY_P3E:		;3E:;Demorph while facing left. Mid-air and on ground
XY_P3F:		;3F:;Some transition with morphball, facing right. Maybe unused
XY_P40:		;40:;Some transition with morphball, facing left. Maybe unused
XY_P41:		;41:;Staying still with morphball, facing left, no springball
XY_P42:		;42:;Spinjump right. Unused?
XY_P43:		;43:;starting from crouching right, turning left
XY_P44:		;44:;starting from crouching left, turning right
XY_P45:		;45:;running, facing right, shooting left. Unused? (Fast moonwalk)
XY_P46:		;46:;running, facing left, shooting right. Unused? (Fast moonwalk)
XY_P4C:		;4C:;Normal jump transition from ground(standing or crouching), facing left
XY_P4D:		;4D:;Normal jump facing right, gun not extended, not aiming, not moving
XY_P4E:		;4E:;Normal jump facing left, gun not extended, not aiming, not moving
XY_P4F:		;4F:;Hurt roll back, moving right/facing left
XY_P50:		;50:;Hurt roll back, moving left/facing right
XY_P53:		;53:;Hurt, facing right
XY_P54:		;54:;Hurt, facing left
XY_P5B:		;5B:;Something for grapple (wall jump?), probably unused
XY_P5C:		;5C:;Something for grapple (wall jump?), probably unused
XY_P5D:		;5D:;Broken grapple? Facing clockwise, maybe unused
XY_P5E:		;5E:;Broken grapple? Facing clockwise, maybe unused
XY_P5F:		;5F:;Broken grapple? Facing clockwise, maybe unused
XY_P60:		;60:;Better broken grapple. Facing clockwise, maybe unused
XY_P61:		;61:;Nearly normal grapple. Facing clockwise, maybe unused
XY_P62:		;62:;Nearly normal grapple. Facing counterclockwise, maybe unused
XY_P63:		;63:;Facing left on grapple blocks, ready to jump. Unused?
XY_P64:		;64:;Facing right on grapple blocks, ready to jump. Unused?
XY_P65:		;65:;Glitchy jump, facing left. Used by unused grapple jump?
XY_P66:		;66:;Glitchy jump, facing right. Used by unused grapple jump?
XY_P79:		;79:;Spring ball on ground, facing right
XY_P7A:		;7A:;Spring ball on ground, facing left
XY_P7B:		;7B:;Spring ball on ground, moving right
XY_P7C:		;7C:;Spring ball on ground, moving left
XY_P7D:		;7D:;Spring ball falling, facing/moving right
XY_P7E:		;7E:;Spring ball falling, facing/moving left
XY_P7F:		;7F:;Spring ball jump in air, facing/moving right
XY_P80:		;80:;Spring ball jump in air, facing/moving left
XY_P81:		;81:;Screw attack right
XY_P82:		;82:;Screw attack left
XY_P83:		;83:;Walljump right
XY_P84:		;84:;Walljump left
XY_P87:		;87:;Turning from right to left while falling
XY_P88:		;88:;Turning from left to right while falling
XY_P8B:		;8B:;Turning around from right to left while aiming straight up while standing
XY_P8C:		;8C:;Turning around from left to right while aiming straight up while standing
XY_P8D:		;8D:;Turn around from right to left while aiming diagonal Down while standing
XY_P8E:		;8E:;Turn around from left to right while aiming diagonal Down while standing
XY_P8F:		;8F:;Turning around from right to left while aiming straight up in midair
XY_P90:		;90:;Turning around from left to right while aiming straight up in midair
XY_P91:		;91:;Turning around from right to left while aiming Down or diagonal Down in midair
XY_P92:		;92:;Turning around from left to right while aiming Down or diagonal Down in midair
XY_P93:		;93:;Turning around from right to left while aiming straight up while falling
XY_P94:		;94:;Turning around from left to right while aiming straight up while falling
XY_P95:		;95:;Turning around from right to left while aiming Down or diagonal Down while falling
XY_P96:		;96:;Turning around from left to right while aiming Down or diagonal Down while falling
XY_P97:		;97:;Turning around from right to left while aiming straight up while crouching
XY_P98:		;98:;Turning around from left to right while aiming straight up while crouching
XY_P99:		;99:;Turning around from right to left while aiming diagonal Down while crouching
XY_P9A:		;9A:;Turning around from left to right while aiming diagonal Down while crouching
XY_P9C:		;9C:;Turning around from right to left while aiming diagonal up while standing
XY_P9D:		;9D:;Turning around from left to right while aiming diagonal up while standing
XY_P9E:		;9E:;Turning around from right to left while aiming diagonal up in midair
XY_P9F:		;9F:;Turning around from left to right while aiming diagonal up in midair
XY_PA0:		;A0:;Turning around from right to left while aiming diagonal up while falling
XY_PA1:		;A1:;Turning around from left to right while aiming diagonal up while falling
XY_PA2:		;A2:;Turn around from right to left while aiming diagonal up while crouching
XY_PA3:		;A3:;Turn around from left to right while aiming diagonal up while crouching
XY_PA5:		;A5:;Landing from normal jump, facing left
XY_PA7:		;A7:;Landing from spin jump, facing left
XY_PB2:		;B2:;Grapple, facing clockwise
XY_PB3:		;B3:;Grapple, facing counterclockwise
XY_PB8:		;B8:;Grapple, attached to a wall on right, facing left
XY_PB9:		;B9:;Grapple, attached to a wall on left, facing right
XY_PBA:		;BA:;Grabbed by Draygon, facing left, not moving
XY_PBE:		;BE:;Grabbed by Draygon, facing left, moving
XY_PBF:		;BF:;jump/Turn right to left while moonwalking.
XY_PC0:		;C0:;jump/Turn left to right while moonwalking.
XY_PC1:		;C1:;jump/Turn right to left while moonwalking and aiming diagonal up.
XY_PC2:		;C2:;jump/Turn left to right while moonwalking and aiming diagonal up.
XY_PC3:		;C3:;jump/Turn right to left while moonwalking and aiming diagonal Down.
XY_PC4:		;C4:;jump/Turn left to right while moonwalking and aiming diagonal Down.
XY_PC5:		;C5:;Morph ball, facing right. Unused? (Grabbed by Draygon movement)
XY_PC6:		;C6:;Morph ball, facing left. Unused? (Grabbed by Draygon movement)
XY_PC7:		;C7:;Super jump windup, facing right
XY_PC8:		;C8:;Super jump windup, facing left
XY_PC9:		;C9:;Horizontal super jump, right
XY_PCA:		;CA:;Horizontal super jump, left
XY_PCB:		;CB:;Vertical super jump, facing right
XY_PCC:		;CC:;Vertical super jump, facing left
XY_PCD:		;CD:;Diagonal super jump, right
XY_PCE:		;CE:;Diagonal super jump, left
XY_PD3:		;D3:;Crystal flash, facing right
XY_PD4:		;D4:;Crystal flash, facing left
XY_PD5:		;D5:;X-raying right, standing
XY_PD6:		;D6:;X-raying left, standing
XY_PD7:		;D7:;Crystal flash ending, facing right
XY_PD8:		;D8:;Crystal flash ending, facing left
XY_PD9:		;D9:;X-raying right, crouching
XY_PDA:		;DA:;X-raying left, crouching
XY_PDB:		;DB:;Standing transition to morphball, facing right? Unused?
XY_PDC:		;DC:;Standing transition to morphball, facing left? Unused?
XY_PDD:		;DD:;Morphball transition to standing, facing right? Unused?
XY_PDE:		;DE:;Morphball transition to standing, facing left? Unused?
XY_PDF:		;DF:;Samus is facing left as a morphball. Unused? (Grabbed by Draygon movement)
XY_PE8:		;E8:;Samus exhausted(Metroid drain, MB attack), facing right
XY_PE9:		;E9:;Samus exhausted(Metroid drain, MB attack), facing left
XY_PEA:		;EA:;Samus exhausted, looking up to watch Metroid attack MB, facing right
XY_PEB:		;EB:;Samus exhausted, looking up to watch Metroid attack MB, facing left
XY_PEC:		;EC:;Grabbed by Draygon, facing right. Not moving
XY_PF0:		;F0:;Grabbed by Draygon, facing right. Moving
DB $00, $00 

;c9db
XY_P00:		;00:;Facing forward, ala Elevator pose (power suit)
XY_P9B:		;9B:;Facing forward, ala Elevator pose (Varia and/or Gravity Suit)
DB $00, $02 

;c9dd
XY_P01:		;01:;Facing right, normal
XY_P47:		;47:;Standing, facing right. Unused?
XY_P89:		;89:;Ran into a wall on right (facing right)
XY_PA8:		;A8:;Just standing, facing right. Unused? (Grapple movement)
XY_PE6:		;E6:;Landing from normal jump, facing right, firing
XY_PEE:		;EE:;Grabbed by Draygon, facing right and firing.
DB $02, $01 
DB $0B, $FD, $0B, $FD, $0B, $FD, $0B, $FD, $0B, $FD, $0B, $FD, $0B, $FD, $0B, $FD, $0B, $FD 

;c9f1
XY_P02:		;02:;Facing left, normal
XY_P48:		;48:;Standing, facing left. Unused?
XY_P8A:		;8A:;Ran into a wall on left (facing left)
XY_PA9:		;A9:;Just standing, facing left. Unused? (Grapple movement)
XY_PBC:		;BC:;Grabbed by Draygon, facing left and firing
XY_PE7:		;E7:;Landing from normal jump, facing left, firing
DB $07, $01 
DB $ED, $FD, $ED, $FD, $ED, $FD, $ED, $FD, $ED, $FD, $ED, $FD, $ED, $FD, $ED, $FD, $ED, $FD 

;ca05
XY_P03:		;03:;Facing right, aiming up
DB $81, $01 
DB $80, $01 
DB $0E, $EA, $FE, $E1 

;ca0d
XY_P04:		;04:;Facing left, aiming up
DB $88, $01 
DB $89, $01 
DB $EA, $E9, $FA, $E1 

;ca15
XY_P05:		;05:;Facing right, aiming upright
XY_P57:		;57:;Normal jump transition from ground, facing right and aiming upright
XY_PCF:		;CF:;Samus ran right into a wall, is still holding right and is now aiming diagonal up
XY_PE2:		;E2:;Landing from normal jump, facing right and aiming upright
XY_PED:		;ED:;Grabbed by Draygon, facing right aiming upright. Not moving
XY_PF3:		;F3:;Crouch transition, facing right and aiming upright
XY_PF9:		;F9:;Crouching to standing, facing right and aiming upright
DB $01, $01 
DB $0D, $EA 

;CA19
XY_P06:		;06:;Facing left, aiming upleft
XY_P58:		;58:;Normal jump transition from ground, facing left and aiming upleft
XY_PBB:		;BB:;Grabbed by Draygon, facing left aiming upleft, not moving
XY_PD0:		;D0:;Samus ran left into a wall, is still holding left and is now aiming diagonal up
XY_PE3:		;E3:;Landing from normal jump, facing left and aiming upleft
XY_PF4:		;F4:;Crouch transition, facing left and aiming upleft
XY_PFA:		;FA:;Crouching to standing, facing left and aiming upleft
DB $08, $01 
DB $EB, $E9 

;CA1D
XY_P07:		;07:;Facing right, aiming Downright
XY_P59:		;59:;Normal jump transition from ground, facing right and aiming Downright
XY_PAA:		;AA:;Just standing, facing right aiming Downright. Unused? (Grapple movement)
XY_PD1:		;D1:;Samus ran right into a wall, is still holding right and is now aiming diagonal Down
XY_PE4:		;E4:;Landing from normal jump, facing right and aiming Downright
XY_PEF:		;EF:;Grabbed by Draygon, facing right aiming Downright. Not moving
XY_PF5:		;F5:;Crouch transition, facing right and aiming Downright
XY_PFB:		;FB:;Crouching to standing, facing right and aiming Downright
DB $03, $01 
DB $0D, $02 

;CA21
XY_P08:		;08:;Facing left, aiming Downleft
XY_P5A:		;5A:;Normal jump transition from ground, facing left and aiming Downleft
XY_PAB:		;AB:;Just standing, facing left aiming Downleft. Unused? (Grapple movement)
XY_PBD:		;BD:;Grabbed by Draygon, facing left aiming Downleft, not moving
XY_PD2:		;D2:;Samus ran left into a wall, is still holding left and is now aiming diagonal Down
XY_PE5:		;E5:;Landing from normal jump, facing left and aiming Downleft
XY_PF6:		;F6:;Crouch transition, facing left and aiming Downleft
XY_PFC:		;FC:;Crouching to standing, facing left and aiming Downleft
DB $06, $01 
DB $EB, $02 

;CA25
XY_P0B:		;0B:;Moving right, gun extended forward (not aiming)
DB $02, $01 
DB $11, $FA, $11, $FA, $11, $F9, $11, $F8, $11, $F9, $11, $FA, $11, $F9, $11, $F9, $11, $F8, $11, $F9 

;CA3B
XY_P0C:		;0C:;Moving left, gun extended forward (not aiming)
DB $07, $01 
DB $E7, $FA, $E7, $FA, $E7, $F8, $E7, $F9, $E7, $F9, $E7, $FA, $E7, $F9, $E7, $F8, $E7, $F9, $E7, $F9 

;CA51
XY_P0F:		;0F:;Moving right, aiming upright
DB $01, $01 
DB $0C, $EA, $0C, $EA, $0C, $E9, $0C, $E8, $0C, $E9, $0C, $EA, $0C, $EA, $0C, $E9, $0C, $E8, $0C, $E9 

;CA67
XY_P10:		;10:;Moving left, aiming upleft
DB $08, $01 
DB $EC, $EA, $EC, $EA, $EC, $E9, $EC, $E8, $EC, $E9, $EC, $EA, $EC, $EA, $EC, $E9, $EC, $E8, $EC, $E9 

;CA7D
XY_P11:		;11:;Moving right, aiming Downright
DB $03, $01 
DB $0B, $01, $0B, $01, $0B, $00, $0B, $FF, $0B, $00, $0B, $01, $0B, $01, $0B, $00, $0B, $FF, $0B, $00 

;CA93
XY_P12:		;12:;Moving left, aiming Downleft
DB $06, $01 
DB $ED, $01, $ED, $01, $ED, $00, $ED, $FF, $ED, $00, $ED, $01, $ED, $01, $ED, $00, $ED, $FF, $ED, $00 

;CAA9
XY_P13:		;13:;Normal jump facing right, gun extended, not aiming or moving
XY_PAC:		;AC:;jumping, facing right, gun extended. Unused? (Grapple movement)
DB $02, $01 
DB $0B, $FD, $0B, $FD 

;CAAF
XY_P14:		;14:;Normal jump facing left, gun extended, not aiming or moving
XY_PAD:		;AD:;jumping, facing left, gun extended. Unused? (Grapple movement)
DB $07, $01 
DB $ED, $FD, $ED, $FD 

;CAB5
XY_P15:		;15:;Normal jump facing right, aiming up
DB $81, $01 
DB $80, $01 
DB $0E, $E9, $FE, $E0 

;CABD
XY_P16:		;16:;Normal jump facing left, aiming up
DB $88, $01 
DB $89, $01 
DB $EA, $E8, $FA, $E0 

;CAC5
XY_P17:		;17:;Normal jump facing right, aiming Down
XY_PAE:		;AE:;jumping, facing right, aiming Down. Unused? (Grapple movement)
DB $04, $01 
DB $00, $0D, $00, $0D 

;CACB
XY_P18:		;18:;Normal jump facing left, aiming Down
XY_PAF:		;AF:;jumping, facing left, aiming Down. Unused? (Grapple movement)
DB $05, $01 
DB $F7, $0D, $F7, $0D 

;CAD1
XY_P4B:		;4B:;Normal jump transition from ground(standing or crouching), facing right
DB $03, $01 
DB $FB, $00 

;CAD5		;unused?
DB $06, $02 
DB $ED, $FE 

;CAD9
XY_P51:		;51:;Normal jump facing right, moving forward (gun extended)
DB $02, $01 
DB $0B, $FD, $0B, $FD 

;CADF
XY_P52:		;52:;Normal jump facing left, moving forward (gun extended)
DB $07, $01 
DB $ED, $FD, $ED, $FD 

;CAE5
XY_P69:		;69:;Normal jump facing right, aiming upright. Moving optional
DB $01, $01 
DB $0C, $EA, $0C, $EA 

;CAEB
XY_P6A:		;6A:;Normal jump facing left, aiming upleft. Moving optional
DB $08, $01 
DB $EC, $EA, $EC, $EA 

;CAF1
XY_P6B:		;6B:;Normal jump facing right, aiming Downright. Moving optional
XY_PB0:		;B0:;jumping, facing right, aiming Downright. Unused? (Grapple movement)
DB $03, $01 
DB $0B, $01, $0B, $01 

;CAF7
XY_P6C:		;6C:;Normal jump facing left, aiming Downleft. Moving optional
XY_PB1:		;B1:;jumping, facing left, aiming Downleft. Unused? (Grapple movement)
DB $06, $01 
DB $ED, $01, $ED, $01 

;CAFD
XY_P67:		;67:;Facing right, falling, fired a shot
DB $02, $01 
DB $0B, $FD, $0B, $FD, $0B, $FD, $0B, $FD, $0B, $FD, $0B, $FD, $0B, $FD 

;CB0D
XY_P68:		;68:;Facing left, falling, fired a shot
DB $07, $01 
DB $ED, $FD, $ED, $FD, $ED, $FD, $ED, $FD, $ED, $FD, $ED, $FD, $ED, $FD 

;CB1D
XY_P2B:		;2B:;Falling facing right, aiming up
DB $81, $01 
DB $80, $01 
DB $0E, $E9, $FE, $E0, $FE, $E0 

;CB27
XY_P2C:		;2C:;Falling facing left, aiming up
DB $88, $01 
DB $89, $01 
DB $EA, $E8, $FA, $E4, $FA, $E4 

;CB31
XY_P2D:		;2D:;Falling facing right, aiming Down
DB $04, $01 
DB $00, $09, $00, $09 

;CB37
XY_P2E:		;2E:;Falling facing left, aiming Down
DB $05, $01 
DB $F7, $09, $F7, $09 

;CB3D
XY_P6D:		;6D:;Falling facing right, aiming upright
DB $01, $01 
DB $0C, $EA, $0C, $EA, $0C, $EA 

;CB45
XY_P6E:		;6E:;Falling facing left, aiming upleft
DB $08, $01 
DB $EC, $EA, $EC, $EA, $EC, $EA 

;CB4D
XY_P6F:		;6F:;Falling facing right, aiming Downright
DB $03, $01 
DB $0B, $01, $0B, $01, $0B, $01 

;CB55
XY_P70:		;70:;Falling facing left, aiming Downleft
DB $06, $01 
DB $ED, $01, $ED, $01, $ED, $01 

;CB5D
XY_P27:		;27:;Crouching, facing right
XY_PB4:		;B4:;Crouching, facing right. Unused? (Grapple movement)
DB $02, $01 
DB $0B, $FD, $0B, $FD, $0B, $FD, $0B, $FD, $0B, $FD, $0B, $FD, $0B, $FD, $0B, $FD, $0B, $FD 

;CB71
XY_P28:		;28:;Crouching, facing left
XY_PB5:		;B5:;Crouching, facing left. Unused? (Grapple movement)
DB $07, $01 
DB $ED, $FD, $ED, $FD, $ED, $FD, $ED, $FD, $ED, $FD, $ED, $FD, $ED, $FD, $ED, $FD, $ED, $FD 

;CB85
XY_P71:		;71:;Standing to crouching, facing right and aiming upright
DB $01, $01 
DB $0E, $E9 

;CB89
XY_P72:		;72:;Standing to crouching, facing left and aiming upleft
DB $08, $01 
DB $EA, $E8 

;CB8D
XY_P73:		;73:;Standing to crouching, facing right and aiming Downright
XY_PB6:		;B6:;Crouching, facing right, aiming Downright. Unused? (Grapple movement)
DB $03, $01 
DB $0D, $02 

;CB91
XY_P74:		;74:;Standing to crouching, facing left and aiming Downleft
XY_PB7:		;B7:;Crouching, facing left, aiming Downleft. Unused? (Grapple movement)
DB $06, $01 
DB $EB, $02 

;CB95
XY_P85:		;85:;Crouching, facing right aiming up
DB $81, $01 
DB $80, $01 
DB $0E, $E9, $FE, $E0 

;CB9D
XY_P86:		;86:;Crouching, facing left aiming up
DB $88, $01 
DB $89, $01 
DB $EA, $E8, $FA, $E0 

;CBA5
XY_P49:		;49:;Moonwalk, facing left
DB $02, $01 
DB $F1, $FD, $F1, $FC, $F1, $FC, $F1, $FD, $F1, $FC, $F1, $FC 

;CBB3
XY_P4A:		;4A:;Moonwalk, facing right
DB $07, $01 
DB $07, $FD, $07, $FC, $07, $FC, $07, $FD, $07, $FC, $07, $FC 

;CBC1
XY_P75:		;75:;Moonwalk, facing left aiming upleft
DB $08, $01 
DB $EC, $EA, $EC, $E9, $EC, $E9, $EC, $EA, $EC, $E9, $EC, $E9 

;CBCF
XY_P76:		;76:;Moonwalk, facing right aiming upright
DB $01, $01 
DB $0C, $EA, $0C, $E9, $0C, $E9, $0C, $EA, $0C, $E9, $0C, $E9 

;CBDD
XY_P77:		;77:;Moonwalk, facing left aiming Downleft
DB $06, $01 
DB $ED, $01, $ED, $00, $ED, $00, $ED, $01, $ED, $00, $ED, $00 

;CBEB
XY_P78:		;78:;Moonwalk, facing right aiming Downright
DB $03, $01 
DB $0B, $01, $0B, $00, $0B, $00, $0B, $01, $0B, $00, $0B, $00 

;CBF9
XY_PA4:		;A4:;Landing from normal jump, facing right
DB $03, $01 
DB $FB, $00, $FB, $00 

;CBFF		;unused?
DB $06, $02 
DB $ED, $FE, $ED, $FE 

;CC05
XY_PA6:		;A6:;Landing from spin jump, facing right
DB $03, $01 
DB $FB, $00, $FB, $00, $FB, $00 

;CC0D		;unused?
DB $06, $02 
DB $ED, $FE, $ED, $FE, $ED, $FE 

;CC15
XY_P55:		;55:;Normal jump transition from ground, facing right and aiming up
XY_PE0:		;E0:;Landing from normal jump, facing right and aiming up
XY_PF1:		;F1:;Crouch transition, facing right and aiming up
XY_PF7:		;F7:;Crouching to standing, facing right and aiming up
DB $00, $01 
DB $FE, $E1, $FE, $E1 

;CC1B
XY_P56:		;56:;Normal jump transition from ground, facing left and aiming up
XY_PE1:		;E1:;Landing from normal jump, facing left and aiming up
XY_PF2:		;F2:;Crouch transition, facing left and aiming up
XY_PF8:		;F8:;Crouching to standing, facing left and aiming up
DB $09, $01 
DB $FA, $E1, $FA, $E1 

