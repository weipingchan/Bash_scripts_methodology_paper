#!/bin/bash
#SBATCH -p test # Partition to submit to, could also be 'shared' or 'serial_requeue' others
#SBATCH -N 1 # To ensure that all cores are on one machine
#SBATCH -n 8 # Number of cores for running, should match the statement in srun
#SBATCH -t 0-10:00 # Runtime in days-hours:minutes
#SBATCH --mem 4000 # Memory in MB
#SBATCH -o OUTOUT_LOG_DIRECTORY/%A.out # File to which standard out will be written
#SBATCH -e ERROR_LOG_DIRECTORY/%A.err # File to which standard err will be written
#SBATCH --mail-type=ALL # Types of email notifications permitted for this job- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=[USER_EMAIL_HERE] # Email to which notifications will be sent


PROBLEM_LIST_DIR=$1
PROBLEM_LIST_NAME=$2
SPP_MATRICES_DIR=$3
SPP_MATRICES_REMASK_DIR=$4

TAIL="AllBandsMask"

mkdir -p $SPP_MATRICES_REMASK_DIR
cd $PROBLEM_LIST_DIR
while read filename; do
cp ${SPP_MATRICES_DIR}${filename}_*$TAIL* "${SPP_MATRICES_REMASK_DIR}"
echo ${SPP_MATRICES_DIR}${filename}_$TAIL has been copied to "${SPP_MATRICES_REMASK_DIR}"
done < "${PROBLEM_LIST_NAME}"
