macrun:
	flex dogescann.l
	gcc lex.yy.c -ll
	@echo Done


windowsrun:
	flex dogescan.l
	gcc lex.yy.c -lfl
	@echo Done

linuxrun:
	flex dogescan.l
	gcc lex.yy.c -lfl
	@echo Done
