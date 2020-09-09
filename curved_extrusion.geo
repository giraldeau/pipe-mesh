/*==============================*/
/*========= Parameters =========*/
/*==============================*/
L3 = 0.0;       // Z du bas de la sonde
D1 = 1.0;       //diameter of small section
ratioBL = 0.4;  //Boundary layer fraction

// Distributions des mailles
transfinite_core = 10;
transfinite_circonf = transfinite_core;
transfinite_edge_in = 15;
transfinite_edge_out = 25;
inProg = 0.85;												// Progession factor for transfinite_edge_in
outProg = 1.25;											// Progession factor for transfinite_edge_out
N  = 5; 														// Number of extruded nodes - linear extrusion
Nr = 10; 														// Number of extruded nodes - curved extrusion
by = 4; 														// Progression factor in tanh


/*===============================*/
/*==== Calculated parameters ====*/
/*===============================*/
R1 = 0.5*D1;  //radius of small section
BL = (1-ratioBL)*R1; //transverse dimension of the core (without boundary layer)

//lengths for core and O-Grid, at 45 deg
QL = (1/Sqrt(2))*BL;
QR = (1/Sqrt(2))*R1;


/* ================== */
/* ==== Geometry ==== */
/* ================== */
Point(1) = {  0,   0, +L3};
Point(2) = {+BL,   0, +L3};
Point(3) = {+QL, -QL, +L3};
Point(4) = {  0, -BL, +L3};
Point(5) = {-QL, -QL, +L3};
Point(6) = {-BL,   0, +L3};
Point(7) = {-QL, +QL, +L3};
Point(8) = {  0, +BL, +L3};
Point(9) = {+QL, +QL, +L3};

//core lines
Line(1) = {1,2};
Line(2) = {2,3};
Line(3) = {3,4};
Line(4) = {4,1};
Line(5) = {4,5};
Line(6) = {5,6};
Line(7) = {6,1};
Line(8) = {6,7};
Line(9) = {7,8};
Line(10) = {8,1};
Line(11) = {8,9};
Line(12) = {9,2};

Transfinite Line {1,4,7,10} = transfinite_core;
Transfinite Line {2,3,5,6,8,9,11,12} = transfinite_circonf;

//core surfaces
Line Loop(1) = {1,2,3,4};
Plane Surface(1) = {1};
Line Loop(2) = {-4,5,6,7};
Plane Surface(2) = {2};
Line Loop(3) = {-7,8,9,10};
Plane Surface(3) = {3};
Line Loop(4) = {-10,11,12,-1};
Plane Surface(4) = {4};
Transfinite Surface {1,2,3,4} = {};
//Recombine Surface {1,2,3,4};

//1st BL
Point(10) = {+R1,   0, +L3};
Point(11) = {+QR, -QR, +L3};
Point(12) = {  0, -R1, +L3};
Point(13) = {-QR, -QR, +L3};
Point(14) = {-R1,   0, +L3};
Point(15) = {-QR, +QR, +L3};
Point(16) = {  0, +R1, +L3};
Point(17) = {+QR, +QR, +L3};

//1st BL Lines
Line(13) = {2,10};
Line(14) = {3,11};
Line(15) = {4,12};
Line(16) = {5,13};
Line(17) = {6,14};
Line(18) = {7,15};
Line(19) = {8,16};
Line(20) = {9,17};

Transfinite Line {13,14,15,16,17,18,19,20} = transfinite_edge_in Using Progression inProg;
//Transfinite Line {13,14,15,16,17,18,19,20} = transfinite_edge_in Using Bump inProg;


Circle(21) = {10,1,11};
Circle(22) = {11,1,12};
Circle(23) = {12,1,13};
Circle(24) = {13,1,14};
Circle(25) = {14,1,15};
Circle(26) = {15,1,16};
Circle(27) = {16,1,17};
Circle(28) = {17,1,10};

Transfinite Line {21,22,23,24,25,26,27,28} = transfinite_core;

//1st BL surfaces
Line Loop(5) = {13,21,-14,-2};
Plane Surface(5) = {5};
Line Loop(6) = {14,22,-15,-3};
Plane Surface(6) = {6};
Line Loop(7) = {15,23,-16,-5};
Plane Surface(7) = {7};
Line Loop(8) = {16,24,-17,-6};
Plane Surface(8) = {8};
Line Loop(9) = {17,25,-18,-8};
Plane Surface(9) = {9};
Line Loop(10) = {18,26,-19,-9};
Plane Surface(10) = {10};
Line Loop(11) = {19,27,-20,-11};
Plane Surface(11) = {11};
Line Loop(12) = {20,28,-13,-12};
Plane Surface(12) = {12};

Transfinite Surface {5,6,7,8,9,10,11,12};
//Recombine Surface {5,6,7,8,9,10,11,12};


//Progression of extruded mesh using sinh
For i In {0:N-1}
 one[i] = 1;
 layer[i] = Sinh(by*(i+1)/(N))/Sinh(by);
 //Printf("%g", layer[i]);
EndFor

// Curved extrusion (limited to angles <Pi)
Extrude{ {1,0,0}, {0,2*D1,0}, -2*Pi/3 } { Surface{1,2,3,4,5,6,7,8,9,10,11,12}; Layers{Nr} ;} // Layers{ one[] , layer[] }; Recombine;}

// Linear extrusion
Extrude{0,0,-2} { Surface{1,2,3,4,5,6,7,8,9,10,11,12} ; Layers{N} ;}

Delete one;
Delete layer;
