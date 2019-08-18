# TurtleProlog
Toy project where the user is able to draw pictures saved in svg format by operating a "Turtle" via the following functions.

Every predicate here described checks if the "turtle" and "opstack" passed are valid.
Every predicate fails if "turtle" or "opstack" is invalid. 
"opstack" is valid only if each line that it contains is valid.

### 1) 	pencolor(Turtle, Color, NewTurtle)
	True is NewTurtle is the same as Turtle with color Color.
	Color must be one of [black,white,red,cyan,purple,green,blue,yellow].
	
### 2)	pendown(Turtle, Opstack, NewTurtle, NewOpstack)
	True if NewTurtle is the same as Turtle but with pen true.
	Opstack and NewOpstack are the same.
	
### 3)	penup(Turtle, Opstack, NewTurtle, NewOpstack)
	True if NewTurtle is the same as Turtle but with pen false.
	Opstack and NewOpstack are the same.
	
### 4) 	setx(Turtle, Opstack, X, NewTurtle, NewOpstack)
	True if NewTurtle is the same as Turtle but with x coordinate X.
	Opstack and NewOpstack are the same.
	X must be an integer.
	
### 5) 	sety(Turtle, Opstack, Y, NewTurtle, NewOpstack)
	True if NewTurtle is the same as Turtle but with y coordinate Y.
	Opstack and NewOpstack are the same.
	Y must be an integer.

### 6) 	setheading(Turtle, Opstack, Degrees, NewTurtle, NewOpstack)
	True if NewTurtle is the same as Turtle but with orientation Degrees.
	Opstack and NewOpstack are the same.
	Degrees must be an integer, 0 <= Degrees < 360.
	
### 7)	left(Turtle, Opstack, Degrees, NewTurtle, NewOpstack)
	True if NewTurtle is the same as Turtle 
	but with orientation equal to Turtle's orientation minus Degrees.
	Opstack and NewOpstack are the same.
	Degrees must be an integer, Degrees >= 0.
	Orientation is set %360 so Degrees can be greater than 360.
	Ex: orientation 0 turn left by 362 degrees, orientation = 358.
	
### 8)	right(Turtle, Opstack, Degrees, NewTurtle, NewOpstack)
	True if NewTurtle is the same as Turtle 
	but with orientation equal to Turtle's orientation plus Degrees.
	Opstack and NewOpstack are the same.
	Degrees must be an integer, Degrees >= 0.	
	Orientation is set %360 so Degrees can be greater than 360.
	Ex: orientation 0 turn left by 362 degrees, orientation = 2.
	
### 9)	forward(Turtle, OpStack, Distance, NewTurtle, NewOpstack)
	NewTurtle is the same as Turtle but with different x and y coordinates
	depending on the distance (and orientation) moved forwards.
	Distance must be an integer, Distance >= 0.
	A new line is added to the top of the opstack in NewOpstack
	only if the turtle's pen is true.
	The line is drawn from the previous position to the one after moving.
	
### 10) 	back(Turtle, OpStack, Distance, NewTurtle, NewOpstack)
	NewTurtle is the same as Turtle but with different x and y coordinates
	depending on the distance (and orientation) moved backwards.
	Distance must be an integer, Distance >= 0.
	A new line is added to the top of the opstack in NewOpstack
	only if the turtle's pen is true.
	The line is drawn from the previous position to the one after moving.	
	
### 11)	home(Turtle, OpStack, NewTurtle, NewOpstack)
	NewTurtle is the same as Turtle but with the origin (0,0) as coordinates.
	If the Turtle's pen is true then a line is drawn and added.
	The line is drawn from the previous position to (0,0).	
	
### 12) 	dumpsvg(Filename, Opstack)
	Creates an svg file named Filename with the contents of OpStack.
	OpStack cannot be empty.
	
## PS:
Se stai guardando questo progetto con l'intento di copiare evita perchè sicuro ti beccano.