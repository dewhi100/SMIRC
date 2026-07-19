The planet doesn't explode.asm, by Tundain


Removes the explosion of the planet once samus leaves it.

"The planet doesn't explode.asm" just has samus leaving the planet, with nothing special, just apply this patch (no freespace used)

"The planet doesn't explode-but the area does.asm" adds a few explosions on the planet's surface before samus's ship appears, as to indicate that the place samus left did blew up.

Important when using this version of the patch!

you're gonna have to draw the gfx for the smaller explosions yourself, here's how to do it:

1: get smile RF
2: in smile RF, open tileset editor
3: in tileset editor, select "special gfx"
4: in the dropdown, select "zebes boom", then export 
5: optional, in the palette editor, use "i'm a genius" and type in address $8CEBE9, this will give you the corresponding palettes
6: in your preffered gfx editor, draw the explosion gfx (use "which tiles.png to know which ones to edit), keep in mind, those gfx use palette line 5, so draw them accordingly
7: when done, save the gfx, and reimport them through smile RF again (in tileset editor->special gfx-> zebes boom, and then import)

For any questions/issues, you can find me on the metroid construction discord server

enjoy!

