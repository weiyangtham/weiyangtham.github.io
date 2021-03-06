---
title: 'Drawing a timeline with ggplot2'
author: "Tham, Wei Yang"
date: "2017-04-23"
output: html_document
excerpt: "Use when you're in a pinch"
tags:
  - r
---



Recently I wanted to create a timeline for a presentation the next day and came up with this code chunk. I'm certainly not recommending it as the prettiest or quickest way to make a timeline, but I couldn't get Dean Attali's [`timevis`](https://daattali.com/shiny/timevis-demo/) to work in an ioslides presentation. I also didn't know about [`timeline`](http://jason.bryer.org/timeline/), which I'll try in the future. 

The idea is pretty simple - it's basically a standard use of `geom_label`, and then you remove unnecessary axes, background elements and so on.[^1]  The thing that really makes this work is the `str_wrap` function from the `stringr` package. If you have a table of years and event descriptions, you can pass the event descriptions through `str_wrap`, so the "plotted" text will be wrapped nicely. 

[^1]: For the sake proper attribution, I got some of the code for removing graph elements from Stack Overflow but can't find that question anymore. 


{% highlight r %}
years = c(1998L, 2001L, 2004L, 2006L, 2006L, 2009L)
events = data_frame(event = c("Impeachment of Bill Clinton", 
                     "George W. Bush takes office", 
                     "Kerry runs against Bush", 
                     "Something happens", 
                     "Another thing happens", 
                     "Barack Obama takes office"), 
           year = c(1998L, 2001L, 2004L - 0.2, 2006L, 2006L, 2009L), 
           y = 1, 
           vpos = c(1.2, 1.2, 1.2, 1.5, 1.2, 1.2))

events %<>% mutate(event = str_wrap(event, 15))

events %>% 
  ggplot(aes(year, y)) + geom_point() + 
  geom_line() + geom_label(aes(x = year, y = vpos, label = event), size = 5) + 
  theme(
    panel.border = element_blank(), panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"), 
    axis.line.y = element_blank(), axis.text.y = element_blank(), axis.title.y = element_blank()) +
  coord_cartesian(ylim = c(0, 2), xlim = c(1997, 2010)) + 
  scale_x_continuous(breaks = c(1998L, 2001L, 2004L, 2006L, 2009L)) + 
  geom_segment(aes(xend = year, y = 0, yend = 1)) + 
  labs(x = "Year", title = "Example with Political Events")
{% endhighlight %}

<img src="/figs/2017-04-23-timeline_quick/unnamed-chunk-1-1.png" title="center" alt="center" style="display: block; margin: auto;" />

