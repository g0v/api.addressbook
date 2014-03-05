include_recipe "runit"
include_recipe "database"
include_recipe "cron"

directory "/opt/addressbook" do
  action :create
end

directory "/opt/addressbook/cache" do
  action :create
  owner "nobody"
end
