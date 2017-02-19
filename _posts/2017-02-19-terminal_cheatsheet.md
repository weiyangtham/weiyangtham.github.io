---
title: "Terminal cheatsheet"
author: "Tham, Wei Yang"
date: "2017-02-19"
output: html_document
tags:
  - code
---



Some terminal commands that I use repeatedly but not enough that I don't have to keep looking them up. Credit goes to friend and fellow OSU grad student Joseph Rossetti for many of these. 

#### SSH login

{% highlight bash %}
ssh -l username name_of_remote_server
{% endhighlight %}

#### Transfer files between remote and local machines

{% highlight bash %}
# From me to remote server
scp my/directory/datafile.txt username@remote_server:/remote/directory

# From remote server to me
scp username@remote_server:/remote/directory/datafilet.txt my/directory/
{% endhighlight %}

### Screen
Screen lets you open multiple windows in Unix. It also lets you run processes after you've logged off a remote server or lost connection for some reason. 

#### Start new session

{% highlight bash %}
screen -S name_of_new_window
{% endhighlight %}
You don't necessarily have to name a session but I think it's helpful to. 

#### List current screen sessions

{% highlight bash %}
screen -ls
{% endhighlight %}

#### Go to a particular screen session

{% highlight bash %}
screen -r name_of_session
{% endhighlight %}

#### Detach from a session

{% highlight bash %}
ctrl + a + d
{% endhighlight %}


#### Exit screen session

{% highlight bash %}
# While in the session
exit

# While detached from the session (http://stackoverflow.com/questions/1509677/kill-detached-screen-session)
screen -X -S [session # you want to kill] quit
{% endhighlight %}






