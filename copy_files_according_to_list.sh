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

PROBLEM_LIST_DIR=$1 #directory containing txt file listing problematic filenames
PROBLEM_LIST_NAME=$2 #filename of txt file containing list of problematic filenames
SUFFIX=$3 #suffix of files to be copied
FILE_DIR=$4 #source directory containing files to be copied
SAVE_DIR=$5 #destination of copied files

mkdir -p $SAVE_DIR
cd $PROBLEM_LIST_DIR
while read filename; do
cp ${FILE_DIR}${filename}_$SUFFIX* "${SAVE_DIR}"
echo ${FILE_DIR}${filename}_$SUFFIX* has been moved to "${SAVE_DIR}"
done < "${PROBLEM_LIST_NAME}"
