# Copy specs from bootstrap directory to chefspec directory

bash 'copy specs from bootstrap dir to chefspec dir' do 
  code <<-EOF
    mkdir -p "$HOME/chef-repo/cookbooks/debian_prep/spec/unit/recipes"
    cp -r "$HOME/bootstrap-manjaro-dev-base/manjaro_prep/spec/* $HOME/chef-repo/cookbooks/manjaro_prep/spec/.
  EOF
end 
