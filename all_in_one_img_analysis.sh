#!/bin/bash
#SBATCH -p pierce # Partition to submit to, could also be 'shared' or 'serial_requeue' others
#SBATCH -N 1 # To ensure that all cores are on one machine
#SBATCH -n 8 # Number of cores for running, should match the statement in srun
#SBATCH -t 2-00:00 # Runtime in days-hours:minutes
#SBATCH --mem 10000 # Memory in MB
#SBATCH -o OUTOUT_LOG_DIRECTORY/%A.out # File to which standard out will be written
#SBATCH -e ERROR_LOG_DIRECTORY/%A.err # File to which standard err will be written
#SBATCH --mail-type=ALL # Types of email notifications permitted for this job- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=[USER_EMAIL_HERE] # Email to which notifications will be sent


DCRAW_DIR=$1
NEF_IMG_DIR=$2
TIFF_IMG_DIR=$3

#Load dcraw module (self-installed)
module try-load $DCRAW_DIR/dcraw

#Convert raw NEF files, looping through the directory
cd $NEF_IMG_DIR
for nefimg in $NEF_IMG_DIR/*.nef; do
$DCRAW_DIR/dcraw -4 -T -w -o 0 -v "$nefimg"
done

#Save the resulting TIFF files to another directory
mkdir -p $TIFF_IMG_DIR
mv $NEF_IMG_DIR/*.tiff $TIFF_IMG_DIR


#Start the batch image analysis
MATLAB_CODE_LIBRARY=$4
RESULT_DIR=$5
LABEL_FILE_NAME=$6
LEGACY=$7

sbatch batch_img_analysis.sh $TIFF_IMG_DIR $MATLAB_CODE_LIBRARY $RESULT_DIR $LABEL_FILE_NAME $LEGACY



