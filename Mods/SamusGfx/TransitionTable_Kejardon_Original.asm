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