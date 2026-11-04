# 如果尚未安装，请取消注释以下两行
install.packages("dplR")
install.packages("pointRes")

library(dplR)
library(ggplot2)
library(pointRes)

# 设置工作目录到你的数据文件夹
setwd("***/pointer year/")
# 1. 读取原始数据
raw_living <- read.csv("D:/AAAdesk/JQdata/QF1-6New/original data/AQFL.csv")
raw_dying <- read.csv("D:/AAAdesk/JQdata/QF1-6New/original data/AQFD.csv")
detr_living <- read.csv("D:/AAAdesk/JQdata/QF1-6New/original data/QFL.csv")
detr_dying <- read.csv("D:/AAAdesk/JQdata/QF1-6New/original data/QFD.csv")

# ------------------------------------------------------------------
# 1. Interval Trend (IT) 
# ------------------------------------------------------------------

it_living <- interval.trend(data = raw_living, 
                              trend.thresh = 0, 
                              IT.thresh = 85,  
                              make.plot = FALSE)

# ------------------------------------------------------------------
# 2. Relative Growth Change (RGC)  
# ------------------------------------------------------------------

rgc_living <- pointer.rgc(data = raw_living, 
                            nb.yrs = 4, 
                            rgc.thresh.neg = 25, 
                            rgc.thresh.pos = 50, 
                            series.thresh = 50,  
                            make.plot = FALSE)

# ------------------------------------------------------------------
# 3. Normalization in Moving Window (NW) 
# ------------------------------------------------------------------

nw_living<- pointer.norm(data = detr_living, 
                            window = 13, 
                            method.thresh = "Cropper", 
                            C.thresh = 1.0,      
                            series.thresh = 40,  
                            make.plot = FALSE)

# ------------------------------------------------------------------
# 4. zChron (年表法)
# ------------------------------------------------------------------
zchron_living <- pointer.zchron(data = detr_living, 
                                  z.thresh = 1.28, 
                                  make.plot = FALSE)

# ------------------------------------------------------------------
# 绘图检查
# ------------------------------------------------------------------
pointer.plot(list(it_living, rgc_living, nw_living, zchron_living), 
             sign = "neg", 
             period = c(1950, 2017), 
             labels = c("IT", "RGC", "NW", "zChron"))
# 1. Interval Trend (IT) 
# ------------------------------------------------------------------
it_dying <- interval.trend(data = raw_dying, 
                          trend.thresh = 0, 
                          IT.thresh = 80, 
                          make.plot = FALSE)

# 2. Relative Growth Change (RGC) 
# ------------------------------------------------------------------

rgc_dying <- pointer.rgc(data = raw_dying, 
                        nb.yrs = 4, 
                        rgc.thresh.neg = 40, 
                        rgc.thresh.pos = 50, 
                        series.thresh = 40,  
                        make.plot = FALSE)
# ------------------------------------------------------------------
# 3. Normalization in Moving Window (NW) 
# ------------------------------------------------------------------
nw_dying<- pointer.norm(data = detr_dying, 
                        window = 13, 
                        method.thresh = "Cropper", 
                        C.thresh = 1.0,      
                        series.thresh = 35,  
                        make.plot = FALSE)

# ------------------------------------------------------------------
# 4. zChron (年表法) 
# ------------------------------------------------------------------

zchron_dying <- pointer.zchron(data = detr_dying, 
                              z.thresh = 1,
                              make.plot = FALSE)

# ------------------------------------------------------------------
# 绘图检查
# ------------------------------------------------------------------
pointer.plot(list(it_dying, rgc_dying, nw_dying, zchron_dying), 
             sign = "neg", 
             period = c(1950, 2017), 
             labels = c("IT", "RGC", "NW", "zChron"))

print(nw_live$out[nw_live$out$nature == -1, ])






