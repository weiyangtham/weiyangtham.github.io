---
title: "Verbosity in code"
author: "Tham, Wei Yang"
date: "2017-03-05"
excerpt: "In coding, err on the side of being verbose."
tags: 
  - r
  - code
output: html_document
---



Something I've come to appreciate is the value of verbosity in code. It's slightly counter-intuitive because we often want to optimize for speed, so we might choose shorter names for files/variables/functions, but this can come at the expense of clarity. 

To steal a quote that Hadley Wickham used in his [tidy tools manifesto](https://cran.r-project.org/web/packages/tidyverse/vignettes/manifesto.html): 

> Programs must be written for people to read, and only incidentally
> for machines to execute.
> 
> --- Hal Abelson

I recommend scrolling down to the end of the [tidy tools page](https://cran.r-project.org/web/packages/tidyverse/vignettes/manifesto.html) for a short list of principles on naming objects in your code. The [coding style guide](http://www.brown.edu/Research/Shapiro/pdfs/CodeAndData.pdf) at the end of Matt Gentzkow and Jesse Shaprio's immensely helpful guide is also great. 

### Use autocomplete to your advantage

With autocomplete, the cost of having longer and more explicit names is much lower than before. In fact, you can even incorporate it into your process of coming up with names. 

As Hadley suggests, "(m)ake sure that function families are identified by a common prefix, not a common suffix. This makes autocomplete more helpful, as you can jog your memory with the prompts." 

This is surely applicable to not just functions but families of variables or data objects. 

### If you use STATA...

...there are even more temptations to not be explicit. STATA has the feature that instead of typing out the entire name of a command, you only need to type out the first few letters. For example, to `generate` a new variable you only need to type `gen`. 

That works well for some cases - it's pretty obvious what `gen` refers to - but not so well for others. For example, the `summarize` command can be called with as little as `su` or `sum`, or the `rename` command with `ren`. This can save you a good amount of typing, but it's really hard to read. It's especially confusing for the `summarize` command because `sum` is actually a word that means something. If I see a piece of code like this,


{% highlight r %}
ren wages salary
{% endhighlight %}

at least my brain has to stop completely to figure out what `ren` means. 

By contrast, if I see this, which provides summary statistics on wages and age


{% highlight r %}
sum wages age 
{% endhighlight %}

first I read it as the word "sum", which is also a function in STATA that does exactly that, then I have to reinterpret it as `summarize` by recognizing that that's not how you would normally call the `sum` function. 

Finally, if you need to test for missing values in STATA, use the `missing()` function rather than whether a variable is "equal to missing". And please don't use the shorthand `mi()` for god's sake. 


{% highlight r %}
# these are the same thing but the second is more readable
replace wages = 0 if wages != . 

replace wages = 0 if missing(wages)
{% endhighlight %}






