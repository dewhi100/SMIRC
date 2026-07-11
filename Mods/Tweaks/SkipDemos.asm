lorom

;hex tweak to skip the demo timer decrement. useful if you dont want to record new demos.

org $8B9F2C
BRA +
org $8B9F38
+