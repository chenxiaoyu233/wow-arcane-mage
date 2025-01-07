single:
	cat character-single.simc arcane.simc > input.simc
	./SIMC/simc input=input.simc html=report.html
aoe:
	cat character-aoe.simc arcane.simc > input.simc
	./SIMC/simc input=input.simc html=report.html desired_targets=5 
