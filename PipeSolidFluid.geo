SetFactory("OpenCASCADE");

vol() = ShapeFromFile("PipeSolidFluid.step");

// Mesh.CharacteristicLengthFromCurvature = 0.1;

SyncModel;
Coherence;

