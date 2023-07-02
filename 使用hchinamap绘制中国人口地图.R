#安装包
install.packages("hchinamap")
install.packages("readxl")
install.packages("dplyr")

#导入地图chinadf
dir <- tempdir()
download.file('https://czxb.github.io/br/chinadf.rda', 
              file.path(dir, 'chinadf.rda'))
load(file.path(dir, 'chinadf.rda'), verbose = TRUE)

#筛选省区
library(dplyr)
china <- chinadf %>% 
  dplyr::filter(region == "China")

library(hchinamap)
hchinamap(name = china$name, 
          value = china$value,
          width = "100%", 
          height = "400px",
          title = "Map of China", 
          region = "China")

#导入省区人口, population.xls必须放在当前工作路径下；否则需要在read_excel("population.xls”)的双引号中写明文件路径
library(readxl)
population <- read_excel("population.xls")

#合并china和population
data <- merge(china, population, by = "name")

#查看颜色16进制代码：https://htmlcolorcodes.com

hchinamap(name = data$name, 
          value = data$population,
          itermName = "常住人口",
          width = "100%", 
          height = "400px",
          title = "2022中国各省常住人口(万人)",
          minColor = "#EBF4FB",
          maxColor = "#057ED6",
          region = "China",
          legendLayout = "vertical",
          legendAlign = "left",
          legendVerticalAlign = "top")