; ================================================================================================================
;           ======================== GBA METROID STYLE CHAIN BLOCKS  ========================              
;                                            by Black Falcon                                                    
;                                            ---------------                                                    
;    IMPORTANT NOTE:    THIS FILE IS NOT SUPPORTED BY XKAS, USE ASAR TO COMPILE INSTEAD!                        
                        
;    WHAT THIS DOES:
;
;    This adds Fusion/Zm like chain blocks to the game. They are functionally identical in that you can break any element of the chain.
;    The "normal" chains can either be of type SHOT BLOCK or BOMB BLOCK with 
;       BTS $0D for horizontal, 
;       BTS $0E for vertical and 
;       BTS $0F for both directions
;
;    For more advanced puzzles, non-respawning Super Missile, Power Bomb or Grapple Breakable blocks can also trigger a chain reaction if
;    used in conjunction with blocks of type SOLID and the above mentioned BTSs
;   
;    BOMB and SHOT block chain elements can "transfer" their reaction over to SOLID chain elements, but the other way around does NOT work!
;    This way, you could build one-way chains, for example.
;
;    Notes: 
;        Powerbombs can sometimes mess up destructible chains
;    
;
;    If you encounter any bugs or want to request features, feel free to contact me on the metconst discord.
;
; ================================================================================================================

;    !FREESPACE_Bank84 = $84F060                ; Change this to free space if you use other PLMs
    !VAL_delay = #$0004                        ; delay in frames between block break animation frames

; ================================================================================================================
{    

;    !BTS_horizontal = #$000D
;    !BTS_vertical = #$000E
;    !BTS_junction = #$000F
    
    !PLM_delay = $7EDE1C
    !PLM_location = $1C87
    !PLM_Blocktype = $1D77
    !PLM_BTS = $1E17
    !PLM_Index = $1C27
    !PLM_JSL_SpawnPlm = $8484E7
    !PLM_RoomArgument = $1DC7
    
    !Index_CurrentBlock = $0DC4
    !Room_Tilemap = $7F0002
    !Room_BTSmap = $7F6402
    !TEMP_index = $12
  
    !GFX_Shotblock = $0052                    ; X-Ray reveal graphics for chain elements
    !GFX_Bombblock = $0058
    !GFX_Solidblock = $005F
    
    !COL_PLM_SOLID = $B637                  ; PLM Collision reaction: SEC : RTS (solid)
    
    !I_PLM_PlaySound = $8C46
    !I_PLM_GoTo = $8724    
    !I_PLM_Delete = $86BC                     ; delete PLM
    
    
    
}    

