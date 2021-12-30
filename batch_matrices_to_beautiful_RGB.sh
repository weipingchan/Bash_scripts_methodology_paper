#!/bin/bash
#SBATCH -p test # Partition to submit to, could also be 'shared' or 'serial_requeue' others
#SBATCH -N 1 # To ensure that all cores are on one machine
#SBATCH -n 2 # Number of cores for running, should match the statement in srun
#SBATCH -t 1-00:00 # Runtime in days-hours:minutes
#SBATCH --mem 20000 # Memory in MB
#SBATCH -o OUTOUT_LOG_DIRECTORY/%A.out # File to which standard out will be written
#SBATCH -e ERROR_LOG_DIRECTORY/%A.err # File to which standard err will be written
#SBATCH --mail-type=ALL # Types of email notifications permitted for this job- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=[USER_EMAIL_HERE] # Email to which notifications will be sent

SPP_MATRICES_DIR=$1
MATLAB_CODE_LIBRARY=$2
RESULT_DIR=$3
REMOVE_BACKGROUND=$4 # remove background or not (1-remove/0-do not)
IMG_EXTENSION=$5 #jpg, png, tiff
RESOLUTION=$6 #DPI

mkdir -p $RESULT_DIR

#source new-modules.sh
module load matlab
#module load matlab
cd $MATLAB_CODE_LIBRARY
matlab -nodisplay -nosplash -nodesktop -r "matrice2beautyRGBImgs2('$SPP_MATRICES_DIR','$MATLAB_CODE_LIBRARY','$RESULT_DIR','$REMOVE_BACKGROUND','$IMG_EXTENSION','$RESOLUTION'); exit"
