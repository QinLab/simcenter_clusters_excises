# Simcenter_clusters_excises
Tutorials and training excises for using simcenter clusters

# ts117 job runs
ssh user@ts.simcenter.utc.edu

$ module load sge <br>
$ qsub *.pbs

HaoboGuo: You can also use <br> 
$ qavail #For available cores <br> 
$ qatatus -all #For checking status of running jobs, etc. <br> 

If you are using GPU and hope the entire node is used for your job (1 GPU+27CPU), you can use <br> 
$ qsub -excl=true job.pbs <br> 

## sample PBS for R
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

## sample PBS with taks ID
#!/bin/bash -l <br>
#$ -S /bin/bash <br> 
#$ -N somejobs <br>
#$ -cwd <br> 
#$ -t 1-100 <br> 
. /etc/profile.d/modules.sh <br> 
module load shared <br> 
cmd=" somecommand $SGE_TASK_ID " <br> 
$cmd <br> 

## sample PBS for Python Anaconda
#!/bin/bash -l <br>
#$ -S /bin/bash <br> 
#$ -N somejobs <br>
#$ -cwd <br> 
. /etc/profile.d/modules.sh <br> 
module load shared <br> 
module load anaconda <br> 
source activate grib <br>  #load an enviroment 'grib' is Hong Qin's enviroment for PyGRIB
cmd=" somecommand " <br> 
$cmd <br> 

####
# QBERT job runs
todo here 

# Lookout job runs
todo here


# redhat open stack
to do here

