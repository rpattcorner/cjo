include_recipe "apache2"

cookbook_file "cabinjohnorganizing.com" do
	path: "/etc/apache2/sites-available/cabinjohnorganizing.com"
	action: create
end


apache_site "cabinjohnorganizing.com" do
  enable true
end