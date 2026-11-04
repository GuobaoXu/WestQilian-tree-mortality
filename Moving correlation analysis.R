
# ==============================================================================
# 检查并加载必要的包
if(!require(treeclim)) install.packages("treeclim")
if(!require(tidyverse)) install.packages("tidyverse")
if(!require(ggplot2)) install.packages("ggplot2")

######Treeclim
library(treeclim)
library(tidyverse)
library(ggplot2)
##Data reading
width<-read.csv("***/sliding/QFDdiff.csv",row.names = 1)## year is rowname
tem<-read.csv("***/sliding/1952-2017temdiff.csv")
pre<-read.csv("***/sliding/1952-2017prediff.csv")
spei<-read.csv("***/sliding/1953-2017speidiffnew.csv")
rci.temresp <- dcc(width,list(tem), var_names =c("tem"), method = "correlation", dynamic = "moving", win_size = 21,win_offset = 1,ci = 0.05, selection=.mean("tem",-9:3)+.mean("tem",4:6)+.mean("tem",7:8))
rci.preresp <- dcc(width,list(pre), var_names =c("pre"), method = "correlation", dynamic = "moving", win_size = 21,win_offset = 1,ci = 0.05, selection=.sum("pre",-9:3)+.sum("pre",4:6)+.sum("pre",7:8))
rci.speiresp  <- dcc(width,list(spei), var_names =c("spei"), method = "correlation", dynamic = "moving", win_size = 21,win_offset = 1,ci = 0.05, selection=.mean("spei",-9:3)+.mean("spei",4:6)+.mean("spei",7:8))
plot(rci.temresp)  
plot(rci.preresp)  
plot(rci.speiresp) 
library(tidyverse)
library(reshape2)

# 定义一个提取函数
extract_dcc_data <- function(dcc_obj, var_label) {
  # 提取系数
  coef_df <- as.data.frame(dcc_obj$coef$coef)
  coef_df$Year <- rownames(coef_df)
  # 提取显著性
  sig_df <- as.data.frame(dcc_obj$coef$significant)
  sig_df$Year <- rownames(sig_df)
  
  # 融合数据
  coef_long <- melt(coef_df, id.vars = "Year", value.name = "Correlation")
  sig_long <- melt(sig_df, id.vars = "Year", value.name = "Significant")
  
  # 合并
  final_df <- merge(coef_long, sig_long, by = c("Year", "variable"))
  final_df$Climate_Var <- var_label
  return(final_df)
}

# 提取并合并
df_tem <- extract_dcc_data(rci.temresp, "Temperature")
df_pre <- extract_dcc_data(rci.preresp, "Precipitation")
df_spei <- extract_dcc_data(rci.speiresp, "SPEI")

all_results <- rbind(df_tem, df_pre, df_spei)

# 保存为一个总表
write.csv(all_results, "***/sliding/QFD-21-diff(newspei).csv", row.names = FALSE)
