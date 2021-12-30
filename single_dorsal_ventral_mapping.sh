#!/bin/bash
#SBATCH -p pierce # Partition to submit to, could also be 'shared' or 'serial_requeue' others
#SBATCH -N 1 # To ensure that all cores are on one machine
#SBATCH -n 2 # Number of cores for running, should match the statement in srun
#SBATCH -t 0-20:00 # Runtime in days-hours:minutes
#SBATCH --mem 24000 # Memory in MB
#SBATCH -o OUTOUT_LOG_DIRECTORY/%A.out # File to which standard out will be written
#SBATCH -e ERROR_LOG_DIRECTORY/%A.err # File to which standard err will be written
#SBATCH --mail-type=ALL # Types of email notifications permitted for this job- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=[USER_EMAIL_HERE] # Email to which notifications will be sent

#serial_requeue

MORPH_MATRICES_DIR=$1
SPP_MATRICES_DIR=$2
MANUAL_GRID_DIR=$3
MATLAB_CODE_LIBRARY=$4
RESULT_DIR=$5
INNAME=$6
NIntD=$7

module purge
#module load centos7/0.0.1-fasrc01
module load matlab/R2018b-fasrc01

cd $MATLAB_CODE_LIBRARY
matlab -nodisplay -nosplash -nodesktop -r "dorsal_ventral_analysis5('$MORPH_MATRICES_DIR','$SPP_MATRICES_DIR','$MANUAL_GRID_DIR','$MATLAB_CODE_LIBRARY','$RESULT_DIR','$INNAME','$NIntD'); exit"
