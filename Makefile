all:start

start: clear
	quarto typst compile report.typ target/Système_de_type_pour_les_sciences_des_données_Hategekimana_Ganza_Fabrice.pdf

command: clear
	cat Makefile | grep ": clear" | sed "s/: clear//" | grep --invert-match "clear" 

commands: clear
	cat Makefile | grep ": clear" | sed "s/: clear//" | grep --invert-match "clear" 

clear: FORCE
	clear

FORCE:
