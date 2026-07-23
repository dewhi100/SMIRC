

;!Bank90FreeSpace = $90F63A

;NOTE: This must be an odd number (end in 1,3,5,7,9,B,D, or F) because of indexing shenanigans
;!Bank92FreeSpace = $92EDF5

;This is only used for messageboxes and may be unnecessary if you use your own message box patch, or don't use the item.
;!Bank85FreeSpace = $859643

;Tweak Super Jump sizes to better match the graphics, and position the graphics to better match the hitbox. Uncomment the next line to include these tweaks.
;incbin SparkBounceSizeTweaks.asm


;Defaults to $8A00 to reuse speedbooster. Repoint to something like $9100 if you add new graphics for Spark Bounce to 89:9100 or something.
;!SparkbounceGraphic = $8A00 

;Defaults to $EFD3 for the start of PLM unused space. Repoint if other custom PLMs are using that space. xkas will report where the Sparkbounce PLM ends.
;This is the PLM ID you should use in the editor.
;!SparkbounceItem = $EFD3

;Which item slot in 09A2 is used for SparkBounce. This can be ignored if you have EquipmentCheck disabled and don't use SparkBouncePickup.asm
;!SparkbounceEquipmentSlot = $0040

;Message box ID used for Sparkbounce. Only 1C message boxes are normally supported, a patch is needed to add support for extra message boxes, or one must be overwritten.
;!SparkbounceMessageIndex = $1D

;Uncomment one of these lines. First one to check equipment, second one to always allow spark bouncing.
;!EquipmentCheck = "LDA $09A2 : BIT.w #!SparkbounceEquipmentSlot : BEQ End"
;!EquipmentCheck = ""


