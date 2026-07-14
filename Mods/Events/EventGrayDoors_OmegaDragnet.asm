;--------------------EVENT GRAY DOORS---------------------------
;----------------------OmegaDragnet9----------------------------
;------------------April 17th 2026 Version----------------------

;Credits to JAM for already having this functionality
;in his Extra Event Doors patch.
;P.JBoy for the Banklogs.
;MetroidNerd#9001, because the Event based off Room Index 
;came from Event Triggers from Killing Enemies.

lorom

;----------------------DEFINES----------------------------------

;Setup so you can switch them around here if you wanted.
;Matches new behavior to corresponding hijack.
!RoomIndexEventCondition   = !AreaBossHijack 
!BTS_BossBitCondition      = !MiniBossHijack
!BTS_EventCondition        = !TorizoHijack 
!PLM_ArgumentEventCondtion = !AnimalsSavedHijack

;Freespace/Hijacks
;!84FreeSpace1       = $84F2A0        ;Where the NEW GRAY DOOR BEHAVIORS go
!AreaBossHijack     = $84BDD4        ;Main Area Boss Defeated Condition
!MiniBossHijack     = $84BDE3        ;Miniboss Defeated Condition    
!TorizoHijack       = $84BDF2        ;Torizo Defeated Condition
!AnimalsSavedHijack = $84BE30        ;Animals Escaped Event Condition

;RAM Addresses/Vanilla Routines
!FirstBTS           = $7F6402	
!BossBitCheck       = $8081DC
!EventCheck         = $808233	
!RoomIndex          = $079D

;------------VANILLA GRAY DOOR HIJACKS--------------------------

;Comment out whatever you don't want to use.
;Remember these can be adjusted in the defines section at the top. 

;-------CHECK EVENT BASED OFF OF ROOM INDEX----------------------
;In editor, select "Main Boss Defeated." 

; org !RoomIndexEventCondition   ;Boss Defeated Hijack. 
; JSR RoomIndex
; NOP #4

;-------CHECK BOSS BIT BASED OFF OF BTS TILE---------------------
;In editor, select "Miniboss defeated."
;Has to be $01, $02, $04, $08, $10, $20, $40, and $80
;Has to be the very first BTS block in the room.

; org !BTS_BossBitCondition	
; JSR BossBitDefeated
; NOP #4

;--------CHECK EVENT BASED OFF OF BTS TILES--------------------------
;In editor select "Torizo Defeated."
;Can be used to check Events including and beyond Vanilla array
;Has to be the very first 2 BTS blocks in the room. 

org !BTS_EventCondition   
JSR EventCheckBTS
NOP #4

;-------CHECK EVENT BASED OFF OF DOOR PLM ARGUMENT-----------------
;In editor, you select "Etecoons/Dachora Rescued"
;Sets event based off low byte of PLM argument.
;Currently setup to use extended event array as well.
;Using this, you MUST match the door index to the event.

org !PLM_ArgumentEventCondtion 
JSR EventCheckPLM
NOP #4

;-----------NEW GRAY DOOR BEHAVIORS------------------------
;Uses about $31 bytes of freespace in Bank $84 

org !free84 ;!84FreeSpace1

if !plmEventDoor == 1

print "Event Door (PLM Arg): ", pc
EventCheckPLM:
PHY
LDY $1C27        ;PLM index
LDA $1DC7,y	     ;PLM variable (event # to set)
AND #$0FFF
PLY              
JSL !EventCheck
RTS

endif

; RoomIndex:        ;This checks if an event matching the Room Index took place. For the boss rooms. Comment this as well as lines 43-45 if using Boss Area Event System.
; LDA !RoomIndex
; JSL !EventCheck
; RTS

; BossBitDefeated:	 ;Comment this as well as lines 52-54 if you want this functionality. (Mainly for Boss Area Event System.)  
; LDA !FirstBTS      ;Gets first BTS Block from Room
; AND #$00FF
; JSL !BossBitCheck
; RTS

if !btsEventDoor == 1

print "Event Door (level BTS): ", pc
EventCheckBTS:
LDA !FirstBTS       ;Gets first BTS Block from Room
XBA                 ;Needs to be XBA because using 2 blocks his time (for events higher than $FF)
AND #$0FFF
JSL !EventCheck
RTS

endif

!free84 #= pc()