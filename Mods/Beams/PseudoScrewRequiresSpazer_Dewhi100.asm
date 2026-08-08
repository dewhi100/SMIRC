lorom


;;;Work in Progress;;;


org $90A504
;vanilla: STA $0A6E (samus contact dmg index)
JSR CheckSpazer

if !EasierWallJump_Benox50 == 0
org $90A74C
;vanilla: STA $0A6E (samus contact dmg index)
JSR CheckSpazer
endif

;NOTE: Due to a coincidence, 0004 is the value for both spazer, and for the pseudo screw contact damage index
;because of this, rather than run a bitflag test, you can simply mask all non-spazer bits, and if non-zero, store to contact damage index
org !free90
CheckSpazer:
LDA $09A6
AND	#$0004
BEQ +
LDA #$0004
;STA $0A6E ;Samus contact damage index
+
LDA #$0000
RTS

!free90 #= pc()