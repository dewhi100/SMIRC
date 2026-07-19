;Supers Need Mains

;Requires the event station. Samus downloads the super missile launcher.
;Use the event station to set an event flag.
;Modifies HUD to check for event instead of max supers
;Modifies ammo PLM to check for event and give different messages accordingly
;In the room where you perform the download, use the room ASM for this
;needs new message box for "unknown ammo" ($1D is the first unused index in vanilla) when super ammo is collected before main download.
;by default, the download provides starter ammunition, defined by !StarterAmmo

; !SuperMissileEvent = $30
; !UnknownAmmoMessageIndex = $1D

LoROM

;HUD changes---------------------


org $809AD2
JSR SuperEventCheck

if !UniversalAmmo_Tundain == 0
org $809B0F
JSR SuperEventCheck

org $809C16
JSR SuperEventCheck
endif


org !free80
SuperEventCheck:
LDA #$0000+!SuperMissileEvent
JSL $808233	;carry set if event marked
LDA #$0000	;default if zero
BCC +		;branch if event not marked
if !UniversalAmmo_Tundain != 0
JSL CheckSupersLong
else
LDA $09CA	;current supers
endif
+
RTS

warnpc !free80End
!free80 #= pc()
;-------------------------------

;Super missile ammo pickup message

org $8489E6
NOP : NOP : NOP : NOP		;skip hud code

org $8489F1
JSR PickMessage

org !free84
PickMessage:
LDA #$0000+!SuperMissileEvent
JSL $808233	;carry set if event marked
LDA #$0000+!UnknownAmmoMessageIndex	;default to "unknown ammo" message
BCC +
JSL $809A0E	;Add supers to HUD
LDA #$0003
+
RTS

!free84 #= pc()

;Update HUD when event is triggered (room ASM)
org !free8F
print "Super Missile Download Room ASM: ", pc
UpdateHUD:
LDA #$0000+!SuperMissileEvent
JSL $808233
BCC +
LDA #$0000+!StarterAmmo
STA $09CA
STA $09CC 
JSL $809A0E
STZ $07DF ;Room Pointer
+
RTS

!free8F #= pc()

;HUD select override

if !BombLauncher_Ob == 0
	org $90C564
	JSR SuperEventCheck90
endif

org !free90
;checks CURRENT supers as opposed to max supers like in bank 80
SuperEventCheck90:
LDA #$0000+!SuperMissileEvent
JSL $808233	;carry set if event marked
LDA #$0000	;default if zero
BCC +		;branch if event not marked
if !UniversalAmmo_Tundain == 1
  JSR checkifcanselectsupers
else
LDA $09CA	;current supers
endif
+
RTS

if !UniversalAmmo_Tundain
CheckSupersLong:
JSR checkifnotenoughsupers
RTL
endif

!free90 #= pc()