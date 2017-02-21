---
title: "Using igraph for a non-network problem"
author: "Tham, Wei Yang"
date: "2017-02-20"
output: html_document
---



I recently had a problem of the following form: suppose I have data on some companies, but these companies names' might have changed over the years. For example, a company might have started out as Apple, then become Banana, and then Cabbage. In my use case, I had this information as a dataframe of pairs of company names. For example:


{% highlight r %}
library(tidyverse)
library(magrittr)
theme_set(theme_grey(base_size = 20))

df = data_frame(company_name1 = c("Apple", "Banana", "poop1"), company_name2 = c("Banana", "Cabbage", "poop2"), actual_company = c("Apple", "Apple", "poop inc."))
df
{% endhighlight %}



{% highlight text %}
## # A tibble: 3 × 3
##   company_name1 company_name2 actual_company
##           <chr>         <chr>          <chr>
## 1         Apple        Banana          Apple
## 2        Banana       Cabbage          Apple
## 3         poop1         poop2      poop inc.
{% endhighlight %}

With this as a starting point, I want to standardize the name of the company to be "Apple" across all years, i.e. I want to tell R that `Apple = Banana = Cabbage --> Apple = Cabbage`. I couldn't think of a particularly clean way to code this up. 

Then it hit me that this was just a network problem! I was just trying to find the variants of company names that were connected to each other (below is an illustration and a terrible excuse to play with the `ggraph` package). 


{% highlight r %}
library(ggraph)
library(igraph)

dfgraph = graph_from_data_frame(df, directed = FALSE)

ggraph(dfgraph) + 
  geom_edge_link(aes(colour = actual_company)) + geom_node_point() 
{% endhighlight %}

<img src="/figs/2017-02-20-igraph-nonnetwork/unnamed-chunk-2-1.png" title="center" alt="center" style="display: block; margin: auto;" />


Enter `igraph`, a popular R package for dealing with network data. I just need to use `igraph` functions to convert the dataframe of pairs of company names into an (undirected) graph (i.e. a network), and then it can tell me which company names belong to the same group by finding the [connected components](https://en.wikipedia.org/wiki/Connected_component_(graph_theory)) of the network. 


{% highlight r %}
dfgraph = graph_from_data_frame(df, directed = FALSE)

df_components = components(dfgraph)

names_in_groups = 
  data_frame(company_name = names(df_components$membership), group = df_components$membership) %>% 
  arrange(group)
names_in_groups
{% endhighlight %}



{% highlight text %}
## # A tibble: 5 × 2
##   company_name group
##          <chr> <dbl>
## 1        Apple     1
## 2       Banana     1
## 3      Cabbage     1
## 4        poop1     2
## 5        poop2     2
{% endhighlight %}

I'm not necessarily recommending this as the best way to handle the problem. I just think it's fun when you're able to reformulate a problem for a different domain, and in this case it also lead to a reasonably straightforward solution. 
