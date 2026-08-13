;*****************************************************************************************************************
;*                                                                                                               *
;*           *************************** DELAYED CRUMBLE BLOCKS (DCB) **************************                 *
;*                                            by Black Falcon                                                    *
;*                                            ---------------                                                    *
;*    IMPORTANT NOTE:    THIS FILE IS NOT SUPPORTED BY XKAS, USE ASAR (included) TO COMPILE INSTEAD!!!!          *
;*                       Because honestly people, xkas is outdated, and asar can do everything xkas can and      *
;*                       a whole bunch more. Instructions how to use it below!                                   *
;*                                            ---------------                                                    *
;*  This patch adds new crumble blocks (BTS $10 to $17), which don't break immediately when being stepped on.    *
;*  Unlike shown in the video, it is not possible to get stuck within the block.                                 *
;*  It also fixes a glitch that caused xray to reveal a crumble block when the enemy-unpassable block is scanned *
;*  (Crumble block BTS 0B)                                                                                       *
;*                                                                                                               *
;*****************************************************************************************************************
;*                                                                                                               *
;*  INSTRUCTIONS ON HOW TO APPLY THIS PATCH                                                                      *
;*     - unzip into the same folder as your ROM                                                                  *
;*     - Rename your ROM extension to .sfc (unheadered ROM file) as .smcs ARE CONSIDERED HEADERED BY ASAR!       *
;*     - Double click asar                                                                                       *
;*     - when asked for patch name, type CrumbleDelay                                                            *
;*     - when asked for ROM name, type your ROM name (duh), it should compile without problems                   *
;*                                                                                                               *
;*****************************************************************************************************************
;*                                                                                                               *
;*  PATCH SETTINGS                                                                                               *
;*  Thanks to asar, it's possible to include conditionals which can change what the program does and doesn't     *
;*  assemble, based on simple variables like the ones below                                                      *
;*                                                                                                               *
    !RESPAWN_DELAYED_BLOCKS = 1    ;set to 0 if you want DCB to be one-time use only (normal crumble blocks      *
                                   ;will respawn after you stepped on a DCB once)                                *
;*                                            ---------------                                                    *
    !USE_DEFAULT_TIMERS = 0        ;Reducing the total break/respawn time, effectively lowering the max number   *
                                   ;of PLMs that can run at once , even if not by much. Helps avoiding glitches  *
;*                                 ;if you're not satisfied with my config, set this variable to 1               *
;*                                                                                                               *
;*****************************************************************************************************************
;*                                                                                                               *
;*  EDITABLE LABELS:                                                                                             *
    ;!crumble_delay = $0028         ;this is the frame delay for how long Samus can step on it until it breaks    *
    ;CRUMBLEDELAY_FREESPACE_84 = $84F060    ;Change this to free space if already used                            *
                            ;You can change this to whatever tile you want to display when        *
;*                                          stepped on                                                           *
;*                                            ---------------                                                    *
;*  HOW TO CHANGE THE DISPLAYED BLOCK TILE GFX:                                                                  *
;*    - Create a custom tile in SMILE's tileset editor somewhere in your CRE tiletable                           *
;*    - get the block number in hex of said tile from the CRE tiletable PNG                                      *
;*    - Change !BlockGFX to the block number                                                                     *
;*  EXAMPLES:  The top of the vertical yellow door table starts at 00, the top of the green one at 04            *
;*             Bomb block has the number 0x58, the shot block 0x52, etc                                          *
;*                                                                                                               *
;*****************************************************************************************************************    

; *********************** BLOCK ANIMATION DELAY SETTINGS {
if !USE_DEFAULT_TIMERS == 1

    !f1_delay = $0008            ;default crumble timers
    !f2_delay = $0006
    !f3_delay = $0004
    !f4_delay = $0010
    !f5_delay = $0004
    !f6_delay = $0004
    !f7_delay = $0004
else
; This slightly reduces the time in which crumble blocks break and respawn

    !f1_delay = $0006
    !f2_delay = $0004
    !f3_delay = $0004
    !f4_delay = $0010
    !f5_delay = $0004
    !f6_delay = $0003
    !f7_delay = $0002
endif    

}
 
