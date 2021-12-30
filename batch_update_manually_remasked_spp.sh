#!/bin/bash
#SBATCH -p test # Partition to submit to, could also be 'shared' or 'serial_requeue' others
#SBATCH -N 1 # To ensure that all cores are on one machine
#SBATCH -n 2 # Number of cores for running, should match the statement in srun
#SBATCH -t 0-18:00 # Runtime in days-hours:minutes
#SBATCH --mem 24000 # Memory in MB
#SBATCH -o OUTOUT_LOG_DIRECTORY/%A.out # File to which standard out will be written
#SBATCH -e ERROR_LOG_DIRECTORY/%A.err # File to which standard err will be written
#SBATCH --mail-type=ALL # Types of email notifications permitted for this job- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=[USER_EMAIL_HERE] # Email to which notifications will be sent

REMASKED_TIFF_DIR=$1
SPP_MATRICES_REMASK_DIR=$2
MATLAB_CODE_LIBRARY=$3
CORRECTED_MATRICES_SAVE_DIR=$4

mkdir -p $CORRECTED_MATRICES_SAVE_DIR
module purge
#module load centos7/0.0.1-fasrc01
module load matlab/R2018b-fasrc01

cd $MATLAB_CODE_LIBRARY
matlab -nodisplay -nosplash -nodesktop -r "updateMatrixWithManualMask('$REMASKED_TIFF_DIR','$SPP_MATRICES_REMASK_DIR','$MATLAB_CODE_LIBRARY','$CORRECTED_MATRICES_SAVE_DIR'); exit"
