/*
* This is the flex file for the ZoomJoyStrong language,
* used to make basic drawings.
*
* @author Tressa Groelsma
*/
%{
	#include <stdlib.h>
	#include "zoomjoystrong.tab.h"

	void yyerror(const char* msg);
%}

%option noyywrap

%%

;			{ return END_STATEMENT; }
point			{ return POINT; }
line			{ return LINE; }
circle			{ return CIRCLE; }
rectangle		{ return RECTANGLE; }
set_color		{ return SET_COLOR; }
[0-9]+			{ return INT; }
[0-9]+\.[0-9]		{ return FLOAT; }
[ \t\n]			;
.			{ yyerror("Invalid input"); }

%%
