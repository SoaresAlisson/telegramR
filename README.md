TelegramR - vignette
================

<!-- README.md is generated from README.Rmd. Please edit that file -->

# telegramR

<!-- badges: start -->

<figure>
<img
src="https://img.shields.io/badge/r-%23276DC3.svg?style=for-the-badge&amp;logo=r&amp;logoColor=white"
alt="R package" />
<figcaption aria-hidden="true">R package</figcaption>
</figure>

<!-- badges: end -->
<!-- You'll still need to render `README.Rmd` regularly, to keep `README.md` up-to-date. `devtools::build_readme()` is handy for this. -->
<!-- In that case, don't forget to commit and push the resulting figure files, so they display on GitHub and CRAN. -->

The telegramR package deals with exported chats from [Telegram
messenger](https://www.telegram.org/). Telegram desktop allows the user
to export the data of chats and channels, but how to extract ant treat
those data remains a question. This package allows the transformation of
HTML from exported chats/channels in tibble/dataframe, as well as have
some functions to a brief summary about the exported chats.

## Installation: Option 1 with devtools package

To install this package using devtools

``` r
# installing devtools
install.packages("devtools")
# installing telegramR
devtools::install_github("SoaresAlisson/telegramR")
```

## Installation: Option 2 with remotes package

``` r
# if remote package is installed, load it; If not, install
if (!require('remotes')) install.packages('remotes')
remotes::install_github('SoaresAlisson/telegramR')
```

## Installation: Option 3 download the files and build it locally

You go to Github, click on green bottom `<> code`, than in
`Download Zip`, unzip it, open the .Rproj in Rstudio. Once the project
is loaded, you can build the package: option1) press ctrl+shift+b, or 2)
go to Build/Install Package

## Running the package

Once installed, to load the package:

``` r
library(telegramR)
```

To transform one .HTML file into tibble/dataframe, use the function
`html2df("html_file")`

``` r
html2df("~/Downloads/Telegram Desktop/ChatExport_2023-12-16 (1)/messages.html")
#> # A tibble: 999 × 6
#>    Chat_Name   msg_Id date_time           user_name   text     Audio_Video_image
#>    <chr>       <chr>  <dttm>              <chr>       <chr>    <chr>            
#>  1 Hacker News 69     2017-01-05 04:36:10 Hacker News 'Legiti… <NA>             
#>  2 Hacker News 70     2017-01-05 04:41:16 <NA>        Bitcoin… <NA>             
#>  3 Hacker News 71     2017-01-05 06:00:15 Hacker News Snapcha… <NA>             
#>  4 Hacker News 72     2017-01-05 06:15:47 Hacker News Rumors … <NA>             
#>  5 Hacker News 73     2017-01-05 13:41:36 Hacker News Mozilla… <NA>             
#>  6 Hacker News 74     2017-01-05 13:41:37 <NA>        Nvidia … <NA>             
#>  7 Hacker News 75     2017-01-05 13:41:37 <NA>        Easy 65… <NA>             
#>  8 Hacker News 76     2017-01-05 13:41:38 <NA>        Taichi … <NA>             
#>  9 Hacker News 77     2017-01-05 13:41:38 <NA>        .NET Co… <NA>             
#> 10 Hacker News 78     2017-01-05 13:41:42 <NA>        How to … <NA>             
#> # ℹ 989 more rows
```

To get all messages from HTML in a folder and transform all in one
single tibble:

``` r
dir2df("~/Downloads/Telegram Desktop/ChatExport_2023-12-16 (1)/")
#> # A tibble: 170,156 × 6
#>    Chat_Name   msg_Id date_time           user_name   text     Audio_Video_image
#>    <chr>       <chr>  <dttm>              <chr>       <chr>    <chr>            
#>  1 Hacker News 69     2017-01-05 04:36:10 Hacker News 'Legiti… <NA>             
#>  2 Hacker News 70     2017-01-05 04:41:16 <NA>        Bitcoin… <NA>             
#>  3 Hacker News 71     2017-01-05 06:00:15 Hacker News Snapcha… <NA>             
#>  4 Hacker News 72     2017-01-05 06:15:47 Hacker News Rumors … <NA>             
#>  5 Hacker News 73     2017-01-05 13:41:36 Hacker News Mozilla… <NA>             
#>  6 Hacker News 74     2017-01-05 13:41:37 <NA>        Nvidia … <NA>             
#>  7 Hacker News 75     2017-01-05 13:41:37 <NA>        Easy 65… <NA>             
#>  8 Hacker News 76     2017-01-05 13:41:38 <NA>        Taichi … <NA>             
#>  9 Hacker News 77     2017-01-05 13:41:38 <NA>        .NET Co… <NA>             
#> 10 Hacker News 78     2017-01-05 13:41:42 <NA>        How to … <NA>             
#> # ℹ 170,146 more rows
```

