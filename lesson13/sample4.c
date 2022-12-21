// findstr1.c --- search substring occurence in longer string.
#include <stdio.h>
#include <string.h>
#include <stdbool.h>
void putrepl(char c, int count) {
	while(count-- > 0) { putchar(c); }
}
bool nmatch(char *str, char *pat, int len) {
	while(len-- > 0) {
		if(*str++ != *pat++) { return false; }
	}
	return true;
}
char *findstr(char *str, char *pat, int len) {
	if(len == 0) { return NULL; }
	int l;
	for(l = strlen(pat); l <= len; ++str, --len) {
		if(nmatch(str, pat, l)) { return str; }
	}
	return NULL;
}
int main(int argc, char *argv[]) {
	if(argc != 3) { fprintf(stderr, "needs 2 args.\n"); return 1; }
	char *str = argv[1];
	int len = strlen(str);
	while(true) {
		str = findstr(str, argv[2], len - (str - argv[1]));

		if(str == NULL) { return 0; }
		printf("%s\n", argv[1]);
		putrepl(' ', str - argv[1]); 
		putrepl('^', strlen(argv[2]));
		printf("\n");
		++str;
	}
}