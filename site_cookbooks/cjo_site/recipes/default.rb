include_recipe "apache2"

cookbook_file "/etc/apache2/sites-available/cabinjohnorganizing.co" do
        source "/sites-available/cabinjohnorganizing.com"
        action :create
end


apache_site "cabinjohnorganizing.com" do
  enable true
end
