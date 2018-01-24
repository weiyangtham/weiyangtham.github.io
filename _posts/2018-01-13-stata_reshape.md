---
title: "Stata's `reshape` in R"
author: "Tham, Wei Yang"
date: "2018-01-13"
output: html_document
tags:
  - r
  - stata
---





Update: There is an R function called `reshape` from the `stats` package that does the same thing. As far as I can tell, the main differences are since it's not a tidyverse function, it doesn't have access to the `dplyr` select helpers for selecting columns and doesn't use the key-value framework. 

If you've used Stata you might be familiar with its [`reshape`](https://www.stata.com/manuals13/dreshape.pdf) command. `reshape` makes a wide dataset long and vice versa. The equivalent in the `tidyverse` would be the `gather` (wide to long) and `spread` (long to wide) functions from the `tidyr` package. The difference is that `gather` and `spread` work on key-*value* pairs, emphasis on the singular "value", while `reshape` is fine with having multiple values associated with a single key. For example, to reshape the following (fake) wide dataset from this:


|id | age2000| age2010| scores2000| scores2010|
|:--|-------:|-------:|----------:|----------:|
|A  |      11|      21|         96|        100|
|B  |      12|      22|         97|         99|
|C  |      13|      23|         98|         98|
|D  |      14|      24|         99|         97|
|E  |      15|      25|        100|         96|

to this:


|id |year | age| scores|
|:--|:----|---:|------:|
|A  |2000 |  11|     96|
|A  |2010 |  21|    100|
|B  |2000 |  12|     97|
|B  |2010 |  22|     99|
|C  |2000 |  13|     98|
|C  |2010 |  23|     98|
|D  |2000 |  14|     99|
|D  |2010 |  24|     97|
|E  |2000 |  15|    100|
|E  |2010 |  25|     96|

In Stata you would do this with something **like**[^1] `reshape long age scores, i(id) j(year)`.

[^1]: I didn't check this code in Stata so could be wrong!

With the `tidyr` functions, you need to first `gather`:


{% highlight r %}
scores_vlong = scores %>% tidyr::gather("key2", "value", c(age2000:scores2010))
scores_vlong
{% endhighlight %}



{% highlight text %}
##    id       key2 value
## 1   A    age2000    11
## 2   B    age2000    12
## 3   C    age2000    13
## 4   D    age2000    14
## 5   E    age2000    15
## 6   A    age2010    21
## 7   B    age2010    22
## 8   C    age2010    23
## 9   D    age2010    24
## 10  E    age2010    25
## 11  A scores2000    96
## 12  B scores2000    97
## 13  C scores2000    98
## 14  D scores2000    99
## 15  E scores2000   100
## 16  A scores2010   100
## 17  B scores2010    99
## 18  C scores2010    98
## 19  D scores2010    97
## 20  E scores2010    96
{% endhighlight %}

Then `extract`[^2] and `spread`:


{% highlight r %}
scores_vlong %>% 
  tidyr::extract("key2", c("colname", "year"), 
                 regex = "([a-z]+)(\\d+)") %>%
  tidyr::spread("colname", "value")
{% endhighlight %}



{% highlight text %}
##    id year age scores
## 1   A 2000  11     96
## 2   A 2010  21    100
## 3   B 2000  12     97
## 4   B 2010  22     99
## 5   C 2000  13     98
## 6   C 2010  23     98
## 7   D 2000  14     99
## 8   D 2010  24     97
## 9   E 2000  15    100
## 10  E 2010  25     96
{% endhighlight %}

[^2]: The first part of the regex, `"([a-z]+)"`, extracts the word, then `(\\d+)` extracts the digits. 

I've been thinking about writing a function to automate this process for a while and finally got some impetus to do so when [Paul Goldsmith-Pinkham](https://twitter.com/paulgp) asked about the issue on Twitter. Plus it was a good way to practice working with [quasiquotation](http://dplyr.tidyverse.org/articles/programming.html).

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">For <a href="https://twitter.com/hashtag/rstats?src=hash&amp;ref_src=twsrc%5Etfw">#rstats</a> users -- how do I reshape wide / long using gather and spread with multiple variables?</p>&mdash; Paul G-P (@paulgp) <a href="https://twitter.com/paulgp/status/952178749075804160?ref_src=twsrc%5Etfw">January 13, 2018</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>


[`gather_multivalue` and `spread_multivalue`](https://github.com/weiyangtham/twydyverse) are basically wrappers around this sequence of steps.[^3] So now you only need one line:

[^3]: Which in turn are from [Hadley Wickham's Stackoverflow answer](https://stackoverflow.com/questions/25925556/gather-multiple-sets-of-columns)



{% highlight r %}
# equivalent

gather_multivalue(scores, "year", age2000:scores2010)
gather_multivalue(scores, "year", -id)
{% endhighlight %}

`gather_multivalue` also asks you to specify a regular expression (regex) for how to extract the key and values. The default regex assumes that the columns are of the form `(word)(number)`. I like that regex gives you some flexibility if you get columns with slightly weird or varying patterns:


|id | age.2000| age.2010| scores_2000| scores_2010|
|:--|--------:|--------:|-----------:|-----------:|
|A  |       11|       21|          96|         100|
|B  |       12|       22|          97|          99|
|C  |       13|       23|          98|          98|
|D  |       14|       24|          99|          97|
|E  |       15|       25|         100|          96|

The columns have different separators, `.` and `_`.


{% highlight r %}
twydyverse::gather_multivalue(scores_dumb, "year", 
                              age.2000:scores_2010, 
                              regex = "([a-z]+)[\\.|_](\\d+)") 
{% endhighlight %}



{% highlight text %}
##    id year age scores
## 1   A 2000  11     96
## 2   A 2010  21    100
## 3   B 2000  12     97
## 4   B 2010  22     99
## 5   C 2000  13     98
## 6   C 2010  23     98
## 7   D 2000  14     99
## 8   D 2010  24     97
## 9   E 2000  15    100
## 10  E 2010  25     96
{% endhighlight %}

Of course the tradeoff is that you need to specify a regex, but for the purposes of working with column names I don't imagine that's likely to get too complicated.

These functions are available in my personal package:


{% highlight r %}
# install.packages("devtools")
devtools::install_github("weiyangtham/twydyverse")
{% endhighlight %}


