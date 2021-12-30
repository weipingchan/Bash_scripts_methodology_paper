#!/bin/bash
#SBATCH -p test # Partition to submit to, could also be 'shared' or 'serial_requeue' others
#SBATCH -N 1 # To ensure that all cores are on one machine
#SBATCH -n 1 # Number of cores for running, should match the statement in srun
#SBATCH -t 0-04:00 # Runtime in days-hours:minutes
#SBATCH --mem 2000 # Memory in MB
#SBATCH -o OUTOUT_LOG_DIRECTORY/%A.out # File to which standard out will be written
#SBATCH -e ERROR_LOG_DIRECTORY/%A.err # File to which standard err will be written
#SBATCH --mail-type=ALL # Types of email notifications permitted for this job- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=[USER_EMAIL_HERE] # Email to which notifications will be sent

TIFF_IMG_DIR=$1
MATLAB_CODE_LIBRARY=$2
RESULT_DIR=$3
LABEL_FILE_NAME=$4
LEGACY=$5

#create the result directory and run single_img_analysis.sh on all images
mkdir -p $RESULT_DIR
cd $TIFF_IMG_DIR
for tiffimg in $TIFF_IMG_DIR/*_uv.tiff; do
RAWTEMPLATE=$(basename "${tiffimg%.*}")
TEMPLATE=$(echo ${RAWTEMPLATE%_uv})
sbatch single_img_analysis.sh $TIFF_IMG_DIR $MATLAB_CODE_LIBRARY $RESULT_DIR $LABEL_FILE_NAME $TEMPLATE $LEGACY 0
done

