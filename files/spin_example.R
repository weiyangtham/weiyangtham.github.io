#' ---
#' title: "Example script for using spin in R"
#' author: "WY Tham"
#' date: "Mar 15, 2017"
#' ---

#' The easiest way to understand what's going on here is to first play around with 
#' R Markdown or R Notebooks. `spin` is a way of integrating code and text the same way 
#' R Markdown does, but works better for situations when you have a lot more code than text, 
#' and therefore want to use plain R script i.e. `.R` files rather than `.Rmd` files. 
#' 
#' You may find these links from Dean Attali helpful:
#' [general intro to `sping`](http://deanattali.com/2015/03/24/knitrs-best-hidden-gem-spin/) and
#' [`intro to ezknitr`](http://deanattali.com/blog/ezknitr-package/)
#' 
#' You can compile this script with a number of different ways e.g. using the 
#' "compile notebook" button in RStudio. Personally, I like to use 
#' the `ezspin` command from the `ezknitr` package. This helps to avoid some 
#' working directory pains. When I'm ready to compile the script, I'll run something like 
#' the command below in the console: 
#' 

#+ eval = FALSE
ezknitr::ezspin("scripts/fake_analysis.R", out_dir = "reports")

#' ## Basics
#' - Any line that starts with `#'` is treated as Markdown. 
#' - Any line that starts with `#+` is treated as a code chunk. Code chunks are how code
#' and text are integrated in R Markdown. You can specify options like `echo = FALSE` as you
#' would in an R Markdown code chunk.
#' 
#' 
#' ## Example "analysis"
#' A quick example to show how the code and text integrate. The `gapminder` data is
#'  available as a package so you should be able to reproduce this file by just hitting 
#'  "compile notebook" in RStudio. 

#+ warning = FALSE, message = FALSE
library(tidyverse)
library(gapminder)

gapminder

ggplot(filter(gapminder, country == "Afghanistan"), aes(year, lifeExp)) + 
  geom_line() + 
  labs(title = "Life Expectancy in Afghanistan increasing since 1950", 
       subtitle = "Slows down around 1990s")


