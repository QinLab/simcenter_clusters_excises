mito <- read.table("mito.matrix.csv", header = F, sep = ",")


for (m in 1:10) {
    for (n in 1:10) {
        e <- c()
        for (i in 1:100) { 
            name <- paste("ms02_", i, ".matrix.csv", sep = "")
            mat <- read.table(name, header = F, sep = ",")
            e <- rbind(e,mat[m,n])
        }
        mito[m,n] <- round((mito[m,n] - mean(e))/sd(e),3)
    }
}

write.table(mito, file="mito.matrix.zscore.csv", sep = ",", row.names=F, col.names=F)
