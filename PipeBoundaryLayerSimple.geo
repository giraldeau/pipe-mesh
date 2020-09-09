// pipe with boundary layer internal surface

SetFactory("OpenCASCADE");

// Parameters
rad = 1e-3;
length = 1e-3;

//Initial Mesh Control Parameters
mshc = 2e-4;

Disk(1) = { rad/2, rad/2, 0, rad};
Characteristic Length { PointsOf{ Surface{1}; } } = mshc;

// Setup Boundary Layer Mesh
Field[1] = BoundaryLayer;
Field[1].EdgesList = { Boundary{Surface{1}; } };
Field[1].hfar = rad/10;          // Element size far from the wall
Field[1].hwall_n = rad/100;      // Mesh Size Normal to the The Wall
Field[1].thickness = rad/4;      // Maximum thickness of the boundary layer
Field[1].ratio = 1.2;            // Size Ratio Between Two Successive Layers
BoundaryLayer Field = 1;

Extrude {0, 0, length} { Surface{1}; Layers{10}; };
