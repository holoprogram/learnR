# ershoufang
library(rvest)
library(tidyverse)


urls <- str_c("https://zz.lianjia.com/ershoufang/pg", 1:10) # 有一百页

read_url <- function(url){
        Sys.sleep(sample(5, 1))
        read_html(url)
}
htmls <- map(urls, read_url)


get_html <- function(html){
        # 标题 
        title <- html%>% html_nodes("div.title a") %>% html_text2()
        title <- title[1:30] # 扔掉最后一个
        # 地区
        region <- html%>% html_nodes("div.flood") %>% html_text2()
        
        ## 结构
        #strhouse <- html%>% html_nodes("div.houseInfo") %>% 
        #        html_text2() %>% str_extract("^[^|]+")
        
        ## 面积
        #area <- html%>% html_nodes("div.houseInfo") %>% 
        #        html_text2() %>% str_extract("[^|]+(?=平米)") %>% str_c("平米")
        ## 更多信息
        info <- html%>% html_nodes("div.houseInfo") %>% 
                html_text2()# %>% str_extract("(?<=平米).*[^|]+")

        ## 关注数
        follows <- html%>% html_nodes("div.followInfo") %>% 
                html_text2() %>% str_extract("^[^/]+")
        ## 发布日期
        date <- html%>% html_nodes("div.followInfo") %>% 
                html_text2() %>%str_extract("[^/]+$")
        
        
        # 价格 单位 元/平方米
        unitprice <- html%>% html_nodes("div.unitPrice") %>% 
                html_text2() %>% parse_number()
        # 总价 单位 万
        totalprice <- html%>% html_nodes("div.totalPrice.totalPrice2") %>% 
                html_text2() %>% parse_number()
        
        # 结果
        tibble(
                "标题" = title,
                "地点" = region,
                #"户型格局" = strhouse,
                #"面积" = area,
                "更多信息" = info,
                "关注人数" = follows,
                "发布日期" = date,
                "价格(元每平方米)" = unitprice,
                "总价(万元)" = totalprice
        )
        
}

# 特定清理
tidy_data <- function(data){
        tidydata <- data %>% separate("更多信息", into = c("户型格局",
                                           "面积",
                                           "朝向",
                                           "装修情况",
                                           "楼层",
                                           "楼型结构"), sep = "[|]")
        tidydata
}
# 大功告成
zzershoufang <- map_dfr(htmls, get_html)
final_result <- tidy_data(zzershoufang)
# 导出
write_excel_csv(final_result, file = "链家网郑州二手房部分.csv")





