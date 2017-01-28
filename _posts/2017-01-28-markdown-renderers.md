---
title: "Rendering markdown for a Github Pages website"
author: "Tham, Wei Yang"
date: "January 28, 2017"
output: html_document
tags:
  - code
  - markdown
---



One problem I ran into trying to write posts for this website was that R Markdown uses Pandoc to render Markdown documents, but Github Pages [only supports Kramdown](https://help.github.com/articles/updating-your-markdown-processor-to-kramdown/). I learned this the hard way when I edited my `config.yml` file to use Pandoc instead of Kramdown, based on [this advice](http://stackoverflow.com/questions/36019756/knitr-chunk-in-footnote-with-jekyll). You will be able to build your page locally with `build exec jekyll serve` but once you push everything to Github the page will fail to build.

There are slight differences between Pandoc and Kramdown for writing math symbols and footnotes. 

1. Kramdown doesn't recognize single dollar signs for inline math i.e. `$...$` won't work. You have to use `$$...$$`. It does mean that when you Knit your html file the expression will be displayed in a new line, although it will still appear inline when you build the page locally. 

2. In Pandoc you can write inline footnotes with `^[My inline footnote]`, but Kramdown doesn't parse that as a footnote. This isn't too convenient; you can still use the [usual footnote syntax](http://rmarkdown.rstudio.com/authoring_pandoc_markdown.html). 



