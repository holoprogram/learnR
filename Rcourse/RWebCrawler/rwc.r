# web crawler
library(rvest)
library(tidyverse)

suffix <- str_c("?start=", seq(25,225, by = 25))
urls <- str_c("https://movie.douban.com/top250", c("", suffix))

read_url <- function(url){
        Sys.sleep(sample(5, 1))
        read_html(url)
}

htmls <- map(urls, read_url)

# 读取电影网页信息

get_html <- function(html){
        # 电影名字
        name <-  html_nodes(html, 'div.hd a') %>% html_text2()
        
        # 大杂烩
        xp <-  str_c("//*[@id='content']/div/div[1]/ol/li[",c(1:25),
                     "]/div/div[2]/div[2]/p[1]/text()[1]") # 导演演员位置
        director <- vector(length = 25)
        star <- vector(length = 25)
        
        xp2 <- str_c("//*[@id='content']/div/div[1]/ol/li[",c(1:25),
                     "]/div/div[2]/div[2]/p[1]/text()[2]") # 相关地址
        time <- vector(length = 25)
        region <- vector(length = 25)
        type <- vector(length = 25)
        
        
        for (i in 1:25) {
                # 导演 主演
                director[i] <-  html_nodes(html, xpath = xp[i]) %>% 
                        html_text2() %>% str_extract("(?<=导演: ).*(?= 主)")
                star[i] <- html_nodes(html, xpath = xp[i]) %>% 
                        html_text2() %>% str_extract("(?<= 主演:).*")
                
                # 时间 地区 类型
                
                time[i] <- html_nodes(html, xpath = xp2[i]) %>% 
                        html_text2() %>% str_extract("[0-9]+")
                region[i] <- html_nodes(html, xpath = xp2[i]) %>% 
                        html_text2() %>% str_extract("(?<=/).*(?=/)")
                type[i] <-  html_nodes(html, xpath = xp2[i]) %>% 
                        html_text2() %>% str_extract("[^/]+$")
        }
        
        
        
        # 评分
        score <-  html_nodes(html, 'span.rating_num') %>% 
                html_text2()%>% parse_number()
        
        # 评价人数，xpath加模糊匹配，已验证匹配准确
        comments <-  html_nodes(html, xpath = "//div/div[2]/div[2]/div/span[4]") %>% 
                html_text2() %>% parse_number()
        # 简评
        quote <-  html_nodes(html, 'div.info') %>% 
                html_text2() %>% 
                stringi::stri_remove_empty()%>%
                str_extract("(?<=评价\\n\\n).*")
        
        tibble(
                "名称" = name,
                "导演" = director,
                "主演" = star,
                "时间" = time,
                "地区" = region,
                "类型" = type,
                "评分" = score,
                "评分人数" = comments,
                "简评" = quote
        )
        
}

# 大功告成
movies_douban <- map_dfr(htmls, get_html)


# 导出

## 导出乱码
write_csv(movies_douban, file = "豆瓣电影TOP250.csv")
## 成功!
openxlsx::write.xlsx(movies_douban, "豆瓣电影TOP250.xlsx")
## 成功
write_excel_csv(movies_douban, file = "豆瓣电影TOP250.csv")


