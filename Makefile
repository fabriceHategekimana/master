all:start

start: clear
	quarto typst compile report.typ target/report.pdf

command: clear
	cat Makefile | grep ": clear" | sed "s/: clear//" | grep --invert-match "clear" 

commands: clear
	cat Makefile | grep ": clear" | sed "s/: clear//" | grep --invert-match "clear" 

clear: FORCE
	clear

FORCE:
