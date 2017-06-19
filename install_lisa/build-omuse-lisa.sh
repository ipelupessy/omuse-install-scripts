#!/bin/bash

# script for compiling amuse on Lisa
# Fredrik Jansson 2017, CWI
# Only the Intel fortran compiler is supported by this script, for now.

(
set -x

LOCATION=$1
PRGENV=$2

PYENV=meteo



echo "Building omuse meteo branch at amuse location $1 for compiler $2..."

echo "Switching compiler suite..."
case $PRGENV in
gnu   ) echo 'GNU options not done yet'
	exit
        ;;
intel ) echo 'Setting up modules for intel compiler'
	module load python/2.7.12-intel
	# this python installation already has mpi4py - nice!

	module load cmake/3.5.1
	module load netcdf/intel
	module load openmpi/intel/2.0.0 
	module load hdf5/intel
	module load fortran/intel
	module load c/intel/64
        ;;
cray  ) echo 'This is not a cray'
	exit
        ;;
*     ) echo "Compiler suite $PRGENV unknown..."
	exit
	;;
esac



source ${PYENV}/bin/activate

cd $LOCATION
LOCATION=`pwd` #get absolute path of the base location
echo $LOCATION


#echo "The module FFTW directory is $FFTW_DIR"
#FFTWDIR="$(echo $FFTW_DIR | rev | cut -d'/' -f2- | rev)"
#echo "The actual FFTW directory is $FFTWDIR"


echo -e '\n --- Building Amuse --- \n'

export PYTHON=python # for amuse makefile - otherwise defaults to python2.6

echo "Cleaning up source code..."
make clean

echo "Configuring build..."
./configure FC=ifort CC=icc --with-netcdf=`nc-config  --prefix`

make

)
