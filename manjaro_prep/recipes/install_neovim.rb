# install and configure neovim editor

package 'python-pip'
package 'python3-pip'
package 'neovim'

execute 'add python support to neovim' do
  command "$(pip2 install --user neovim)"
end

execute 'add python3 support to neovim' do
  command "$(pip3 install --user neovim)"
end

directory 'root nvim autoload directory' do 
  path "$HOME/.config/nvim/autoload" 
  recursive true 
  owner 'dev'
  group 'dev'
  mode '0755'
end 

directory 'root nvim bundle directory' do 
  path "$HOME/.config/nvim/bundle" 
  recursive true
  owner 'dev' 
  group 'dev'
  mode '0755'
end 

execute 'install pathogen plugin' do
  command "$(curl -LSso $HOME/.config/nvim/autoload/pathogen.vim https://tpo.pe/pathogen.vim)"
end

git 'install neovim plugin deoplete' do
  destination "$HOME/.config/nvim/bundle/deoplete"
  repository 'git://github.com/Shougo/deoplete.nvim.git'
end

git 'install neovim plugin neomake' do 
  destination "$HOME/.config/nvim/bundle/neomake"
  repository 'git://github.com/neomake/neomake'
end
git 'install nerdtree plugin to neovim' do 
  destination "$HOME/.config/nvim/bundle/nerdtree" 
  repository 'git://github.com/scrooloose/nerdtree.git' 
end 

git 'install neovim plugin nerdtree-git-plugin' do 
  destination "$HOME/.config/nvim/bundle/nerdtree-git-plugin"
  repository 'git://github.com/Xuyuanp/nerdtree-git-plugin.git'
end  

git 'install neovim plugin bash-support' do 
  destination "$HOME/.config/nvim/bundle/bash-support" 
  repository 'git://github.com/WolfgangMehner/bash-support.git' 
end 

git 'install neovim plugin c-support' do 
  destination "$HOME/.config/nvim/bundle/c-support"
  repository 'git://github.com/WolfgangMehner/c-support.git' 
end 

git 'install neovim plugin python-mode' do 
  destination "$HOME/.config/nvim/bundle/python-mode" 
  repository 'git://github.com/klen/python-mode.git'
end

git 'install neovim plugin vim-ruby' do
  destination "$HOME/.config/nvim/bundle/vim-ruby" 
  repository 'git://github.com/vim-ruby/vim-ruby.git'
end 
 
directory 'root nvim after indent' do
  path "$HOME/.config/nvim/after/indent"
  recursive true
  owner 'dev'
  group 'dev'
  mode '0755'
end 

bash 'copy neovim after indent files' do
  code <<-EOF
    cp "$HOME/bootstrap-manjaro-dev-base/neovim/after/indent/* $HOME/.config/nvim/after/indent/.
    EOF
end

# Add Spacegray color scheme to neovim 
directory 'nvim pack vendor directory' do
  path "$HOME/.config/nvim/pack/vendor/start"
  recursive true
  owner 'dev'
  group 'dev'
  mode '0755'
end 

git 'install Spacegray plugin to neovim' do 
  destination "$HOME/.config/nvim/pack/vendor/start/Spacegray"
  repository 'git://github.com/ajh17/Spacegray.vim' 
end 
