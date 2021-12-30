#!/bin/bash
#SBATCH -p test # Partition to submit to, could also be 'shared' or 'serial_requeue' others
#SBATCH -N 1 # To ensure that all cores are on one machine
#SBATCH -n 2 # Number of cores for running, should match the statement in srun
#SBATCH -t 0-03:00 # Runtime in days-hours:minutes
#SBATCH --mem 1600 # Memory in MB
#SBATCH -o OUTOUT_LOG_DIRECTORY/%A.out # File to which standard out will be written
#SBATCH -e ERROR_LOG_DIRECTORY/%A.err # File to which standard err will be written
#SBATCH --mail-type=ALL # Types of email notifications permitted for this job- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=[USER_EMAIL_HERE] # Email to which notifications will be sent

MAT_DIR=$1
LIB_DIR=$2
JSON_DIR=$3
SAVE_DIR=$4
INNAME=$5
SPHINGIDAE=$6

module purge
#module load centos7/0.0.1-fasrc01
module load matlab/R2018b-fasrc01

cd $LIB_DIR
matlab -nodisplay -nosplash -nodesktop -r "calculateMorph2('$MAT_DIR','$LIB_DIR','$JSON_DIR','$SAVE_DIR','$INNAME','$SPHINGIDAE'); exit"
