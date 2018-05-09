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
    names(newpairs) = c('id1', 'id2')
    newpairs$id1 = as.character( newpairs$id1)
    newpairs$id2 = as.character( newpairs$id2)    
    newpairs$selfpairs = ifelse( newpairs$id1 == newpairs$id2, 1, 0 )
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

#net = read.table("repeat.tab")
#write.table(pairs, "merged_PPIGIN_2014Jan20.tab", quote=F, row.names=F, col.names=F, sep='\t')
net = read.table( "mito.tab", header=F, sep="\t", colClass = c("character", "character") )
head(net)
if(debug==9) { 
  #net = read.table('pair.tab',header=F) 
 net = net[1:90000,]
}


#net.ms02 = permute.pairs.wo.selfpairs( net  )
#write.csv(net.ms02, "ms02/net2.csv")

#do they have the same degree?
#t1 = table(c(net[,1],net[,2]))
#t2 = table(c(net.ms02[,1],net.ms02[,2]))
#comp <- t1 == t2
#table(comp)
#tf = comp[comp==F]; tf
#t1[names(tf)[1]]
#t1[names(tf)]
#t2[names(tf)]

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

net = read.table( "mito.tab", header=F, sep="\t", colClasses = c("character", "character") )
head(net)

for( i in start:end) {
 net.ms02 = permute.pairs.wo.selfpairs( net )
 cmnd = paste( "mkdir ms02/", i, sep="")
 system( cmnd )
 outputname = paste( 'ms02/', i, '/', "ms02_",i,".tab", sep="")
 write.table(net.ms02, outputname, quote=F, row.names=F, sep="\t")
}
