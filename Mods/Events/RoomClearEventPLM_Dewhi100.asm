lorom

;-------------------------------------------------------
;Better Room Clear Events
;by dewhi100
;-------------------------------------------------------
;-------------------------------------------------------
;Because this overwrites and replaces multiple PLMs, this actually frees up space in bank 84
;
;To use, put PLM $DB44 in your room.
;Set the PLM parameter to the event you wish the PLM to set.
;-------------------------------------------------------
;-------------------------------------------------------
;Replaces the PLMs which set events when metroids are killed in Tourian.
;Originally, there were multiple routines which each set a hardcoded event flag.
;The PLM parameter was used to select which hardcoded routine to run (most were just RTS).
;The new PLM uses a single routine, which sets the event flag dynamically.
;NOTE:  Yes, this code uses $1CD7,y (Pre-PLM instruction) and $1DC7,y (PLM variable). 
;They are very similar-looking but distinct addresses.
;-------------------------------------------------------

;-------------------------------------------------------
;New PLM logic, overwriting several original hardcoded routines.
;-------------------------------------------------------
org $84DAD5
CustomPLM:
LDA $0E50	;Enemies killed
CMP $0E52	;Enemies needed
BCC +
PHY
LDY $1C27		;PLM index
LDA $1DC7,y		;PLM variable (event # to set)
PLY
JSL $8081FA		;Set event A
+
RTS

;-------------------------------------------------------
;Set the Pre-PLM instruction to point at the new logic.
;-------------------------------------------------------
org $84DB21
;Originally LDA $DB28,x (Pointing at indexed address based on PLM parameter).
LDA.w #CustomPLM	;Now, always points to the all-in-one PLM
