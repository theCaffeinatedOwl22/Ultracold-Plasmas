#!/bin/bash
#SBATCH --job-name=sims
#SBATCH --array=0-5
#SBATCH --partition=scavenge
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --time=04:00:00
#SBATCH --mem-per-cpu=1024M

echo "My job ran on:"
echo $SLURM_NODELIST
if [[ -d $SHARED_SCRATCH/$USER && -w $SHARED_SCRATCH/$USER ]]
then
    srun objects/run -m input -o output/06.22.22/set_$SLURM_ARRAY_TASK_ID
fi
