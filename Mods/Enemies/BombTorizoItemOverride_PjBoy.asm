org $84BA6F ; Instruction - go to [[Y]] if Samus doesn't have bombs
; Check if PLM 1 (vanilla bombs PLM) has been deleted instead, go to [[Y]] if still exists
LDA $1C83 : BNE +
INY : INY : RTS

+
LDA $0000,y : TAY : RTS

; Statue
org $84D33B ; Pre-instruction - wake PLM if Samus has bombs
LDA $1C83 : BNE +
LDA #$0001 : STA $7EDE1C,x
INC $1D27,x : INC $1D27,x
LDA #$D356 : STA $1CD7,x

+
RTS