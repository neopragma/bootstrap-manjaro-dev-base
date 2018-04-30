[Top](http://github.com/neopragma/bootstrap-manjaro-dev-base)

# Issues with OpenBox installs

As of 30 Apr 2018: OpenBox itself installed fine. One of the following associated packages (have not determined which one) caused the system not to boot. 

- oblogout
- obconf 
- obmenu
- openbox-themes

It may be possible to add niceties to OpenBox on Manjaro, but I did not spend much time trying to track down the problem on this occasion. 

I suspect there is a way to install one or more of these packages on Manjaro because there is another distro called [Mabox](https://maboxlinux.org) that is based on Manjaro and has a fully-configured OpenBox environment. Unfortunately, it is an in-memory "live" iso that [does not install cleanly to disk](https://github.com/neopragma/provision-lightweight-development-environments/blob/master/failures/mabox-fail.md). Therefore, I was unable to use it as a base for a lightweight development environment. 