;=========================================== XRAY VISIBILITY TWEAKS ========================================================
;    The following changes make xray reveal the correct tile when a chain element (only for shot and bomb block) is scanned.
{
    ;xray block type reference table at 91D2D6
    ;xray shot block scan table at 91D3CC
    ;xray bomb block scan table at 91D484
    
;----------------- Shot blocks:
    org $91D456
        DW $CF36, !GFX_Shotblock                ;shot block BTS 0D xray reveal block
        DW $CF36, !GFX_Shotblock                ;shot block BTS 0E xray reveal block
        DW $CF36, !GFX_Shotblock                ;shot block BTS 0F xray reveal block
        
;----------------- Bomb blocks:
    org $91D484 : DW $FF00                    ;causes all bomb blocks to be revealed with bomb gfx, since there are no special case bomb blocks
                                              ;(power bombs are actually shot blocks checking for power bomb projectiles...)

}
;=========================================== BLOCK REACTION TWEAKS ========================================================
;    The game needs to know what to do when a block is shot, bombed, touched, etc. For this reason it has several reactions
;    that, depending on both block type and BTS, spawn PLMs or do specific stuff. BTS 0D, 0E, and 0F for both shot and
;    bomb blocks are unused, and therefore need an appropriate reaction assigned to them, done below
{
;    Reaction Settings: {

;-------------------------------------
    i_Bomb = $1E           ; 2*0xF = 0x1E = 30 in decimal, bomb table entry
    i_BTS = $1A            ; 2*0xD = 0x1A = 26 in decimal, BTS table entry
;-------------------------------------    
}

; the following two lines are necessary because chainblocks would break when shot or grappled
; this happens because the entry for the bombable block type is shared with shot and grapple, so the reaction itself checks again if it was actually bombs
; simply setting the *SHOT* (not bombed!) reaction to that of a solid block seems to fix this issue, although further testing might be required
; this is a bug that took me ages to figure out

    ; org $94A175+i_Bomb : DW $9D5B ; Bomb block shot reaction horizontal, this prevents bomb chain blocks from being able to be shot
    ; org $94A195+i_Bomb : DW $9D5B ; Bomb block shot reaction vertical
    org $94A175+i_Bomb : DW bombBlockShot ; Bomb block shot reaction horizontal, this prevents bomb chain blocks from being able to be shot
    org $94A195+i_Bomb : DW bombBlockShot ; Bomb block shot reaction vertical

    org $94A83B+i_Bomb : DW $9D5B ; Bomb block Grapple reaction 
    
   
    org $94936B+i_BTS : DW !COL_PLM_SOLID, !COL_PLM_SOLID, !COL_PLM_SOLID                     ;BTS $0D, $0E, $0F respectively, Samus block collision reaction to set carry (solid)
    
    org $94A012+i_BTS : DW PLM_CHAIN_DIRECTIONAL, PLM_CHAIN_DIRECTIONAL, PLM_CHAIN_JUNCTION   ;BTS $0D, $0E, $0F respectively, bomb reaction
    org $949EA6+i_BTS : DW PLM_CHAIN_DIRECTIONAL, PLM_CHAIN_DIRECTIONAL, PLM_CHAIN_JUNCTION   ;BTS $0D, $0E, $0F respectively, shot reaction
    

; Reactions for non-respawning Powerbomb, Supermissile, Grapple respectively
; this replaces a simple (mostly redundant) block break animation with the chainblock PLM instructions
; this allows them to trigger a chain both in hor and ver direction (chains made of solid blocks only)
    
    org $84D08A : DW RUN_PLM_CHAIN_JUNCTION         ;replacing non-respawning power bomb block instruction pointer
    org $84D092 : DW RUN_PLM_CHAIN_JUNCTION         ;replacing non-respawning supers block instruction pointer
    
    org $84D0E2 : DW RUN_GRAPPLE_REACTION
    
    org $84CDA9 : RUN_GRAPPLE_REACTION:
    DW $0078 :  DW $A4F9            
    DW I_PLM_ChainJunction
    DW !I_PLM_GoTo : DW ANIM_PLM_BREAK          ; to save space here, jump to the rest of the break animation
    
}

;
;=========================================== START OF MAIN CODE ========================================================
;


org !free84

PLM_CHAIN_JUNCTION:       DW INIT_PLM_Chainblock : DW RUN_PLM_CHAIN_JUNCTION                ;PLM Header
PLM_CHAIN_DIRECTIONAL:    DW INIT_PLM_Chainblock : DW RUN_PLM_CHAIN_DIRECTIONAL                ;PLM Header

print "Chain Junction PLM: ", hex(PLM_CHAIN_JUNCTION)
print "Chain Directional PLM: ", hex(PLM_CHAIN_DIRECTIONAL)
print ""


;-----------------
RUN_PLM_CHAIN_JUNCTION:
    
    DW !VAL_delay : DW $A345                            ; first frame for for breaking block
    DW I_PLM_ChainJunction                              ; if this were put before the animation starts, the blocks would break instantly instead of sequential
    DW !I_PLM_GoTo : DW ANIM_PLM_BREAK                  ; to save space here, jump to the rest of the break animation

    
RUN_PLM_CHAIN_DIRECTIONAL:
    
    DW !VAL_delay : DW $A345                            ; first frame for for breaking block
    DW I_PLM_ChainDirectional  
    
ANIM_PLM_BREAK:    
    DW !I_PLM_PlaySound : DB $0A                        ; Play 'Break block' sound. You can delete this line to prevent the sound.
    DW !VAL_delay : DW $A34B
    DW !VAL_delay : DW $A351                            
    DW !VAL_delay : DW $A357                            
    DW !I_PLM_Delete
    

;----------------------------------------
INIT_PLM_Chainblock:
; for BTS, this results in 0D --> 00, OE --> 01, 0F --> 02, later used to determine direction
; it stores the current blocktype as second PLM value to later check if there are more elements of this type (bomb, shot and solid only!)

    LDA !Index_CurrentBlock : JSR JSR_GetBlockBTS : AND #$0003 : STA !PLM_RoomArgument,y
    LDA !Index_CurrentBlock : ASL a : JSR JSR_GetBlockType : STA !PLM_Blocktype,y
    RTS
    
;===================================================================================================

