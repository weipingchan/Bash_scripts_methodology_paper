#!/bin/bash
#SBATCH -p pierce # Partition to submit to, could also be 'shared' or 'serial_requeue' others
#SBATCH -N 1 # To ensure that all cores are on one machine
#SBATCH -n 2 # Number of cores for running, should match the statement in srun
#SBATCH -t 0-10:00 # Runtime in days-hours:minutes
#SBATCH --mem 16000 # Memory in MB
#SBATCH -o OUTOUT_LOG_DIRECTORY/%A.out # File to which standard out will be written
#SBATCH -e ERROR_LOG_DIRECTORY/%A.err # File to which standard err will be written
#SBATCH --mail-type=ALL # Types of email notifications permitted for this job- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=[USER_EMAIL_HERE] # Email to which notifications will be sent

SPP_MATRICES_DIR=$1
MATLAB_CODE_LIBRARY=$2
RESULT_DIR=$3
GROUP_FILE_NAME=$4
PREFERENCE_FILE_NAME=$5

module purge
#module load centos7/0.0.1-fasrc01
module load matlab/R2018b-fasrc01

cd $MATLAB_CODE_LIBRARY
matlab -nodisplay -nosplash -nodesktop -r "dorsal_ventral_summary('$SPP_MATRICES_DIR','$MATLAB_CODE_LIBRARY','$RESULT_DIR','$GROUP_FILE_NAME','$PREFERENCE_FILE_NAME'); exit"
