include_recipe "apache2"
include_recipe "php"
include_recipe "apache2::mod_php5"
include_recipe "apache2::mod_proxy"
include_recipe "apache2::mod_proxy_balancer"
include_recipe "apache2::mod_proxy_http"
include_recipe "apache2::mod_rewrite"
include_recipe "awscli"

cookbook_file "/etc/apache2/sites-available/cabinjohnorganizing.com.conf" do
        source "/sites-available/cabinjohnorganizing.com.conf"
        action :create
end

cookbook_file "/etc/apache2/sites-available/andredsweald.org.conf" do
        source "/sites-available/andredsweald.org.conf"
        action :create
end

cookbook_file "/etc/apache2/sites-available/dorsetwest.com.conf" do
        source "/sites-available/dorsetwest.com.conf"
        action :create
end

remote_directory "/opt/content/cabinjohnorganizing" do
        source "html"
end
=begin
package "libapache2-mod-php5" do
    action :install
end

%w[ proxy_http proxy_balancer proxy rewrite php5 ].each do |module|
apache_module module do
  enable true
end
=end
bash "copy dorsetwest image" do
        user "root"
        code <<-EOH
                aws s3 cp s3://cjo-content/dorsetwest.tgz /opt/dorsetwest.tgz
                sudo tar xzf /opt/dorsetwest.tgz --directory=/opt/content/
        EOH
        not_if do ::File.exists?("/opt/content/dorsetwest") end
end

apache_site "cabinjohnorganizing.com" do
  enable true
end
apache_site "andredsweald.org" do
  enable true
end
apache_site "dorsetwest.com" do
  enable true
end
