# awesome-slurm
Some helpful scripts for slurm
# How To Use
1. `chmod +x ./*`
2. `./install.sh` for bash or `./install_zsh.sh` for zsh
2. `your_command`


## Scripts info
1. `checkmyprocess.sh` will show the `squeue -u "username"`; could accept some username input, such as "chekcmyprocess.sh david" will show the info about david 
2. `show_node_info.py` will show how many server are there and how many gpus are available
3. `sbatch --mail-user=xxx@xxx --mail-type=BEGIN,END xxx.slurm` will send begin and end info to your email

# Notice 
As this repo is developing now, If you have some other need, Let me know !
