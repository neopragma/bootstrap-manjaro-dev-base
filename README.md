# Manjaro Linux: Build Base for Lightweight Development Environments

For general information about this repo and related ones, please see [Provision Lightweight Development Environments](http://github.com/neopragma/provision-lightweight-development-environments).

## From -> To

**From:** No operating system installed.

**To:** Manjaro configured to receive provisioning to customize it for software development.

## 1. Install Manjaro Linux

### 1.1. Download iso

Download iso from <a href="https://manjaro.org">https://manjaro.org</a>.

### 1.2. Install Manjaro.

Create a VM using the downloaded iso. Give it 2 GB memory and a 20 GB virtual drive. 

(This is not quite as lightweight as we really want; we're aiming for a maximum memory footprint of 1 GB. But this could be useful for people who have a normal desktop or laptop as opposed to a VM, container, or single-board computer, and who prefer the Arch way of doing things.)

On the boot menu, arrow down to the option "Boot: Manjaro.x86_64 xfce" and press Enter to start. It will boot to an xfce desktop. It is _very_ slow. Don't panic if you see a black screen for 30-40 seconds. 

**WARNING:** A "Welcome" dialog appears with a button to "Launch installer". _Do not touch that button._ Exit out of the "Welcome dialog" immediately. 

Open a terminal window, either by right-clicking on the desktop and choosing "Terminal" or by clicking on the green icon in the lower left-hand corner of the display and choosing "Terminal". 

**WARNING:** If you open the terminal from the context menu (right-click on the desktop), it will open in subdirectory ```/dev/Desktop```. You want to be in the home directory of user 'dev'. Double-check where you are before entering commands.

Start the installer from the command line:

```shell
cd
sudo calamares
``` 

Follow the prompts in the usual way. Create an administative user with name 'Developer', username 'dev', and password 'developer'. Select "Use the same password for the administrator account".

**WARNING:** When the install gets to the stage of "Unsquash filesystem", expect it to slow down considerably. You might imagine it's hung when it hits about 24% to 26%. (That is what happened with the [Redcore](failures/redcore-fail.md) installation.) In this case, it's only slow. _Painfully_ slow.

Eventually, the installer will proclaim "All done" and invite you to reboot. Select the "Restart now" checkbox and press the "Done" button. 

From the GNU GRUB menu, choose "Manjaro Linux". If all is well, that will take you to a login form that has been pre-filled with the name of the user you created during installation. Enter the password and see if the login works.

## 1.3. Synchronize the system.

Because of the way the Arch package manager, Pacman, works, you need to synchronize the system before installing any packages. Otherwise, there is a risk dependencies will be at the wrong versions and things won't work. 

**OPINION:** This aspect of the way Pacman works is an _extreme_ PITA. It supports the "rolling upgrade" philosophy of the Arch community. I had to start over completely several times when testing these instructions, because once you've messed things up it's all but impossible to recover. It is a _good_ reason to choose a distro that uses a different package manager. 

Login as 'dev'. Dismiss the "hello" dialog. Open a terminal emulator. 

Before updating the system, you have to chooe mirrors that pacman will use to download packages. The mirrors change in availability, speed, and currency. Failing to update the mirror list can cause the system to break, as you can inadvertently install the wrong versions of libraries. 

This command will select the fastest up-to-date 5 mirrors and run pacman to synchronize your system:

```shell
sudo pacman-mirrors --fasttrack 5 && sudo pacman -Syyu
``` 

Now reboot.

```
reboot
```

If the system will not boot, there was likely a problem with synchronizing. If the system boots, log in again as 'dev'. Dismiss the "hello" dialog. Open a terminal emulator and continue with Step 2.

## 2. Provision the instance as a "base" for development environments.

This will install enough software on the instance to enable it to be used as a template for building software development environments tailored to different programming languages and development/testing tools. 

### 2.1. Install git.

The provisioning scripts are on Github. The instance needs git support to clone the repository and complete the configuration. 

```shell 
sudo pacman -Sy git 
``` 

Check the git version as a way to see if it was installed:

```shell
git --version
```

### 2.2. Clone the Git repository

```shell
cd 
git clone git://github.com/neopragma/bootstrap-manjaro-dev-base
```

### 2.3. Create dev user's bin directory

```shell
cd
mkdir bin
chmod +x bin
``` 

Add $HOME/bin to the PATH in ```.bashrc```. Add this line to the end of ```.bashrc```.

```
PATH="$HOME/bin:$PATH"
```

### 2.4. (Optional) Review default configuration and modify as desired.

If you want your template to be configured differently than the default, make the necessary changes to bash scripts, Chef recipes, and configuration files. 

In particular, look at:

The directory structure of the provisioning repository looks like this:

```
bootstrap-debian-9-dev-base/
    bootstrap              Bash script to prepare the instance to run Chef
                           and kick off the Chef cookbook that completes
                           the provisioning.

    scripts/               ```bootstrap``` copies these files to /usr/local/bin.
        cli                Escape from OpenBox to command line from terminal
        provision          Run the Chef cookbook to provision the instance
        cook               Run one Chef cookbook or cookbook::recipe
        recipes            List the available Chef recipes for provisioning
        runchefspec        Run `bundle exec rake` to run rspec on Chef recipes

    manjaro_prep/          ```bootstrap``` copies these files to prepare Chef
        Gemfile            => /root/chef-repo/cookbooks/debian_prep/
        Rakefile           => /root/chef-repo/cookbooks/debian_prep/
        recipes/           => /root/chef-repo/cookbooks/debian_prep/
        spec/
            spec_helper.rb => /root/chef-repo/cookbooks/debian_prep/spec
            unit/recipes/  => /root/chef-repo/cookbooks/debian_prep/spec/unit/recipes

    neovim/                Chef recipe ```install_neovim``` performs these copies.
                           => /root/.config/nvim/
                           => /dev/.config/nvim/

    openbox/               Chef recipe ```install_x``` performs these copies.
                           => /dev/.config/openbox/
```

### 2.5. Run the bootstrap script.

If all goes well, this will provision the instance as a base or template for building development environments. Check the results carefully in case of errors. There are many steps and anything can happen despite care in preparing the script. 

```shell 
cd /root/bootstrap-debian-9-dev-base
./bootstrap 
``` 

### 3. Manual configuration of NeoVim.

Some steps can't be scripted. 

#### 3.1. Install python support for NeoVim plugins.

THIS MIGHT NOT BE TRUE FOR MANJARO - CHEF MIGHT BE ABLE TO DO IT.

```shell 
pip2 install --user neovim 
pip3 install --user neovim 
```

#### 3.2. Enable plugins 

One-time run of :UpdateRemotePlugins for certain plugins.

- Start neovim 
- Run the editor command :UpdateRemotePlugins
- Quit neovim

### 4. Known issues with the bootstrap process

#### 4.1. Installing Chef 

Standard ways of installing Chef do not work on Manjaro Linux.

- Installing by curl from omnitruck (as documented [here](https://docs.chef.io/install_omnibus.html) doesn't work for Manjaro because omnitruck has no package prepared for that platform.
- Installing package ```chef-dk``` from AUR (as documented [here](https://wiki.archlinux.org/index.php/Chef)) doesn't work because Manjaro does not support the use of AUR. Also, according to the [Vagrant/Arch documentation](https://wiki.archlinux.org/index.php/Vagrant) the AUR link to ```chef-dk``` has been broken since February 2018. 
- Installing Chef by installing ```omnibus-chef``` from AUR (as documented [here](https://wiki.archlinux.org/index.php/Chef)) doesn't work because Manjaro does not support the use of AUR.
- Installing from source (as documented [here](https://wiki.archlinux.org/index.php/Chef)) doesn't work because the [omnibus git repo](https://github.com/opscode/omnibus-chef) doesn't have a Gemfile, and ```bundle install --binstubs``` fails. No help available.
- The use of ```gem install chef``` is strongly discouraged for Arch platforms ([see](https://wiki.archlinux.org/index.php/Chef), bottom of page).
- The method documented by [Eric Helgeson](https://erichelgeson.github.io/blog/2015/06/08/building-chef-source-prefix/) does not work because of various RSA key fingerprint and access rights issues. No help available. 
- Omnibus build recommended for Chef developers and not general users is documented on the [Chef Github project](https://github.com/chef/chef). This runs to completion, but fails its own health check. 

Building from source as documented [here](https://github.com/chef/chef) seemed to work. After the install, ```chef-client``` was on the path, although not in the same place as a normal install would put it. The site warns against building this way unless you are a Chef developer. 




### 5. Known issues after system comes up


