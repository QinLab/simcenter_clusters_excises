ms02_singlerun_v2 = function( inpairs,  ncycles=750, indebug=0 ) {
  if (ncycles >= 1 ) {
    if(indebug>0) {
      print(paste('ncycles=', ncycles))
    }
    longids = c(as.character(inpairs[,1]), as.character(inpairs[,2]) )
    longids = sample(longids)
    len = length(inpairs[,1])
    newpairs2 = data.frame( cbind( longids[1:len], longids[(len+1): (2*len)]) )
    newpairs2 = t(apply(newpairs2, 1, sort))
    newpairs2 = data.frame(newpairs2)
    names(newpairs2) = c('id1', 'id2')
    newpairs2$id1 = as.character( newpairs2$id1)
    newpairs2$id2 = as.character( newpairs2$id2)
   
    newpairs2$tag =  paste(newpairs2[,1], newpairs2[,2], sep="_")
    counts = table( newpairs2$tag )
    newpairs2$tag_counts = counts[newpairs2$tag]
   
    newpairs2$selfpairs = ifelse( newpairs2$id1 == newpairs2$id2, 1, 0 )
   
    redo.tb = newpairs2[ newpairs2$selfpairs==1 | newpairs2$tag_counts>1, ]
    rest.tb = newpairs2[ newpairs2$selfpairs==0 & newpairs2$tag_counts==1, ]
    if(indebug>0) {
      print(paste("===redopairs===="),NULL);      print(redo.tb);
      #print(paste("===restpairs===="),NULL);      print(rest.tb);
      print(paste("================="),NULL)
    }
    if( length(redo.tb[,1])>=1 ) {
      if ( ncycles == 0) {
        #return (c(NA,NA, NA) );
        print(paste("ncycles reached zero, ncycles"),ncycles)
        print(paste("Abort!"),NULL)
        stop;
      } else {
        ncycles = ncycles - 1
        splitPos = round( length(redo.tb[,1]) * sqrt(ncycles) ) + 5
        splitPos = min( splitPos, (length(rest.tb[,1])-1 ) )
        selectedpairs = rbind(redo.tb,  rest.tb[1: splitPos, ] )   #20140408, potential bug. always take initial section
        unchangedpairs = rest.tb[ (splitPos + 1): length(rest.tb[,1]), ] #20140408, potential bug.
        return( rbind(unchangedpairs, ms02_singlerun_v2(selectedpairs, ncycles)))  #2014 Feb 12
      }
    } else { 
      return (newpairs2 )
    }
  } else {
    return( c(NA,NA,NA ))
  }
}#end of ms02 v2
