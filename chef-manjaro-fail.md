[Top](http://github.com/neopragma/boostrap-manjaro-dev-base)

# 4.1. Unable to use Chef on Manjaro Linux 

As of 30 Apr 2018 I was unable to make Chef work on Manjaro Linux. These were the issues. 

Standard ways of installing Chef do not work on Manjaro Linux:

- Installing by curl from omnitruck (as documented [here](https://docs.chef.io/install_omnibus.html) doesn't work for Manjaro because omnitruck has no package prepared for that platform.
- Installing package ```chef-dk``` from AUR (as documented [here](https://wiki.archlinux.org/index.php/Chef)) doesn't work because Manjaro does not support the use of AUR. Also, according to the [Vagrant/Arch documentation](https://wiki.archlinux.org/index.php/Vagrant) the AUR link to ```chef-dk``` has been broken since February 2018. 
- Installing Chef by installing ```omnibus-chef``` from AUR (as documented [here](https://wiki.archlinux.org/index.php/Chef)) doesn't work because Manjaro does not support the use of AUR.
- Installing from source (as documented [here](https://wiki.archlinux.org/index.php/Chef)) doesn't work because the [omnibus git repo](https://github.com/opscode/omnibus-chef) doesn't have a Gemfile, and ```bundle install --binstubs``` fails. No help available.
- The use of ```gem install chef``` is strongly discouraged for Arch platforms ([see](https://wiki.archlinux.org/index.php/Chef), bottom of page).
- The method documented by [Eric Helgeson](https://erichelgeson.github.io/blog/2015/06/08/building-chef-source-prefix/) does not work because of various RSA key fingerprint and access rights issues. No help available. 
- Omnibus build recommended for Chef developers and not general users is documented on the [Chef Github project](https://github.com/chef/chef). This runs to completion, but fails its own health check. 

Building from source as documented [here](https://github.com/chef/chef) seemed to work. After the install, ```chef-client``` was on the path, although not in the same place as a normal install would put it. The site warns against building this way unless you are a Chef developer. It is not intended for Chef users.

When executing Chef on Manjaro Linux, the following error occurs:

```
/home/dev/.rvm/rubies/ruby-2.4.1/lib/ruby/site_ruby/2.4.0/rubygems.rb:271:in `find_spec_for_exe': can't find gem chef (>= 0.a) (Gem::GemNotFoundException)
    from /home/dev/.rvm/rubies/ruby-2.4.1/lib/ruby/site_ruby/2.4.0/rubygems.rb:299:in `active_bin_path'
    from /home/dev/.rvm/gems/ruby-2.4.1/bin/chef-client:23:in `&lt;main&gt;' 
```

Attempted fixes:
- gem install chef
- bundle install in /home/dev/chef (chef gem is listed in Gemfile there)

No change in observed behavior. No help found online. 

Workaround: Remove Chef from this process and do everything in bash.
