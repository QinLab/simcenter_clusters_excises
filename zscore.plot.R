##
library(plotly)
library(webshot)

z <- read.csv2("mito.matrix.zscore.csv", header = FALSE, sep = ",", stringsAsFactors = F)

conn_A <- c(0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0)
conn_B <- c(0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0)

freq <- c(z$V1,z$V2,z$V3,z$V4,z$V5,z$V6,z$V7,z$V8,z$V9,z$V10)

p <- plot_ly(type = 'contour',
     z = matrix(freq, nrow=10, ncol=10), color=~z,
     x=~conn_A, y=~conn_B, width=500, height=400,
     contours=list(start=-3,end=3,size=0.5), colorbar=list(title="Z-score"))
a <- list(title="Quantiles of Connectivity")
b <- list(title="Quantiles of Connectivity")

layout(p, xaxis=a, yaxis=b, title="Mitochondrial Set in Connectivity")
## the webshot package will be needed to export the plotly figure
export(layout(p,title="Mitochondrial Set in Connectivity", xaxis=a,yaxis=b),file="Mito.z.conn.png")
