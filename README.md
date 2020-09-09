# Pipe mesh experiments

These are pipe experiment, mostly with gmsh. Some examples require Gmsh version >= 4.6.0. The STEP files are exported from FreeCAD version 0.19.

To compile all the meshes, simply run `make` in a terminal. Assumes that gmsh is found in PATH.

* PipeBoundaryLayerCurve.geo: Pipe with boundary layer, extruded using a wire (FAIL)
* PipeBoundaryLayerSimple.geo: Pipe with boundary layer, extruded with translation (OK) 
* PipeSolidFluid.geo: fluid and solid domains, obtained with a boolean difference between volumes (FAIL)
* CurvedExtrusion.geo: two section extrusion with translation and rotation (OK)

