// pipe with boundary layer internal surface

SetFactory("OpenCASCADE");

// Parameters
rad = 1;
length = 1;

//Initial Mesh Control Parameters
mshc = 0.2;

Point(1) = {0, 0, 0, mshc};
Point(2) = {0, 0, 1, mshc};
Point(3) = {0, 1.5, 1, mshc};
Point(4) = {0, 1.5, 2.5, mshc};
Point(5) = {0, 2.5, 2.5, mshc};

Line(3) = {1, 2};
Circle(2) = {2, 3, 4};
Line(4) = {4, 5};
Wire(100) = {3, 2, 4};

Disk(1) = { 0, 0, 0, rad};

// Setup Boundary Layer Mesh
Field[1] = BoundaryLayer;
Field[1].EdgesList = { Boundary{Surface{1}; } };
Field[1].hfar = rad/10;          // Element size far from the wall
Field[1].hwall_n = rad/100;      // Mesh Size Normal to the The Wall
Field[1].thickness = rad/4;      // Maximum thickness of the boundary layer
Field[1].ratio = 1.2;            // Size Ratio Between Two Successive Layers
BoundaryLayer Field = 1;

// The resulting extrusion ignores the boundary layer of the surface
Extrude { Surface{1}; } Using Wire {100}
Delete { Surface{1}; }

