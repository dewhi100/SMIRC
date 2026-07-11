# SMIRC
Super Metroid Integrated Resource Collection

asarParams.txt	-	Meant to be pasted into SMART 's "Extra Arguments" field (under "Config>Global") 
SMIRC.asm 	-	Main build file.  
stddefines.txt	-	Lists freespace, RAM addresses, or other constants or shared values you might want to track, such as custom BTS indices  
stdincludes.txt	-	I don't really have a good use for this, apart from including the base "Mods" folder  
test.asm	-	Used to detect ASM collistions between SMIRC and new ASMs before integrating them  
scratchpad	-	Not needed, but possibly useful for separating out in-development mods  
Mods		-	Hosts all the different patches  
Mods/config.asm	-	The UI for SMIRC. Has all the flags for indivual mods and features, and other defines for them.  


|| To use in a hack ||
- Download this repository into your ASM folder.
	- SMIRC.asm and test.asm should be the only ASM files at the root level. sort any ASMs you have into the Mods folder.
- Open Mods/config.asm; To enable a mod, set its flag to 1. To disable, set it to zero.
	- Example: !ChargeHeal_Dewhi100 = 0	;enable dewhi100s Charge Healing

Then run the Asar assembler, using whatever method you prefer.
SMIRC should be the only assembly file that runs when you assemble. Otherwise, you'll get mods overwriting each other in freespace.

|| To add new resources to the project ||

- Add the asm script or folder into Mods
- Modify all new scripts to use the SMIRC naming convention for freespace
	- Example: org !free90
- At the end of every code block in freespace, add '[freespace variable] #= pc()'
	- Example: !free90 #= pc()
- Open test.asm
- 'incsrc [path to main file for the resource]'
- Use Asar to apply both patches, and note conflicts. SMART does this easily.
	- If the only conflicts happen within freespace, the resource is safe to include in the main file
	- If conflicts happen within code blocks, its up to you to resolve them. This is advanced work.
	- It helps to define custom RAM or ROM addresses in stdincludes.txt 
- Once conflicts are resolved, create an entry in config.asm, following the naming conventions that include the original author's name. This helps for giving credit later.
- Open SMIRC.asm and create a similar entry to run the resource.
- Clear test.asm
- Run Asar again. The new resource should be included if you've turned it on, and there should be no assembly errors
- Other, more insidious runtime error may still occur, usually due to conflicts in RAM.
	- These may be trivial, such as moving a variable to a different unused address.
	- However, it may be more complicated, such as overwrites to graphics tables or other large blocks of RAM
	- Good luck with that.

||NOTE||  
Not every resource in the Mods folder has been integrated yet.
Some aren't even confirmed to work on their own on a vanilla game.