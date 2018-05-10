##
## Network
my.data <- read.csv("mito.csv", header=T, stringsAsFactors = F)

my.list <- read.csv("mito.list", header=T, stringsAsFactors=F)

gene <- my.list$gene

pair <- c("Gene", "Conn")

for (i in 1:length(gene)) {
    gene.name <- as.character(gene[i])
    geneA.connection <- length(which(my.data$geneA %in% gene.name))
    geneB.connection <- length(which(my.data$geneB %in% gene.name))
    connectivity <- geneA.connection + geneB.connection
    pair <- rbind(pair,c(gene.name, connectivity))
}

write.table(pair, file="mito.conn.csv",sep=",",row.names=F,col.names=F)
