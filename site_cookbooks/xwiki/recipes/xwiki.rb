chef_gem "aws-sdk"


powershell_script "Allow 8080 traffic" do
	code <<-EOH
		New-NetFirewallRule -DisplayName "Permit Tomcat traffic" -Direction Inbound -Protocol TCP -LocalPort 8080 -Action Allow
	EOH
	guard_interpreter :powershell_script
	not_if { WinFW::Helper.firewall_rule_enabled?("Permit Tomcat traffic") }
end


# Fix xwiki to start 
cookbook_file "c:\\windows\\start_xwiki.ps1" do
    source "start_xwiki.ps1"
end
   
=begin
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