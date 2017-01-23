---
title: "Booms and Busts in NIH Funding"
excerpt: "How the NIH budgeting process amplifies funding changes"
author: "Tham, Wei Yang"
date: "2017-01-21"
output: html_document
---





There's an interesting feature of how the NIH funds grants that amplifies "booms and busts" in the system. NPR wrote about this in a 2014 [article](http://www.npr.org/sections/health-shots/2014/09/24/351142702/after-the-nih-funding-euphoria-comes-the-hangover) as part of a [series](http://www.npr.org/series/347129694/science-squeezed) on funding issues in biomedical research. I thought it'd be nice to illustrate the point with a couple of simple graphs. 

The basic idea is this: grants are made on a four-year cycle, with one quarter of the promised funds given out each year. If you get a \$1m grant, you get \$250,000 each year rather than \$1m upfront. This means that if the NIH spends the same amount every year, $\frac{3}{4}$ of its budget goes to grants that are starting years 2, 3, or 4 of their cycles and the remaining $\frac{1}{4}$ goes to new grants (i.e. starting year 1 of their cycles). 

Now, imagine that Congress decides to increase the NIH's budget one year. The NIH's obligations to previous grants hasn't changed, and it can't save the money for later, so this leaves it extra money for funding new grants. However, because it is only funding the first year of these new grants, this leaves the NIH with *higher future obligations*.

Let's see what this looks like in a toy example where the NIH budget increases 20% one year and returns to its original levels.

<img src="/figs/2017-01-21-nih_booms_busts/unnamed-chunk-1-1.png" title="center" alt="center" style="display: block; margin: auto;" />

Yowza! Pretty good if you're applying for a grant in year 1, not so good if you're applying in year 2. 

Of course, the real budgeting/funding process is much more complicated, so let's look at some actual funding data to see how this plays out in the real world. ^[You can find this data at [NIH Funding Facts](https://report.nih.gov/fundingfacts/fundingfacts.aspx). You can download the data from the link in an `.xls` file which I then saved as a tab-delimited file so it's easier to read into R. In principle I think you could download all the data, but I had problems trying to do that so I only queried data for R01 and R01-equivalent grants.]  

<img src="/figs/2017-01-21-nih_booms_busts/unnamed-chunk-2-1.png" title="center" alt="center" style="display: block; margin: auto;" />

There are six different "types" of grants in the data, so here I've chosen to look at "All Competing" and "All Types (in aggregate)" grants. "All Competing" grants include grants that are up for renewal but must still go through a competitive process. 

The basic story holds up - funding for "new" projects is more volatile relative to changes in the overall budget.^[Not literally the whole NIH budget. I'm only looking at funding for [R01 grants](https://grants.nih.gov/grants/funding/r01.htm), which are the lifeblood of academic biomedical research.] 

