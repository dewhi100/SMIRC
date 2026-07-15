lorom

;Early RTS away from the last part of shinespark code which is the part that hurts samus and checks samus health during shinespark
org $90D0C6
	RTS

org $90D0F5
	RTS

org $90D121
	RTS

;NOP out the code that also checks samus health during shinespark
org $90D2BA
	NOP #8
