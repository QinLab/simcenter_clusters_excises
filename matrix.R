# All genes are classified in N (= 10 here) categories based on quantiles of the connectivity values
quant.data <- read.csv("/home/hguo/GitHub/simcenter_clusters_excises/mito.conn.csv", header = TRUE)
quant <- quantile(quant.data$Conn, probs = seq(0, 1, by=0.1))

mydata <- read.csv("mito.by.conn.csv", header = TRUE)
connA <- mydata$connA
connB <- mydata$connB

# First making a 10*10 matrix with zero elements
A <- matrix(0, nrow=10, ncol=10)
B <- matrix(0, nrow=10, ncol=10)

# for each gene pair the elemments A_mn will be changed depending on the RLS values of the two genes;
# symmetricity has been considered from the original matrix; i.e., both gene pairs (i,j) and (j,i) are
# included in the csv file

for (i in 1:length(connA)){
    if (connA[i] > quant[10]) {
        m = 10
    }   else {
        if (connA[i] > quant[9]) {
            m = 9
        }   else {
            if (connA[i] > quant[8]) {
                m = 8
            }   else {
                if (connA[i] > quant[7]) {
                    m = 7
                }   else {
                    if (connA[i] > quant[6]) {
                        m = 6
                    }   else {
                        if (connA[i] > quant[5]) {
                            m = 5
                        }   else {
                            if (connA[i] > quant[4]) {
                                m = 4
                            }   else {
                                if (connA[i] > quant[3]) {
                                    m = 3
                                }   else {
                                    if (connA[i] > quant[2]) {
                                        m = 2
                                    } else {
                                        m = 1
                                    }
    }}}}}}}}

    if (connB[i] > quant[10]) {
        n = 10
    }   else {
        if (connB[i] > quant[9]) {
            n = 9
        }   else {
            if (connB[i] > quant[8]) {
                n = 8
            }   else {
                if (connB[i] > quant[7]) {
                    n = 7
                }   else {
                    if (connB[i] > quant[6]) {
                        n = 6
                    }   else {
                        if (connB[i] > quant[5]) {
                            n = 5
                        }   else {
                            if (connB[i] > quant[4]) {
                                n = 4
                            }   else {
                                if (connB[i] > quant[3]) {
                                    n = 3
                                }   else {
                                    if (connB[i] > quant[2]) {
                                        n = 2
                                    } else {
                                        n = 1
                                    }
    }}}}}}}}

    A[m,n] <- A[m,n] + 1
    A[n,m] <- A[n,m] + 1
}

## Considering the symmetricity of the matrix A, if an interaction is counted in A[m,n], 
## this script will also add the interaction in A[n,m].
## However, for A[m,m], i.e., the diagonal elements of the matrix, it was double counted,
## and therefore need be corrected to matrix B.

for (m in 1:10) {
    for (n in 1:10){
        if (m == n) {
           B[m,n] = A[m,n]/2
        }  else {
           B[m,n] = A[m,n]
        }
    }
}


write.table(B, file="mito.matrix.csv",sep=",",row.names=F,col.names=F)
