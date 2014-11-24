chef_gem "aws-sdk"


powershell_script "Allow 8080 traffic" do
    code <<-EOH
        New-NetFirewallRule -DisplayName "Permit Tomcat traffic" -Direction Inbound -Protocol TCP -LocalPort 8080 -Action Allow
    EOH
end
Chef::Log.info("=====================")
Chef::Log.info (Chef::Config[:file_cache_path])

powershell_script "Install XWiki" do
    code <<-EOH
        Copy-S3Object cjo-deploy XWikiEnterprise6.3.zip XWikiEnterprise6.3.zip
    EOH
end

windows_zipfile "c:/Program Files (x86)" do
    source "c:/XWikiEnterprise6.3.zip"
    action :unzip
    not_if {::File.exists?("c:/Program Files (x86)/XWiki Enterprise 6.3")}
end

# Fix xwiki to start 
cookbook_file "c:\\windows\\start_xwiki.ps1" do
    source "start_xwiki.ps1"
end


=begin
        ruby_block "Download from S3" do
            block do
              require 'aws-sdk'
                def download_file(file_name, file_object)
                    File.open(file_name, 'wb') do |file|
                        file_object.read() do |chunk|
                            file.write(chunk)
                        end
                    end
                end
                Dir.chdir(Chef::Config[:file_cache_path])
                s3 = AWS::S3.new()
                bucket = s3.buckets["cjo-deploy"]
                #Get ZIP
                file_object = bucket.objects["deploy/XWikiEnterprise63.tgz"]
                begin
                        puts "Downloading #{file_object.key}..."
                        download_file("AWSFile", file_object)
                    rescue
                            retry
                end
            end
            not_if {::File.exists?("#{Chef::Config[:file_cache_path]}\\AWSFile}")}
        end


# Fix xwiki to start 
cookbook_file "c:\\windows\\start_xwiki.ps1" do
    source "start_xwiki.ps1"
end
   

windows_task 'Restart Tomcat' do
    user "SYSTEM"
    command "powershell -Noninteractive -file c:\\windows\\start_xwiki.ps1"
    run_level :highest
    frequency :minute
    frequency_modifier 15
end

batch "change Tomcat service failure actions" do
    code <<-EOH
        sc failure Tomcat7 reset= 86400 actions= restart/5000
        sc failureflag Tomcat7 1
    EOH
end
=end