#!/bin/bash -l
#SBATCH -A ict24_esp
#SBATCH -p boost_usr_prod
#SBATCH --time 1:00:00       # format: HH:MM:SS
#SBATCH -N 1
#SBATCH --ntasks-per-node=8
#SBATCH --cpus-per-task=4
#SBATCH --gpus-per-node=2
#SBATCH --mem-per-cpu=10000
#SBATCH --job-name=CDtutorial
#SBATCH --output=jupyter_notebook.txt
#SBATCH --error=jupyter_notebook.err


cd /leonardo_work/ICT24_ESP/sdigioia/Tutorial-causal-discovery/

source $HOME/.bashrc

module load profile/deeplrn
module load cuda/11.8
module load gcc/11.3.0
module load nccl
module load llvm
module load gsl
module load openmpi

conda activate /leonardo_work/ICT24_ESP/sdigioia/envs/newRLenv

# get tunneling info
XDG_RUNTIME_DIR=""
node=$(hostname -s)
user=$(whoami)
portval=8887

# print tunneling instructions jupyter-log
echo -e "
# Note: below 8888 is used to signify the port.
#       However, it may be another number if 8888 is in use.
#       Check jupyter_notebook_%j.err to find the port.

# Command to create SSH tunnel:
ssh -N -f -L $portval:${node}:$portval ${user}@$login.leonardo.cineca.it
# Use a browser on your local machine to go to:
http://localhost:$portval/
"

jupyter-notebook --no-browser --ip=${node} --port=${portval}

# keep it alive
sleep 36000
