#!/bin/bash
#SBATCH -p test # Partition to submit to, could also be 'shared' or 'serial_requeue' others
#SBATCH -N 1 # To ensure that all cores are on one machine
#SBATCH -n 1 # Number of cores for running, should match the statement in srun
#SBATCH -t 0-04:00 # Runtime in days-hours:minutes
#SBATCH --mem 200 # Memory in MB
#SBATCH -o OUTOUT_LOG_DIRECTORY/%A.out # File to which standard out will be written
#SBATCH -e ERROR_LOG_DIRECTORY/%A.err # File to which standard err will be written
#SBATCH --mail-type=ALL # Types of email notifications permitted for this job- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=[USER_EMAIL_HERE] # Email to which notifications will be sent

SPP_MATRICES_DIR=$1
MATLAB_CODE_LIBRARY=$2
JSON_DIR=$3
RESULT_DIR=$4
SPHINGIDAE=$5

mkdir -p $RESULT_DIR
cd $SPP_MATRICES_DIR
for matrix in $SPP_MATRICES_DIR/*_AllBandsMask.mat; do
#RAWTEMPLATE=$(basename "${matrix%.*}")
INNAME=$(basename $matrix)
sbatch single_morph_preprocessing.sh $SPP_MATRICES_DIR $MATLAB_CODE_LIBRARY $JSON_DIR $RESULT_DIR $INNAME $SPHINGIDAE
echo "$(basename "${matrix%.*}") has been submitted for reanalysis."
done

