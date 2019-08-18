%%%% Grassi Marco 829664

get_turtle_x(Turtle, PosX):-
    Turtle =.. X,
    nth0(1, X, PosX).

get_turtle_y(Turtle, PosY):-
    Turtle =.. X,
    nth0(2, X, PosY).

get_turtle_orientation(Turtle, Orientation):-
    Turtle =.. X,
    nth0(3, X, Orientation).

get_turtle_color(Turtle, Color):-
    Turtle =.. X,
    nth0(4, X, Color).

get_turtle_pen(Turtle, Pen):-
    Turtle =.. X,
    nth0(5, X, Pen).

%true if the turtle is valid
is_turtle_valid(Turtle):-
    functor(Turtle,turtle,5),
    Turtle =.. TurtleAsList,
    nth0(1, TurtleAsList, PosX),
    integer(PosX),
    nth0(2, TurtleAsList, PosY),
    integer(PosY),
    nth0(3, TurtleAsList, Orientation),
    integer(Orientation),
    Orientation >= 0,
    Orientation < 360,
    nth0(4, TurtleAsList, Color),
    member(Color,[black,white,red,cyan,
                  purple,green,blue,yellow]),
    nth0(5, TurtleAsList, Pen),
    Pen == true.

is_turtle_valid(Turtle):-
    functor(Turtle,turtle,5),
    Turtle =.. TurtleAsList,
    nth0(1, TurtleAsList, PosX),
    integer(PosX),
    nth0(2, TurtleAsList, PosY),
    integer(PosY),
    nth0(3, TurtleAsList, Orientation),
    integer(Orientation),
    Orientation >= 0,
    Orientation < 360,
    nth0(4, TurtleAsList, Color),
    member(Color,[black,white,red,cyan,
                  purple,green,blue,yellow]),
    nth0(5, TurtleAsList, Pen),
    Pen == false.

%true if the line is valid
is_line_valid(Line):-
    functor(Line,line,5),
    Line =.. LineAsList,
    nth0(1, LineAsList, PosX1),
    nth0(2, LineAsList, PosY1),
    nth0(3, LineAsList, PosX2),
    nth0(4, LineAsList, PosY2),
    maplist(integer, [PosX1,PosY1,PosX2,PosY2]),
    nth0(5, LineAsList, Color),
    member(Color,[black,white,red,cyan,
                  purple,green,blue,yellow]).

%true if opstack and its contents are valid
is_opstack_valid([]).
is_opstack_valid(Opstack):-
    is_list(Opstack),
    maplist(is_line_valid, Opstack).

pencolor(Turtle, Color, turtle(PosX, PosY,
                               Orientation,Color ,Pen)):-
    is_turtle_valid(Turtle),
    member(Color,[black,white,red,cyan,
                  purple,green,blue,yellow]),
    Turtle =.. [_,PosX, PosY, Orientation, _, Pen].

pendown(Turtle, Opstack, turtle(PosX,PosY,
                                Orientation, Color, false),
        Opstack):-
    is_turtle_valid(Turtle),
    is_opstack_valid(Opstack),
    Turtle =.. [_,PosX, PosY, Orientation, Color, _].

penup(Turtle, Opstack, turtle(PosX,PosY,
                                Orientation, Color, true),
        Opstack):-
    is_turtle_valid(Turtle),
    is_opstack_valid(Opstack),
    Turtle =.. [_,PosX, PosY, Orientation, Color, _].

setx(Turtle, Opstack, X, turtle(X,PosY,Orientation,
                               Color,Pen), Opstack):-
    is_turtle_valid(Turtle),
    is_opstack_valid(Opstack),
    integer(X),
    Turtle =.. [_,_, PosY, Orientation, Color, Pen].

sety(Turtle, Opstack, Y,
     turtle(PosX,Y,Orientation,
            Color,Pen), Opstack):-
    is_turtle_valid(Turtle),
    is_opstack_valid(Opstack),
    integer(Y),
    Turtle =.. [_,PosX, _, Orientation, Color, Pen].

