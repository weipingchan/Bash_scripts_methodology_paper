#!/bin/bash
#SBATCH -p pierce # Partition to submit to, could also be 'shared' or 'serial_requeue' others
#SBATCH -N 1 # To ensure that all cores are on one machine
#SBATCH -n 8 # Number of cores for running, should match the statement in srun
#SBATCH -t 0-20:00 # Runtime in days-hours:minutes
#SBATCH --mem 4000 # Memory in MB
#SBATCH -o OUTOUT_LOG_DIRECTORY/%A.out # File to which standard out will be written
#SBATCH -e ERROR_LOG_DIRECTORY/%A.err # File to which standard err will be written
#SBATCH --mail-type=ALL # Types of email notifications permitted for this job- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=[USER_EMAIL_HERE] # Email to which notifications will be sent

SPP_MATRICES_DIR=$1
SAVE_DIR=$2

SUFFIX="AllBandsMask"

mkdir -p $SAVE_DIR

for file in $SPP_MATRICES_DIR/*$SUFFIX*; do
	cp -u ${file} "${SAVE_DIR}"
done
