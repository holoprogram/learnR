# 动态爬虫
library(httr)
library(tidyverse)

## 构造请求表头
myCookie <- '_ntes_nuid=ff927622b8ef5af9a3dcf1a56c3f2dd6; nts_mail_user=zzulimcm@163.com:-1:1; __oc_uuid=b7316c10-59a8-11ec-8f92-91779fb6bad5; unisdk_udid=2c8cb199a6e2d4abc66a31f77660d7bf; _ga=GA1.1.245769410.1643340224; _ntes_nnid=ff927622b8ef5af9a3dcf1a56c3f2dd6,1654051447449; Qs_lvt_382223=1643340223%2C1643340340%2C1654865293; Qs_pv_382223=1337617523052357600%2C912257755542062300%2C3310221185003779600; _clck=rc0yen|1|f27|0; _ga_C6TGHFPQ1H=GS1.1.1654868294.4.0.1654868294.0; vinfo_n_f_l_n3=ddee58e472084f41.1.0.1657331772818.0.1657331800839; __bid_n=18392b67cb7b33bd474207; NTESSTUDYSI=1eddfaa874424229a1158c3f8c3a5d0a; EDUWEBDEVICE=1213f67bc01c46b38feec94e3d2d33e2; EDU-YKT-MODULE_GLOBAL_PRIVACY_DIALOG=true; utm=eyJjIjoiIiwiY3QiOiIiLCJpIjoiIiwibSI6IiIsInMiOiIiLCJ0IjoiIn0=|aHR0cHM6Ly9zdHVkeS4xNjMuY29tLw==; STUDY_UUID=3f290410-1e90-4b5e-9e58-f72f39fa9a7d'
myUserAgent <- 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/106.0.0.0 Safari/537.36'
headers <- c('accept' = 'application/json',
            'edu-script-token' = '1eddfaa874424229a1158c3f8c3a5d0a',
            'User-Agent' = myUserAgent,
            'cookie' = myCookie)
# 二次实际请求到的 url
url <- 'https://study.163.com/p/search/studycourse.json'

# 构造请求payload
payload <- list(
        "activityId"= 0,
        "frontCategoryId"="480000003123036",
        "keyword"= "",
        "orderType"= 90,
        "pageIndex"=1,
        "pageSize"=50,
        "priceType"= -1,
        "relativeOffset"=0,
        "searchTimeType"= -1,
        "searchType"= 20
        
)

## POST 方法执行单次请求
result <- POST(url, add_headers(.headers = headers),
              body = payload, encode = "json")



# 50 个课程信息列表的列表
lensons <- content(result)$result$list
df <- tibble(ID = map_chr(lensons, "courseId"),
            title = map_chr(lensons, "productName"),
            provider = map_chr(lensons, "provider"),
            score = map_dbl(lensons, "score"),
            learnerCount = map_dbl(lensons, "learnerCount"),
            lessonCount = map_dbl(lensons, "lessonCount"),
            lector = map_chr(lensons, "lectorName",
                             .null = NA))


get_html <- function(p) {
        Sys.sleep(sample(5, 1))
        
        payload <- list('pageIndex' = p, 'pageSize' = 50,
                       'relativeOffset' = 50*(p-1),
                       'frontCategoryId' = "480000003123036")
        # POST 方法执行单次请求
        result <- POST(url, add_headers(.headers = headers),
                      body = payload, encode = "json")
        lenssons <- content(result)$result$list
        
        rlt <- tibble(
                ID = map_chr(lenssons, "courseId"),
                title = map_chr(lenssons, "productName"),
                provider = map_chr(lenssons, "provider"),
                score = map_dbl(lenssons, "score"),
                learnerCount = map_dbl(lenssons, "learnerCount"),
                lessonCount = map_dbl(lenssons, "lessonCount"),
                lecturer = map_chr(lenssons, "lectorName", .null = NA))
        return(rlt)
}



# 职场效率
zc_lessons <- map_dfr(1:7, get_html)
# 导出

write_excel_csv(zc_lessons, file = "网易云课堂职场效率课程.csv")
