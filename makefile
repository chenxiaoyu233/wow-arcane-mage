#cmd = ./SIMC/simc

ifeq ($(shell uname), Linux)
	cmd = ./SIMC/simc.exe
else
	cmd = ./SIMC/simc
endif

single:
	cat character-single.simc arcane.simc > input.simc
	$(cmd) input=input.simc html=report.html
aoe:
	cat character-aoe.simc arcane.simc > input.simc
	$(cmd) input=input.simc html=report.html desired_targets=5 
