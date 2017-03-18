---
title: "felm and broom::augment"
author: "Tham, Wei Yang"
date: "2017-03-18"
tags:
  - r
output: html_document
---



This is a really quick post. I just wanted to share a problem (and solution) I had recently. 

The issue was getting the regression output from the `felm` package (which is useful for high-dimensional fixed effects) to work with the `broom` package, which makes regression output "tidy". Unfortunately `felm` objects can sometimes be a little different from standard regression output, so sometimes workarounds are needed to make it work with `tidyverse` tools. 

[You can see the problem and solution on Stack Overflow](http://stackoverflow.com/questions/42640252/felm-doesnt-work-with-broomaugment-purrr-but-works-with-tidy).
