include_recipe "apache2"

cookbook_file "/etc/apache2/sites-available/cabinjohnorganizing.com" do
        source "/sites-available/cabinjohnorganizing.com"
        action :create
end

remote_directory "/opt/content/cabinjohnorganizing" do
        source "html"
end

apache_site "cabinjohnorganizing.com" do
  enable true
end
