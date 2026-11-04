## 1 library install and loading--------
## if you have installed these packages, start from loading
install.library("ggplot2")
install.library("treeclim")
install.library("tidyverse")

## loading the packages
library("ggplot2")
library("treeclim")
library("Rcpp")
library("tidyverse")
## 2. load the chronology and climate data------
#width is the chronology
#tem is temperature
#pre is the precipitation

### 3. climate response based on dcc function--------
width<-read.csv("***/Correlation/QFBL2.csv",row.names = 1)## year is rowname
tem<-read.csv("***/Correlation/jqtem2.csv")
pre<-read.csv("***/Correlation/jqpre2.csv")
spei<-read.csv("***/Correlation/jqspei032.csv")
rci.temresp <- dcc(width,list(tem), var_names =c("tem"), method = "correlation",selection=.range("tem",-9:8)+.mean("tem",-9:3)+.mean("tem",4:6)+.mean("tem",7:8))
rci.preresp <- dcc(width,list(pre), var_names =c("pre"), method = "correlation",selection=.range("pre",-9:8)+.sum("pre",-9:3)+.sum("pre",4:6)+.sum("pre",7:8))
rci.speiresp  <- dcc(width,list(spei), var_names =c("spei"), method = "correlation",selection=.range("spei",-9:8)+.mean("spei",-9:3)+.mean("spei",4:6)+.mean("spei",7:8))
plot(rci.temresp)  
plot(rci.preresp)  
plot(rci.speiresp) 


