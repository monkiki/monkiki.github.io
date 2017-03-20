---
author: monkiki
comments: true
date: 2014-03-28 09:49:32+00:00
layout: post
link: https://monkiki.wordpress.com/2014/03/28/ssh-and-windows/
slug: ssh-and-windows
title: SSH and Windows
wordpress_id: 237
categories:
- Debian
- Ubuntu
- Windows
tags:
- linux
- ssh
- windows
---

You can configure a SSH server in Windows installing [freeSSHd](http://www.freesshd.com/). Once installed you have to create an user and will be used to access to the Windows server. To be accesible to also need to open the 22 port in the Windows firewall.

If you use a Windows virtual machine to access another server because a VPN, you can connect from your Linux console to the destination server using this Windows as a proxy. For example, the final server IP is 192.168.1.25 and the Windows IP is 192.168.0.12. The port forwarding will be from 192.168.0.12:5555 to 192.168.1.25:22. Yo can achieve this in several ways:

## Windows provided solution

Creation rule:

{% highlight cmd %}
netsh interface portproxy add v4tov4 listenport=5555 listenaddress=0.0.0.0 connectport=22 connectaddress=192.168.1.25
{% endhighlight %}

Delete rule:

{% highlight cmd %}
netsh interface portproxy delete v4tov4 listenport=5555 listenaddress=0.0.0.0
{% endhighlight %}

## Using an application

Install the application [PassPort](http://sourceforge.net/projects/pjs-passport/). Yo must run this application as Administration to be able to setup the forward.

## Using Putty

Putty can also configure port forwarding (in this case it's called SSH Tunneling because the forward is secured because it's encrypted). Go to **Connection** > **SSH** > **Tunnels** and create with this data:
	
  * Local ports accept connections from other hosts: Checked
  * Source port: 5555
  * Destination: 192.168.1.25:22
  * Local: Checked
  * Auto: Checked

Once completed, click on the **Add** button.
