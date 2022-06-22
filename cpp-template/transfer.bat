set files=main.cpp Makefile run.slurm source output
if not [%1] == [] set files=%1
scp -r %files% gg25@nots.rice.edu:/scratch/gg25
ssh gg25@nots.rice.edu