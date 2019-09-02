# simcenter_clusters_excises
Tutorials and training excises for using simcenter clusters

# Ts117 job runs
ssh user@ts.simcenter.utc.edu

$ module load sge
$ pbs *.pbs

## sample PBS
-bash-4.2$ cat ts_yeastPIN_job1.pbs  <br>
#!/bin/bash -l  <br>
#$ -S /bin/bash <br>
#$ -N yPIN.Dang.001.col4  <br>
#$ -cwd  <br>
. /etc/profile.d/modules.sh  <br>
module load shared <br>
module load R/3.4.3 <br> 
cmd="R -f yeast_Zscore_GO-DangCR.R" <br> 
$cmd  <br>
<br> 

# QBERT job runs


