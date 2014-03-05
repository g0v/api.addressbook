include_recipe "runit"
include_recipe "database"
include_recipe "cron"
include_recipe "postgresql"
include_recipe "addressbook.g0v.tw::nginx"

postgresql_connection_info = {:host => "127.0.0.1",
                              :port => node['postgresql']['config']['port'],
                              :username => 'postgres',
                              :password => node['postgresql']['password']['postgres']}

database 'addressbook' do
  connection postgresql_connection_info
  provider Chef::Provider::Database::Postgresql
  action :create
end

postgresql_database_user 'addressbook' do
  connection postgresql_connection_info
  database_name 'addressbook'
  password 'password'
  privileges [:all]
  action :create
end

postgresql_database "grant schema" do
  connection postgresql_connection_info
  database_name 'addressbook'
  sql "grant CREATE on database addressbook to addressbook"
  action :nothing
  subscribes :query, resources(:postgresql_database_user => 'addressbook'), :immediately
end

connection_info = postgresql_connection_info.clone()
connection_info[:username] = 'addressbook'
connection_info[:password] = 'password'
conn = "postgres://#{connection_info[:username]}:#{connection_info[:password]}@#{connection_info[:host]}/addressbook"

# XXX: use whitelist
postgresql_database "plv8" do
  connection postgresql_connection_info
  database_name 'addressbook'
  sql "create extension plv8"
  action :nothing
  subscribes :query, resources(:postgresql_database_user => 'addressbook'), :immediately
end

include_recipe "addressbook.g0v.tw::apilib"

execute "boot api.addressbook" do
  cwd "/opt/addressbook/api.addressbook"
  action :nothing
  user "nobody"
  command "lsc app.ls --db #{conn} --boot"
  subscribes :run, "execute[install api.addressbook]", :immediately
end

runit_service "addressbookapi" do
  default_logger true
  action [:enable, :start]
  subscribes :restart, "execute[install api.addressbook]"
end

template "/etc/nginx/sites-available/addressbookapi" do
  source "site-addressbookapi.erb"
  owner "root"
  group "root"
  variables {}
  mode 00755
end
nginx_site "addressbookapi"

# pgqd

package "skytools3"
package "skytools3-ticker"
package "postgresql-9.2-pgq3"

directory "/var/log/postgresql" do
  owner "postgres"
  group "postgres"
end

template "/opt/addressbook/londiste.ini" do
  source "londiste.erb"
  owner "root"
  group "root"
  variables {}
  mode 00644
end

template "/opt/addressbook/pgq.ini" do
  source "pgq.erb"
  owner "root"
  group "root"
  variables {}
  mode 00644
end

execute "init londiste" do
  command "londiste3 /opt/addressbook/londiste.ini create-root apiaddressbook 'dbname=addressbook'"
  user "postgres"
end

runit_service "pgqd" do
  default_logger true
  action [:enable, :start]
end