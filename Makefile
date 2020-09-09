# list cad files explicitely to avoid failing ones
#stp_files := $(wildcard *.step)
stp_files := PipeCurveRadiusLarger.step
geo_files := $(wildcard *.geo)
msh_files := $(stp_files:.step=.msh) $(geo_files:.geo=.msh)

$(info    stp_files $(stp_files))
$(info    geo_files $(geo_files))
$(info    msh_files $(msh_files))

all: $(msh_files)
.PHONY: all

%.msh: %.step Makefile
	echo "mesh: $@ step: $<"
	gmsh -3 -clcurv 20 $<

%.msh: %.geo
	echo "mesh: $@ geo: $<"
	gmsh -3 $<

clean:
	rm -f *.msh