The function has the parameter `recursive = TRUE` as default, so it is
possible to recursively find HTML files in folders inside another
folders. If you don’t want it, use the parameter `recursive = FALSE`

``` r
dir2df("~/Downloads/Telegram Desktop/")
#> # A tibble: 207,592 × 6
#>    Chat_Name   msg_Id date_time           user_name   text     Audio_Video_image
#>    <chr>       <chr>  <dttm>              <chr>       <chr>    <chr>            
#>  1 Hacker News 69     2017-01-05 04:36:10 Hacker News 'Legiti… <NA>             
#>  2 Hacker News 70     2017-01-05 04:41:16 <NA>        Bitcoin… <NA>             
#>  3 Hacker News 71     2017-01-05 06:00:15 Hacker News Snapcha… <NA>             
#>  4 Hacker News 72     2017-01-05 06:15:47 Hacker News Rumors … <NA>             
#>  5 Hacker News 73     2017-01-05 13:41:36 Hacker News Mozilla… <NA>             
#>  6 Hacker News 74     2017-01-05 13:41:37 <NA>        Nvidia … <NA>             
#>  7 Hacker News 75     2017-01-05 13:41:37 <NA>        Easy 65… <NA>             
#>  8 Hacker News 76     2017-01-05 13:41:38 <NA>        Taichi … <NA>             
#>  9 Hacker News 77     2017-01-05 13:41:38 <NA>        .NET Co… <NA>             
#> 10 Hacker News 78     2017-01-05 13:41:42 <NA>        How to … <NA>             
#> # ℹ 207,582 more rows
```

## Organizing the exported chats/ channels.

Telegram Desktop allows the user to export channel/chats with specific
date ranges. If you exports a lot of telegram channels/chats, the
probability to become lost are high. This confusion may happens because
there is a lot of groups/channels, or because the same channel was
exported several times with different date ranges. To organize it, the
function `tm_info()` (telegram information) returns the name of
channel/chat, the first and the last dates in each HTML file

``` r
info_all_tm_chats <- tm_info("~/Downloads/Telegram Desktop/")
info_all_tm_chats
#> # A tibble: 209 × 5
#>    HTMLName                                 name  UserPics FirstDate  LastDate  
#>    <chr>                                    <chr> <chr>    <date>     <date>    
#>  1 ~/Downloads/Telegram Desktop/ChatExport… Hack… ""       2017-01-04 2017-01-23
#>  2 ~/Downloads/Telegram Desktop/ChatExport… Hack… ""       2017-01-23 2017-02-09
#>  3 ~/Downloads/Telegram Desktop/ChatExport… Hack… ""       2017-02-09 2017-02-26
#>  4 ~/Downloads/Telegram Desktop/ChatExport… Hack… ""       2017-02-26 2017-03-15
#>  5 ~/Downloads/Telegram Desktop/ChatExport… Hack… ""       2017-03-15 2017-04-01
#>  6 ~/Downloads/Telegram Desktop/ChatExport… Hack… ""       2017-04-01 2017-04-18
#>  7 ~/Downloads/Telegram Desktop/ChatExport… Hack… ""       2017-04-18 2017-05-05
#>  8 ~/Downloads/Telegram Desktop/ChatExport… Hack… ""       2017-05-05 2017-05-23
#>  9 ~/Downloads/Telegram Desktop/ChatExport… Hack… ""       2017-05-23 2017-06-10
#> 10 ~/Downloads/Telegram Desktop/ChatExport… Hack… ""       2017-06-10 2017-06-27
#> # ℹ 199 more rows
```

In this way, if you want to export again the same chat, it is easy to
know the last date of the last export. To make it even easier:

``` r
filter_last_export(info_all_tm_chats)
#> # A tibble: 2 × 2
#>   name                             LastDate  
#>   <chr>                            <date>    
#> 1 Hacker News                      2023-12-16
#> 2 Science News Facts Updates Daily 2023-12-19
```
