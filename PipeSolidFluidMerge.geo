SetFactory("OpenCASCADE");

Mesh.CharacteristicLengthFromCurvature = 1;
Mesh.MinimumElementsPerTwoPi = 20;

Merge "PipeSolid.step";
Mesh.CharacteristicLengthMin = 10;
Mesh.CharacteristicLengthMax = 10;

Merge "PipeFluid.step";
Mesh.CharacteristicLengthMin = 2;
Mesh.CharacteristicLengthMax = 2;

SyncModel;
Coherence;

