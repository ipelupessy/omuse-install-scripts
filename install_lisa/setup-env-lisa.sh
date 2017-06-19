#!/bin/bash

# environment settings and module loading for running amuse, omuse
# note: run this with source so that the settings reamin in effect

module load cmake/3.5.1
module load netcdf/intel
module load openmpi/intel/2.0.0 
module load hdf5/intel
module load fortran/intel
module load c/intel/64
module load python/2.7.12-intel

AMUSE=$HOME/amuse
PYTHONPATH=$PYTHONPATH:$AMUSE/src/
export PYTHONPATH

source $HOME/meteo/bin/activate
