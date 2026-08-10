; upgrade to charged shot when full energy

if !BrokenChargeBeam_PHOSPHOTiDYL == 0
org $90B854
    JMP FullEnergyCharge_FireBeam

org $90B86A
    JMP FullEnergyBeam_ReleaseChargeEarly
endif

org !free90 ; freespace in bank $90
FullEnergyCharge_FireBeam:
    ; check if energy is full
    LDA $09C2 : CMP $09C4 : BMI .return
    ; check if charge beam equipped
    LDA $09A6 : BIT #$1000 : BEQ .return

    ; jump to charged shot
    JMP $B986

  .return
    JSR $BCBE
    JMP $B885

FullEnergyBeam_ReleaseChargeEarly:
    LDA $09C2 : CMP $09C4 : BMI .uncharged

  .charged
    JMP $B986

  .uncharged
    JMP $B887

!free90 #= pc()