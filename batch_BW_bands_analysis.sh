#!/bin/bash
#SBATCH -p pierce # Partition to submit to, could also be 'shared' or 'serial_requeue' others
#SBATCH -N 1 # To ensure that all cores are on one machine
#SBATCH -n 1 # Number of cores for running, should match the statement in srun
#SBATCH -t 0-04:00 # Runtime in days-hours:minutes
#SBATCH --mem 200 # Memory in MB
#SBATCH -o OUTOUT_LOG_DIRECTORY/%A.out # File to which standard out will be written
#SBATCH -e ERROR_LOG_DIRECTORY/%A.err # File to which standard err will be written
#SBATCH --mail-type=ALL # Types of email notifications permitted for this job- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=[USER_EMAIL_HERE] # Email to which notifications will be sent

SPP_MATRICES_DIR=$1
MORPH_MATRICES_DIR=$2
MATLAB_CODE_LIBRARY=$3
RESULT_DIR=$4
REF_THRESHOLD=$5

mkdir -p $RESULT_DIR

for BAND_NO in {1..10}
do
sbatch BW_bands_analysis.sh $SPP_MATRICES_DIR $MORPH_MATRICES_DIR $MATLAB_CODE_LIBRARY $RESULT_DIR $BAND_NO $REF_THRESHOLD
#echo $BAND_NO
done
