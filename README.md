# simcenter_clusters_excises
Tutorials and training excises for using simcenter clusters

# Ts117 job runs
ssh user@ts.simcenter.utc.edu

$ module load sge
$ pbs *.pbs

## sample PBS
-bash-4.2$ cat ts_yeastPIN_job1.pbs  
#!/bin/bash -l 
#$ -S /bin/bash 
#$ -N yPIN.Dang.001.col4 
#$ -cwd 
. /etc/profile.d/modules.sh 
module load shared 
module load R/3.4.3 
cmd="R -f yeast_Zscore_GO-DangCR.R" 
$cmd 


# QBERT job runs


