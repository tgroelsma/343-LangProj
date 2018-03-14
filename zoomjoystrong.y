/*
* A Bison file for the ZoomJoyStrong language,
* used for basic drawings.
*
* @author Tressa Groelsma
*/
%{
	#include <stdio.h>
	#include "zoomjoystrong.h"

	void yyerror(const char* msg);
	void colorcheck(int r, int g, int b);
%}

%error-verbose
%start statementlist

%union { int ival; float fval; }

/* This exits the interpreter. */
%token END

/* This is a semicolon, has to end a statement. */
%token END_STATEMENT

/* This indicates the command to plot a point. */
%token POINT

/* This indicates the command to plot a line. */
%token LINE

/* This indicates the command to make a circle. */
%token CIRCLE

/* This indicates the command to make a rectangle. */
%token RECTANGLE

/* This indicates the command to set the color for drawing. */
%token SET_COLOR

/* This is an integer value. */
%token <ival> INT

/* This is a floating point value. */
%token <fval> FLOAT

%%
statementlist:		statement
	|		statement END
;

statement:		line_command END_STATEMENT
	|		point_command END_STATEMENT
	|		circle_command END_STATEMENT
	|		rectangle_command END_STATEMENT
	|		set_color_stmt END_STATEMENT
;

line_command:		LINE INT INT INT INT
			{ printf("Line from %d, %d to %d, %d",$2, $3, $4, $5); line($2, $3, $4, $5); }
;

point_command:		POINT INT INT
			{ printf("Point at %d, %d",$2,$3); point($2, $3); }
;

circle_command:		CIRCLE INT INT INT
			{ printf("Circle of radius %d centered at %d, %d", $4, $2, $3); circle($2, $3, $4); }
;

rectangle_command:	RECTANGLE INT INT INT INT
			{ printf("Rectangle beginning at %d, %d with height %d and width %d",$2,$3,$4,$5); rectangle($2, $3, $4, $5); }
;

set_color_stmt:		SET_COLOR INT INT INT
			{ printf("Setting color to r: %d g: %d b: %d",$2,$3,$4); colorcheck($2, $3, $4); }
;
%%
int main(int argc, char** argv){
	yyparse();
	return 0;
}

/*
* This prints an error message when an error occurs.
*
* @parameter msg The error message to print.
*/
void yyerror(const char* msg){
	fprintf(stderr, "Error: %s\n", msg);
}

/*
* This checks the values for setting the color to be sure
* that the RGB values are between 0 and 255.
*
* @parameter r The value for red.
* @parameter g The value for green.
* @parameter b The value for blue.
*/
void colorcheck(int r, int g, int b){
	if ((r>=0 && r<=255) && (g>=0 && g<=255) && (b>=0 && b<=255)){
		set_color(r, g, b);
	}
	else{
		yyerror("Invalid color value(s)");
	}
}
