include_recipe "addressbook.g0v.tw::default"
include_recipe 'nodejs'
include_recipe 'git'

execute "install LiveScript" do
  command "npm i -g LiveScript@1.1.1"
  not_if "test -e /usr/bin/lsc"
end

# XXX: when used with vagrant, use /vagrant_git as source
git "/opt/addressbook/api.addressbook" do
  repository "git://github.com/g0v/api.addressbook.git"
  reference "master"
  action :sync
end

# XXX: use nobody user instead
execute "install api.addressbook" do
  cwd "/opt/addressbook/api.addressbook"
  action :nothing
  subscribes :run, resources(:git => "/opt/addressbook/api.addressbook"), :immediately
  environment ({"SUDO_USER" => "", "SUDO_UID" => ""})
  command "npm link pgrest && npm i && npm run prepublish"
end