setheading(Turtle, Opstack, Degrees,
           turtle(PosX, PosY,
                  Degrees, Color, Pen), Opstack):-
    is_turtle_valid(Turtle),
    is_opstack_valid(Opstack),
    integer(Degrees),
    Degrees >= 0,
    Degrees < 360,
    Turtle =.. [_,PosX, PosY, _, Color, Pen].

left(Turtle, Opstack, Degrees,
     turtle(PosX, PosY,
            NewOrientation, Color, Pen), Opstack):-
    is_turtle_valid(Turtle),
    is_opstack_valid(Opstack),
    integer(Degrees),
    Degrees >= 0,
    Turtle =.. [_,PosX, PosY, Orientation, Color, Pen],
    Temp is Orientation - Degrees,
    NewOrientation is mod(Temp,360).

right(Turtle, Opstack, Degrees,
     turtle(PosX, PosY,
            NewOrientation, Color, Pen), Opstack):-
    is_turtle_valid(Turtle),
    is_opstack_valid(Opstack),
    integer(Degrees),
    Degrees >= 0,
    Turtle =.. [_,PosX, PosY, Orientation, Color, Pen],
    Temp is Orientation + Degrees,
    NewOrientation is mod(Temp,360).

%not pure, converts from 'turtle degrees' to degrees
turtle_to_math_deg(Tdeg,Mdeg):-
    Mdeg is mod(90 - Tdeg,360).

%not pure, converts from degrees to radians
math_to_rad_deg(Mdeg, Rad):-
    Rad is Mdeg * pi / 180.

%DistanceX contains the distance moved
distance_x(Orientation, Distance, DistanceX):-
    integer(Distance),
    Distance >= 0,
    math_to_rad_deg(Orientation, Rad),
    sin(Rad, Sin),
    DistanceX is round(Sin * Distance).

%DistanceY contains the distance moved
distance_y(Orientation, Distance, DistanceY):-
    integer(Distance),
    Distance >= 0,
    math_to_rad_deg(Orientation, Rad),
    cos(Rad, Cos),
    DistanceY is round(Cos * Distance).

forward(Turtle, OpStack, Distance,
        turtle(NewPosX,NewPosY,Orientation,
              Color, true), [NewLine | OpStack] ):-
    is_turtle_valid(Turtle),
    is_opstack_valid(OpStack),
    integer(Distance),
    Distance >= 0,
    Turtle =.. [_,PosX, PosY, Orientation, Color, true],
    distance_x(Orientation, Distance, DistanceX),
    distance_y(Orientation, Distance, DistanceY),
    NewPosX is PosX + DistanceX,
    NewPosY is PosY - DistanceY,
    NewLine =.. [line, PosX, PosY, NewPosX, NewPosY, Color].

forward(Turtle, OpStack, Distance,
        turtle(NewPosX,NewPosY,Orientation,
              Color, true), OpStack):-
    is_turtle_valid(Turtle),
    is_opstack_valid(OpStack),
    integer(Distance),
    Distance >= 0,
    Turtle =.. [_,PosX, PosY, Orientation, Color, false],
    distance_x(Orientation, Distance, DistanceX),
    distance_y(Orientation, Distance, DistanceY),
    NewPosX is PosX + DistanceX,
    NewPosY is PosY - DistanceY.


back(Turtle, OpStack, Distance,
        turtle(NewPosX,NewPosY,Orientation,
              Color, true), OpStack ):-
    is_turtle_valid(Turtle),
    is_opstack_valid(OpStack),
    integer(Distance),
    Distance >= 0,
    Turtle =.. [_,PosX, PosY, Orientation, Color, false],
    distance_x(Orientation, Distance, DistanceX),
    distance_y(Orientation, Distance, DistanceY),
    NewPosX is PosX - DistanceX,
    NewPosY is PosY + DistanceY.


back(Turtle, OpStack, Distance,
        turtle(NewPosX,NewPosY,Orientation,
              Color, true), [NewLine | OpStack] ):-
    is_turtle_valid(Turtle),
    is_opstack_valid(OpStack),
    integer(Distance),
    Distance >= 0,
    Turtle =.. [_,PosX, PosY, Orientation, Color, true],
    distance_x(Orientation, Distance, DistanceX),
    distance_y(Orientation, Distance, DistanceY),
    NewPosX is PosX - DistanceX,
    NewPosY is PosY + DistanceY,
    NewLine =.. [line, PosX, PosY, NewPosX, NewPosY, Color].