; *********************** DEFAULT CRUMBLE BLOCK INSTRUCTIONS {
; 84D044: Crumble block PLM header table and inst ptr table 
; ********** RESPAWNING:
    C_1x1_R = $C9F9            ;respawning crumble         CE37 - C9F9
    C_2x1_R = $CA1C            ;respawning 2x1:            CE37 - CA1C
    C_1x2_R = $CA41            ;respawning 1x2:            CE37 - CA41
    C_2x2_R = $CA66            ;respawning 2x2:            CE37 - CA66
    
; ********** NON-RESPAWNING:
    C_1x1 = $CA8B            ;non-respawning crumble      CE37 - CA8B
    C_2x1 = $CAA0            ;non-respawning 2x1:         CE37 - CAA0
    C_1x2 = $CAB5            ;non-respawning 2x2:         CE37 - CACA
    C_2x2 = $CACA            ;non-respawning 1x2:         CE37 - CAB5
}

; *********************** DO NOT TOUCH: {
    i = 32                               ;0x10 * 2 = 0x20 = 0d32 Used as table entry
	!POS_PLM_Y = $1C2B
    !POS_Y_Samus = $0AFA
	!HITBOX_Y_Samus = $0B00
	!GET_PLM_XY = $848290
	
    !Blocktype = $8000
    !BlockTile = !Blocktype+!BlockGFX
	
    !xray_crumble = $00BC : !xray_speedboost = $00B6 : !xray_air = $00FF
    !reveal1x1 = $CF36 : !reveal1x2 = $CF4E : !reveal2x1 = $CF62 : !reveal2x2 = $CF6F
	
    INIT = $CE37 : SET_NEXT_INST = $8724
    INST_SET_BTS = $8AF1                 ;This is an instruction that sets the BTS of the block to the one provided in the argument (1 byte)
	
    !MACRO_PLMsetup = "dw INIT, .INST : .INST : dw !crumble_delay"    
    !MACRO_PLMsetup_R = "dw INIT, .INST : .INST : DW INST_CHECK_SAMUS_POS, !crumble_delay"            ;only used with respawn variant
    !MACRO_FRAMES =  "dw !f1_delay : skip 2 : dw !f2_delay : skip 2 : dw !f3_delay : skip 2 : dw !f4_delay" 
	!MACRO_FRAMES_RESPAWN = "skip 2 : dw !f5_delay : skip 2 : dw !f6_delay : skip 2 : dw !f7_delay"
    }

;*****************************************************************************************************************   
;                          ---------------         START OF CODE          ---------------     
;*****************************************************************************************************************  

; *********************** BLOCK REACTION POINTER TABLE {
	org $949139+i : dw C_10, C_11, C_12, C_13, C_14, C_15, C_16, C_17        ;crumble block reactions, Numbers are BTS

	org $840003+C_1x1_R : !MACRO_FRAMES : !MACRO_FRAMES_RESPAWN           ;macros are great!
	org $840003+C_1x2_R : !MACRO_FRAMES : !MACRO_FRAMES_RESPAWN
	org $840003+C_2x1_R : !MACRO_FRAMES : !MACRO_FRAMES_RESPAWN
	org $840003+C_2x2_R : !MACRO_FRAMES : !MACRO_FRAMES_RESPAWN

	org $840003+C_1x1 : !MACRO_FRAMES
	org $840003+C_1x2 : !MACRO_FRAMES
	org $840003+C_2x1 : !MACRO_FRAMES
	org $840003+C_2x2 : !MACRO_FRAMES
    
}

; *********************** START OF FREE SPACE

org !free84	;CRUMBLEDELAY_FREESPACE_84

; ***********************  GFX TILETABLES {
;   This is where the game looks up what tile to replace the current block with. You can have multiple blocks be set at once,
;   which is what any crumble type other than 1x1 does

    GFX_D_CRUMBLE_1x1:    dw $0001 : dw !BlockTile : dw $0000
    GFX_D_CRUMBLE_2x1:    dw $0002 : dw !BlockTile : dw !BlockTile : dw $0000
    GFX_D_CRUMBLE_1x2:    dw $0001 : dw !BlockTile : dw $0100 : dw $0001 : dw !BlockTile : dw $0000      ;0100 means one tile down
    GFX_D_CRUMBLE_2x2:    dw $0002 : dw !BlockTile : dw !BlockTile : dw $0100 : dw $0002 : dw !BlockTile : dw !BlockTile : dw $0000
}    
    
