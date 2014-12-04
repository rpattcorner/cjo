include_recipe "apache2"

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

bash "copy dorsetwest image" do
	user "root"
	code <--EOH
		aws s3 cp s3://cjo-content/dorsetwest.tgz /opt/dorsetwest.tgz
		cd /opt/content
		tar xzf ../dorsetwest.tgz
		ln -s drupal_20141130a drupal
	EOH
	not_if do ::File.exists?("/opt/content/dorsetwest") end

apache_site "cabinjohnorganizing.com" do
  enable true
end
apache_site "andredsweald.org" do
  enable true
end
apache_site "dorsetwest.com" do
  enable true
end