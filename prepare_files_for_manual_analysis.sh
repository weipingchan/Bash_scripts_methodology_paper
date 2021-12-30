#!/bin/bash
#SBATCH -p pierce # Partition to submit to, could also be 'shared' or 'serial_requeue' others
#SBATCH -N 1 # To ensure that all cores are on one machine
#SBATCH -n 1 # Number of cores for running, should match the statement in srun
#SBATCH -t 0-04:00 # Runtime in days-hours:minutes
#SBATCH --mem 2000 # Memory in MB
#SBATCH -o OUTOUT_LOG_DIRECTORY/%A.out # File to which standard out will be written
#SBATCH -e ERROR_LOG_DIRECTORY/%A.err # File to which standard err will be written
#SBATCH --mail-type=ALL # Types of email notifications permitted for this job- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=[USER_EMAIL_HERE] # Email to which notifications will be sent

PROBLEM_LIST_DIR=$1
PROBLEM_LIST_NAME=$2
WAVELENGTH_BAND=$3
TIFF_IMG_DONE_DIR=$4
TIFF_IMG_DIR=$5
MANUAL_DRAWER_CORRECTION_DIR=$6

cd $PROBLEM_LIST_DIR
while read filename; do

mv ${TIFF_IMG_DONE_DIR}/${filename}_* "${TIFF_IMG_DIR}"
echo ${TIFF_IMG_DONE_DIR}${filename}_* has been moved to "${TIFF_IMG_DIR}"

cp ${TIFF_IMG_DIR}/${filename}_$WAVELENGTH_BAND* "${MANUAL_DRAWER_CORRECTION_DIR}"
echo ${TIFF_IMG_DIR}${filename}_$WAVELENGTH_BAND* has been copied to "${MANUAL_DRAWER_CORRECTION_DIR}"

done < "${PROBLEM_LIST_NAME}"
