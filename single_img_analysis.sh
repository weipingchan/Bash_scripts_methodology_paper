#!/bin/bash
#SBATCH -p serial_requeue # Partition to submit to, could also be 'shared' or 'serial_requeue' others
#SBATCH -N 1 # To ensure that all cores are on one machine
#SBATCH -n 4 # Number of cores for running
#SBATCH -t 0-18:00 # Runtime in days-hours:minutes
#SBATCH --mem 24000 # Memory in MB
#SBATCH -o OUTOUT_LOG_DIRECTORY/%A.out # File to which standard out will be written
#SBATCH -e ERROR_LOG_DIRECTORY/%A.err # File to which standard err will be written
#SBATCH --mail-type=ALL # Types of email notifications permitted for this job- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=[USER_EMAIL_HERE] # Email to which notifications will be sent

TIFF_IMG_DIR=$1
MATLAB_CODE_LIBRARY=$2
RESULT_DIR=$3
LABEL_FILE_NAME=$4
TEMPLATE=$5
LEGACY=$6
MANUAL=$7
evidence_name='forensic-evidence-labels.jpg'

module purge
#module load centos7/0.0.1-fasrc01
module load matlab/R2018b-fasrc01

#load matlab image processing package from matlab code library
cd $MATLAB_CODE_LIBRARY
matlab -nodisplay -nosplash -nodesktop -r "single_img_processing('$TIFF_IMG_DIR','$MATLAB_CODE_LIBRARY','$RESULT_DIR','$LABEL_FILE_NAME','$evidence_name','$TEMPLATE','$LEGACY','$MANUAL'); exit"
