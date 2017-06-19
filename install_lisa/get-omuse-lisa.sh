#!/bin/bash

# Script for obtaining amuse, omuse
# and their dependencies. For use on the Lisa system.
# Assumes intel compiler.
# Fredrik Jansson 2017, CWI

# get AMUSE
git clone https://github.com/ipelupessy/amuse/

pushd amuse
# minimal branch with no bundled codes
git checkout minimal 

cd src

# get OMUSE
hg clone https://bitbucket.org/omuse/omuse
hg checkout meteo

# set up python modules and environment
cd

module load python/2.7.12-intel
module load cmake/3.5.1
module load netcdf/intel
module load openmpi/intel/2.0.0 
module load hdf5/intel
module load fortran/intel
module load c/intel/64

pip install --user virtualenv
# installed to .local/bin/virtualenv
PATH=$PATH:~/.local/bin/

# create a virtual environment named meteo 

virtualenv meteo
source meteo/bin/activate

pip install moviepy f90nml numpy scipy matplotlib nose h5py docutils netCDF4



# pip install mpi4py -- doesn't work
# this works:
easy_install mpi4py

# test mpi4py: 
# mpiexec -n 5 python -m mpi4py helloworld


popd # back to starting directory
