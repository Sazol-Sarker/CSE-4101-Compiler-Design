input = input.txt
output = output.txt

main:
	bison -d a.y
	flex a.l
	gcc a.tab.c lex.yy.c
	./a < $(input) > $(output)
	./a < input.txt
	