home(Turtle, OpStack,
     turtle(0, 0, Orientation, Color, true),
     [line(PosX, PosY, 0, 0, Color) | OpStack]):-
    is_turtle_valid(Turtle),
    is_opstack_valid(OpStack),
    Turtle =.. [_, PosX, PosY, Orientation, Color, true].

home(Turtle, OpStack,
     turtle(0, 0, Orientation, Color, false), OpStack):-
    is_turtle_valid(Turtle),
    is_opstack_valid(OpStack),
    Turtle =.. [_, _, _, Orientation, Color, false].

dumpsvg(Filename, OpStack):-
    string_concat(Filename, ".svg", FullName),
    open(FullName, write, OutStream),
    calc_viewbox(OpStack, Width, Height, MinX, MinY),
    format(OutStream,
           "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>~n",_),
    format(OutStream, "<svg width=\"~a\" height=\"~a\" viewBox=\"~a ~a ~a ~a\" xmlns=\"http://www.w3.org/2000/svg\">~n",
           [Width, Height, MinX, MinY, Width, Height]),
    reverse(OpStack, RevOpStack),
    write_line(RevOpStack, OutStream),
    format(OutStream, "</svg>", _),
    close(OutStream).

write_line([],_).
write_line([Line | LineRest], OutStream):-
    Line =.. [_, X1, Y1, X2, Y2, Color],
    format(OutStream,
           "<line x1=\"~a\" y1=\"~a\" x2=\"~a\" y2=\"~a\" stroke=\"~a\" stroke-width=\"1\"/>~n", [X1, Y1, X2, Y2, Color]),
    write_line(LineRest, OutStream).

%get x coordinates from a line
x_coords(Line, [X1,X2]):-
    Line =.. [line, X1, _, X2, _, _].

%get y coordinates from a line
y_coords(Line, [Y1,Y2]):-
    Line =.. [line, _, Y1, _, Y2, _].

%calculates Width Height MinX MinY necessary to the viewbox
calc_viewbox(OpStack, Width, Height, MinX, MinY):-
    is_opstack_valid(OpStack),
    maplist(x_coords, OpStack, TempListX),
    maplist(y_coords, OpStack, TempListY),
    flatten(TempListX, ListX),
    flatten(TempListY, ListY),
    max_list(ListX, MaxX),
    max_list(ListY, MaxY),
    min_list(ListX, MinX),
    min_list(ListY, MinY),
    Width is abs(MaxX - MinX),
    Height is abs(MaxY - MinY).

red_square(Turtle, RT, ROS) :-
red_square(Turtle, [], RT, ROS).

red_square(Turtle, OpStack, RT, ROS) :-
forward(Turtle, OpStack, 100, T1, OS1),
right(T1, OS1, 90, T2, OS2),
forward(T2, OS2, 100, T3, OS3),
right(T3, OS3, 90, T4, OS4),
forward(T4, OS4, 100, T5, OS5),
right(T5, OS5, 90, T6, OS6),
forward(T6, OS6, 100, RT, ROS).

draw_arrow(Turtle, NewTurtle, NewOpstack):-
    draw_arrow(Turtle, [], NewTurtle, NewOpstack).

draw_arrow(Turtle, OpStack, NewTurtle, NewOpstack):-
    forward(Turtle, OpStack, 250, T, O),
    left(T, O, 90, T1, O1),
    forward(T1, O1, 100, T2, O2),
    right(T2, O2, 135, T3, O3),
    forward(T3, O3, 169, T4, O4),
    right(T4, O4, 90, T5, O5),
    forward(T5, O5, 169, T6, O6),
    left(T6, O6, 45, T7, O7),
    back(T7, O7, 100, T8, O8),
    left(T8, O8, 90, T10, O10),
    back(T10, O10, 250, T11, O11),
    right(T11, O11, 90, T12, O12),
    back(T12, O12, 40, NewTurtle, NewOpstack).











