#require(igraph)
rm(list=ls())
debug = 0
#set.seed(2014)
permute.pairs.wo.selfpairs = function( inpairs,  ncycles=10, debug=1 ) {
  if (ncycles >= 1 ) {
    if(debug) {
      print(paste('ncycles=', ncycles))
    }
    longids = c(as.character(inpairs[,1]), as.character(inpairs[,2]) )
    longids = sample(longids)
    len = length(inpairs[,1])
    newpairs = data.frame( cbind( longids[1:len], longids[(len+1): (2*len)]) )
    names(newpairs) = c('geneA', 'geneB')
    newpairs$geneA = as.character( newpairs$geneA)
    newpairs$geneB = as.character( newpairs$geneB)    
    newpairs$selfpairs = ifelse( newpairs$geneA == newpairs$geneB, 1, 0 )
    self.tb = newpairs[ newpairs$selfpairs==1, ]
    nonself.tb = newpairs[newpairs$selfpairs==0, ]
    if(debug) {
      print(paste("===selfpairs===="),NULL)
      print(self.tb)
      print(paste("================="),NULL)
    }
    if( length(self.tb[,1])>=1 ) {
      if ( ncycles == 0) { 
        #return (c(NA,NA, NA) );
        print(paste("ncycles reached zero, ncycles"),ncycles)
        print(paste("Abort!"),NULL)
        stop; 
      } else {
        ncycles = ncycles - 1
        splitPos = round( length(self.tb[,1]) * sqrt(ncycles) ) + 5  #2014Jan31 change 
        splitPos = min( splitPos, (length(nonself.tb[,1])-1 ) )
        selectedpairs = rbind(self.tb,  nonself.tb[1: splitPos, ] )
        restpairs = nonself.tb[ (splitPos + 1): length(nonself.tb[,1]), ]
        return( rbind(restpairs, permute.pairs.wo.selfpairs(selectedpairs, ncycles)))
      }
    } else {  
      return (newpairs)
    }
  } else {
    return( c(NA,NA,NA )) 
  }
}

##
#R -f file --args start end
options(echo=TRUE) # if you want see commands in output file
args <- commandArgs(trailingOnly = TRUE)
print(args)
start = as.integer(args[1])
end = as.integer(args[2])

debug = 9

#mydir = "/Users/yhw543/Documents/GitHub/simcenter_clusters_excises"
#setwd(mydir)
#list.files()
#source('network.r')

net = read.table( "mito.csv", header=T, sep=",", colClasses = c("character", "character") )
head(net)

for( i in start:end) {
 net.ms02 = permute.pairs.wo.selfpairs( net )
 cmnd = paste( "mkdir ms02/", i, sep="")
 system( cmnd )
 outputname = paste( 'ms02/', i, '/', "ms02_",i,".csv", sep="")
 write.table(net.ms02, outputname, quote=F, row.names=F, sep=",")
}

#do they have the same degree?
#t1 = table(c(net[,1],net[,2]))
#t2 = table(c(net.ms02[,1],net.ms02[,2]))
#comp <- t1 == t2
#table(comp)
#tf = comp[comp==F]; tf
#t1[names(tf)[1]]
#t1[names(tf)]
#t2[names(tf)]

