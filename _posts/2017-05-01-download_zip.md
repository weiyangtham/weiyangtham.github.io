---
title: "Downloading zip files in R"
author: "Tham, Wei Yang"
date: "2017-05-01"
output: html_document
tags:
  - r 
---



In theory this should be a straightforward task with the `download.file` function, but as I recently found, it's a little trickier than that (but really not that much trickier).[^1] The main things you have to do are 

[^1]: I relied on this [Stack Overflow post](http://stackoverflow.com/questions/3053833/using-r-to-download-zipped-data-file-extract-and-import-data) to figure this out, and it has a few variants on the solution that I'm using here. 

1. Specify `mode = "wb"` in `download.file`
2. Use `unz` to unzip

Example code below. I used a real url in the example that downloads data on NIH grants from [this page](https://exporter.nih.gov/ExPORTER_Catalog.aspx). 


{% highlight r %}
# download zipped folder
download.file(url = "https://exporter.nih.gov/CSVs/final/RePORTER_PRJ_C_FY2013.zip", 
              destfile = "destination/folder/RePORTER_PRJ_C_FY2013.zip", 
              mode = "wb")

# extract file from zipped folder
x = readr::read_csv(unz(description = "/destination/folder/RePORTER_PRJ_C_FY2013.zip", 
                        filename = "RePORTER_PRJ_C_FY2013.csv"))
{% endhighlight %}

This is what you should get at the end:


{% highlight text %}
## # A tibble: 100 × 45
##    APPLICATION_ID ACTIVITY ADMINISTERING_IC APPLICATION_TYPE ARRA_FUNDED
##             <int>    <chr>            <chr>            <int>       <chr>
## 1         8504974      R01               CA                5           N
## 2         8710587      P30               CA                3           N
## 3         8578352      R01               CA                2           N
## 4         8519269      U51               IP                5           N
## 5         8476221      T34               GM                5           N
## 6         8514650      R01               GM                5           N
## 7         8415817      R01               NS                5           N
## 8         8519478      R01               GM                5           N
## 9         8516121      R01               NS                5           N
## 10        8633290      R43               DK                1           N
## # ... with 90 more rows, and 40 more variables: AWARD_NOTICE_DATE <chr>,
## #   BUDGET_START <chr>, BUDGET_END <chr>, CFDA_CODE <int>,
## #   CORE_PROJECT_NUM <chr>, ED_INST_TYPE <chr>, FOA_NUMBER <chr>,
## #   FULL_PROJECT_NUM <chr>, FUNDING_ICs <chr>, FUNDING_MECHANISM <chr>,
## #   FY <int>, IC_NAME <chr>, NIH_SPENDING_CATS <chr>, ORG_CITY <chr>,
## #   ORG_COUNTRY <chr>, ORG_DEPT <chr>, ORG_DISTRICT <int>, ORG_DUNS <int>,
## #   ORG_FIPS <chr>, ORG_NAME <chr>, ORG_STATE <chr>, ORG_ZIPCODE <chr>,
## #   PHR <chr>, PI_IDS <chr>, PI_NAMEs <chr>, PROGRAM_OFFICER_NAME <chr>,
## #   PROJECT_START <chr>, PROJECT_END <chr>, PROJECT_TERMS <chr>,
## #   PROJECT_TITLE <chr>, SERIAL_NUMBER <int>, STUDY_SECTION <chr>,
## #   STUDY_SECTION_NAME <chr>, SUBPROJECT_ID <int>, SUFFIX <chr>,
## #   SUPPORT_YEAR <int>, DIRECT_COST_AMT <int>, INDIRECT_COST_AMT <int>,
## #   TOTAL_COST <int>, TOTAL_COST_SUB_PROJECT <int>
{% endhighlight %}


