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

(This is not quite as lightweight as we really want; we're aiming for a maximum memory footprint of 1 GB. But this could be useful for people who have sufficient memory available and who prefer the Arch way of doing things.)

On the boot menu, arrow down to the option "Boot: Manjaro.x86_64 xfce" and press Enter to start. It will boot to an xfce desktop. It is _very_ slow. Don't panic if you see a black screen for 30-40 seconds. 

**WARNING:** A "Welcome" dialog appears with a button to "Launch installer". _Do not touch that button._ Exit out of the "Welcome dialog" immediately. 

Open a terminal window, either by right-clicking on the desktop and choosing "Terminal" or by clicking on the green icon in the lower left-hand corner of the display and choosing "Terminal". 

**WARNING:** If you open the terminal from the context menu (right-click on the desktop), it will open in subdirectory ```/home/dev/Desktop```. You want to be in the home directory of user 'dev'. Double-check where you are before entering commands.

Start the installer from the command line:

```shell
cd
sudo calamares
``` 

Follow the prompts in the usual way. Create an administative user with name 'Developer', username 'dev', and password 'developer'. Select "Use the same password for the administrator account".

**WARNING:** When the install gets to the stage of "Unsquash filesystem", expect it to slow down considerably. You might imagine it's hung when it hits about 24% to 26%. 

Eventually, the installer will proclaim "All done" and invite you to reboot. Select the "Restart now" checkbox and press the "Done" button. 

From the GNU GRUB menu, choose "Manjaro Linux". If all is well, that will take you to a login form that has been pre-filled with the name of the user you created during installation. Enter the password and see if the login works.

## 1.3. Synchronize the system.

Because of the way the Arch package manager, Pacman, works, you need to synchronize the system before installing any packages. Otherwise, there is a risk dependencies will be at the wrong versions and things won't work. 

Login as 'dev'. Dismiss the "hello" dialog. Open a terminal emulator. 

Before updating the system, you have to choose mirrors that pacman will use to download packages. The mirrors change in availability, speed, and currency. Failing to update the mirror list can cause the system to break, as you can inadvertently install the wrong versions of libraries. 

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

If you want your template to be configured differently than the default, make the necessary changes. 

In particular, look at:

The directory structure of the provisioning repository looks like this:

```
bootstrap-manjaro-dev-base/
    bootstrap              Bash script to provision the instance.
    neovim/                => $HOME/.config/nvim/
```

### 2.5. Run the bootstrap script.

If all goes well, this will provision the instance as a base or template for building development environments. Check the results carefully in case of errors. There are many steps and anything can happen despite care in preparing the script. 

```shell 
cd $HOME/bootstrap-debian-9-dev-base
./bootstrap 
``` 

This will not run unattended. After installing Ruby, it will execute some commands that require ```sudo```. At that point, it will prompt for the password, 'developer'.

### 3. Manual configuration of NeoVim.

One-time run of :UpdateRemotePlugins for certain plugins.

- Start neovim 
- Run the editor command :UpdateRemotePlugins
- Quit neovim

### Cleanup

When you are satisfied the environment is configured correctly, you can delete directory ```$HOME/bootstrap-manjaro-dev-base```. 

### Issues

This version of the dev base environment differs from the others due to certain issues in configuring it.

- [Unable to use Chef on Manjaro](chef-manjaro-fail.md)
- [OpenBox add-on packages cause boot errors](openbox-manjaro-fail.md)
