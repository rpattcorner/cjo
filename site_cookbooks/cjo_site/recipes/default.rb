include_recipe "apache2"
include_recipe "php"
include_recipe "apache2::mod_php5"
include_recipe "awscli"

cookbook_file "/etc/apache2/sites-available/cabinjohnorganizing.com.conf" do
        source "/sites-available/cabinjohnorganizing.com.conf"
        action :create
end

remote_directory "/opt/content/cabinjohnorganizing" do
        source "html"
end

apache_site "cabinjohnorganizing.com" do
  enable true
end

cookbook_file "/etc/apache2/sites-available/andredsweald.org.conf" do
        source "/sites-available/andredsweald.org.conf"
        action :create
end

apache_site "andredsweald.org" do
  enable true
end

cookbook_file "/etc/apache2/sites-available/dorsetwest.com.conf" do
        source "/sites-available/dorsetwest.com.conf"
        action :create
end

bash "copy dorsetwest image" do
        user "root"
        code <<-EOH
                aws s3 cp s3://cjo-content/dorsetwest.tgz /opt/dorsetwest.tgz
                sudo tar xzf /opt/dorsetwest.tgz --directory=/opt/content/
        EOH
        not_if do ::File.exists?("/opt/content/dorsetwest") end
end

apache_site "dorsetwest.com" do
  enable true
end

=begin
apache_site "default" do
  enable true
end

file '/var/www/index.html' do
  action :delete
end

file '/var/www/index.php' do
  content <<-EOH
<?php phpinfo(); ?>
  EOH
end
=end