; ******************************************** BLOCK REACTION SETUPS ******************************************** {
;   The way these tables work, is that block reactions are spawning PLMs based on BTS (consisting of INITialization and INSTruction pointers)
;   Delayed crumble blocks basically add a 'prefix' set of instructions onto every existing crumble block reaction for BTS $10 to $17.
;   This prefix displays the defined !BlockTile for !crumble_delay frames, and then jumps to the usual crumble block reactions (breaking them)

; ********** RESPAWNING: {

if !RESPAWN_DELAYED_BLOCKS == 0

    C_10: : !MACRO_PLMsetup : dw GFX_D_CRUMBLE_1x1, INST_SET_BTS : db $00 : dw SET_NEXT_INST, C_1x1_R        ;after the first time breaking the block, set the BTS to normal crumble block
    C_11: : !MACRO_PLMsetup : dw GFX_D_CRUMBLE_2x1, INST_SET_BTS : db $01 : dw SET_NEXT_INST, C_2x1_R        ;this effectively makes these a one time use only
    C_12: : !MACRO_PLMsetup : dw GFX_D_CRUMBLE_1x2, INST_SET_BTS : db $02 : dw SET_NEXT_INST, C_1x2_R
    C_13: : !MACRO_PLMsetup : dw GFX_D_CRUMBLE_2x2, INST_SET_BTS : db $03 : dw SET_NEXT_INST, C_2x2_R          
else 
;    Thanks to asar's conditionals this only gets assembled if you specifically set !RESPAWN_DELAYED_BLOCKS to 0 (default 1)
INST_CHECK_SAMUS_POS: 
    JSL !GET_PLM_XY : LDA !HITBOX_Y_Samus : CLC : ADC !POS_Y_Samus : STA $12            ;this makes sure samus doesn't get stuck
    LDA !POS_PLM_Y : ASL : ASL : ASL : ASL : SEC : SBC $12 : BPL +
    INY : INY : INY : INY
+   RTS

    C_10: : !MACRO_PLMsetup_R : dw GFX_D_CRUMBLE_1x1, SET_NEXT_INST, C_1x1_R
    C_11: : !MACRO_PLMsetup_R : dw GFX_D_CRUMBLE_2x1, SET_NEXT_INST, C_2x1_R
    C_12: : !MACRO_PLMsetup_R : dw GFX_D_CRUMBLE_1x2, SET_NEXT_INST, C_1x2_R
    C_13: : !MACRO_PLMsetup_R : dw GFX_D_CRUMBLE_2x2, SET_NEXT_INST, C_2x2_R    

endif
}

; ********** NON-RESPAWNING: {
    C_14: : !MACRO_PLMsetup : dw GFX_D_CRUMBLE_1x1, SET_NEXT_INST, C_1x1            ;no need resetting BTS for non-respawning
    C_15: : !MACRO_PLMsetup : dw GFX_D_CRUMBLE_2x1, SET_NEXT_INST, C_2x1
    C_16: : !MACRO_PLMsetup : dw GFX_D_CRUMBLE_1x2, SET_NEXT_INST, C_1x2
    C_17: : !MACRO_PLMsetup : dw GFX_D_CRUMBLE_2x2, SET_NEXT_INST, C_2x2
}

}

!free84 #= pc()

;*****************************************************************************************************************          
;  BLOCK REVEAL STUFF:  (aka making use of redundant code to avoid using free space for some additional BTS checks)
;***************************************************************************************************************** {

; ********** XRAY BTS CHECK TABLE:
		org $91D322
XRAY:   dw $0000, .1x1, $0001, .1x2, $0002, .2x1, $0003, .2x2, $0004, .1x1, $0005, .1x2, $0006, .2x1, $0007, .2x2
		dw $000B, .air                                                                                                ;fix the enemy-step block to reveal air
		dw $000E, .speed1, $000F, .speed1
		dw $0010, .1x1, $0011, .1x2, $0012, .2x1, $0013, .2x2, $0014, .1x1, $0015, .1x2, $0016, .2x1, $0017, .2x2   ;added ones
		dw $0082, .speed2, $0083, .speed2, $0084, .speed2, $0085, .speed2, $FFFF

; ********** XRAY REVEAL TABLE:
.air    	dw !reveal1x1, !xray_air
.1x1    	dw !reveal1x1, !xray_crumble
.1x2    	dw !reveal1x2, !xray_crumble, !xray_crumble
.2x1    	dw !reveal2x1, !xray_crumble, !xray_crumble
.2x2    	dw !reveal2x2, !xray_crumble, !xray_crumble, !xray_crumble, !xray_crumble
.speed1 	dw !reveal1x1, !xray_speedboost        
.speed2 	dw $CF3E, !xray_speedboost                ;not sure if this is a special reveal instruction or whatever. works regardless.

; ********** BOMB REVEAL:
	org $949DA4+i : dw $CFFC, $D000, $D004, $D008 : dw $CFFC, $D000, $D004, $D008    ;copied bomb reveal (always reveals normal crumble blocks)
}