I_PLM_ChainJunction:                                    
; only checks if adjacent blocks are $0D, $0E, and $0F, regardless of its own BTS
    {
    JSR JSR_CheckHorizontalChain                    
    JSR JSR_CheckVerticalChain
+   LDA #$0001 : STA !PLM_delay,x
    RTS
    }
    
I_PLM_ChainDirectional:                                    
; checks BTS and if it'S 0D, 0E and 0F then respectivly continue horizontal, vertical or in both directions
; (technically any BTS with bits 1 or 2, but the PLM is only spawned for $0D, $0E, and $0F)
    {

    LDA !PLM_RoomArgument,x : BIT #$0001 : BEQ +
    JSR JSR_CheckHorizontalChain
+   LDA !PLM_RoomArgument,x : BIT #$0002 : BEQ +                        
    JSR JSR_CheckVerticalChain
+   LDA #$0001 : STA !PLM_delay,x
    RTS
    }    
    
    
;===================================================================================================    

JSR_CheckHorizontalChain:
; check one bock to the left and right, and spawn a PLM if the chain continues
    LDA !PLM_location,x : INC a : INC a : STA !TEMP_index : JSR JSR_CheckChainElements                   
    LDA !PLM_location,x : DEC a : DEC a : STA !TEMP_index : JSR JSR_CheckChainElements
    RTS

JSR_CheckVerticalChain:
; check one block up and down, and spawn a PLM if the chain continues
    LDA !PLM_location,x : CLC : ADC $07A5 : ADC $07A5 : STA !TEMP_index : JSR JSR_CheckChainElements
    LDA !PLM_location,x : SEC : SBC $07A5 : SBC $07A5 : STA !TEMP_index : JSR JSR_CheckChainElements
    RTS


;----------------------------------------
;    Conditions to spawn another Chain PLM:
;    Chain has to be of the same type as the one it's currently on (only for shot, bomb and solid blocks with BTS)
;    BTS has to match 0D and 0F (horizontal) and 0C and 0F (vertical)
;    This does NOT destroy any more Super Missile, Powerbomb or Grapple Blocks!
;----------------------------------------

JSR_CheckChainElements:
    JSR JSR_GetBlockType : CMP !PLM_Blocktype,x : BEQ +                              ; check if the adjacent block is of the same type as the current block
                           CMP #$8000 : BNE +++                                      ; or if it is solid
+   LDA !TEMP_index : LSR a : JSR JSR_GetBlockBTS : CMP.w !BTS_junction : BEQ ++
                                                    CMP.w !BTS_vertical : BEQ +
                                                    CMP.w !BTS_horizontal : BNE +++
+   JSR JSR_SpawnDirectionalChain : BRA +++
++  JSR JSR_SpawnChainJunction
+++ RTS

JSR_GetBlockType:
    PHX : TAX : LDA !Room_Tilemap,x : PLX : AND #$F000 : RTS
    
JSR_GetBlockBTS:
    PHX : TAX : LDA !Room_BTSmap,x : PLX : AND #$00FF : RTS
    

;===================================================================================================    

JSR_SpawnChainJunction:
    LDA !TEMP_index : LSR a : STA !Index_CurrentBlock    ; current block index for the PLM routine
    LDA !PLM_Index : PHA
    LDA #PLM_CHAIN_JUNCTION : JSL !PLM_JSL_SpawnPlm                            
    PLA : STA !PLM_Index                                 ; Roundabout way to prevent the PLM spawn routine to claim the current PLM index!
    RTS

JSR_SpawnDirectionalChain:
    LDA !TEMP_index : LSR a : STA !Index_CurrentBlock                          
    LDA !PLM_Index : PHA
    LDA #PLM_CHAIN_DIRECTIONAL : JSL !PLM_JSL_SpawnPlm                         
    PLA : STA !PLM_Index                                                 
    RTS    
    
!free84 #= pc()

;;;fixing compatability with block revealing missiles

org !free94
bombBlockShot:
	LDX $0DC4		;\
	LDA $7F6401,x	;|vanilla code
	AND #$FF00		;/
	CMP #$0800 : BMI ++	;if BTS < $8, treat as normal bomb block
	CMP #$1000 : BPL +	;if BTS >= $10, treat as solid
	CMP #$000C : BMI + 	;if BTS < $C, treat as solid
	;
	LDA #$D0C8
	JMP $A006
	+ 
	SEC : RTS			
	++
	JMP $9FE0	
	
!free94 #= pc()