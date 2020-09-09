SetFactory("OpenCASCADE");

vol() = ShapeFromFile("PipeSolidFluid.step");


Mesh.CharacteristicLengthFromCurvature = 1;
Mesh.MinimumElementsPerTwoPi = 20;


SyncModel;
Coherence;

