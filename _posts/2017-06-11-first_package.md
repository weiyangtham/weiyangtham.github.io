---
title: "My first ever R package!"
author: "Tham, Wei Yang"
date: "2017-06-11"
output: html_document
---



Well this is pretty darn exciting. I made my first package and first custom theme! Check it out [here](https://github.com/weiyangtham/econothemes)!

You can install it as follows: 


{% highlight r %}
devtools::install_github("weiyangtham/econothemes")
{% endhighlight %}

Here's a quick example: 


{% highlight r %}
library(ggplot2)
library(econothemes)

ggplot(mtcars, aes(mpg, wt)) +
  geom_point() +
  labs(x="Fuel efficiency (mpg)", y="Weight (tons)",
       title="Seminal ggplot2 scatterplot example",
       subtitle="A plot that is only useful for demonstration purposes",
       caption="Same example as in hrbrthemes'") + 
  theme_nber()
{% endhighlight %}

<img src="/figs/2017-06-11-first_package/unnamed-chunk-2-1.png" title="center" alt="center" style="display: block; margin: auto;" />

I'll do a more in-depth post about the process, complete with acknowledgements for all the people whose Github accounts I raided for code, but for now I just really wanted to share this. 


