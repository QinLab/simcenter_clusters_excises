rm(list=ls())

#R -f file --args start end
options(echo=TRUE) # if you want see commands in output file
args <- commandArgs(trailingOnly = TRUE)
print(args)
start = as.integer(args[1])
end = as.integer(args[2])

debug = 9

mydir = "/Users/yhw543/Documents/GitHub/simcenter_clusters_excises"
setwd(mydir)
list.files()
source('network.r')

net = read.table( "mito.tab", header=F, sep="\t", colClasses = c("character", "character") )
head(net)

for( i in start:end) {
 net.ms02 = ms02_singlerun_v2( net, indebug=0 )
 cmnd = paste( "mkdir ms02/", i, sep="")
 system( cmnd )
 outputname = paste( 'ms02/', i, '/', "ms02_",i,".tab", sep="")
 write.table(net.ms02, outputname, quote=F, row.names=F, sep="\t")
}
