Spark bounce by Kejardon

modifications for cross compatability by dewhi100

This patch is seperated out into several files to make it easier to use in a larger hack.

DO NOT COMPILE THESE FILES:
SparkBounceCustomizeOptions.asm : Settings to help compile other files. Simple modifications should be done here.
SparkBounceElectromorph.asm : If you have Electromorph code from Insanity, these changes provide compatibility so SparkBounce works with Electromorph.

SparkBounceSizeTweaks.asm : Optional tweaks to Super Jump hitboxes, because the default ones are kind of bad. Technically you can compile this directly I guess, but it's also just a setting in SparkBounceCustomizeOptions.asm

MAIN FILE TO COMPILE:
SparkBounceFunctions.asm

EXTRA FIlES TO MAYBE COMPILE:
SparkBounceTransitionTable.asm : If you have your own Transition Table file / changes, read the instructions for this to integrate with your table. If not, you can use this directly.
SparkBouncePickup.asm : If you want a PLM item pickup for SparkBounce, this will work. Note that you may need some modifications to make the message boxes work correctly if you have your own message box expansion patch - see the .asm file for more details.

