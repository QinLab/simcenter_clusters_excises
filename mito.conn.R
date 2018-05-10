# Read the connectivity of all genes
conn.info <- read.csv("mito.conn.csv",header=TRUE, stringsAsFactors=F)

# read the network
mito <- read.csv("mito.csv",header=TRUE, stringsAsFactors=F)
geneA <- mito$geneA
geneB <- mito$geneB

orf <- conn.info$Gene
conn <- conn.info$Conn

# the "which" funciton was utilized to distribute the info to the network
matcha <- which(geneA %in% orf)
matchb <- which(geneB %in% orf)
# the overlaps between {Ai} and {Bi} will gives the locations of the pairs, in which both ORFs are included,
# i.e., matcha[match2] will give the locations of ORFs in geneA that has been included in the set
match2 <- which (matcha %in% matchb)

pair <- c("geneA","geneB","connA","connB")

for (i in 1:length(match2)) {
    a0 <- as.numeric(match2[i])
    a1 <- as.numeric(matcha[a0])
    linkA <- as.character(geneA[a1])
    linkB <- as.character(geneB[a1])
    t <- which(orf %in% geneA[a1])
    connA <- conn[t]
    s <- which(orf %in% geneB[a1])
    connB <- conn[s]
    pair = rbind(pair,c(linkA,linkB,connA,connB))
}

write.table(pair,file="mito.by.conn.csv",sep=",",row.names=F,col.names=F)
