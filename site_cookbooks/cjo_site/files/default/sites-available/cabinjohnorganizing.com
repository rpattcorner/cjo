<VirtualHost *>
	ServerAdmin cjomgt@dorsetwest.com
       ServerName cabinjohnorganizing.com
        ServerAlias cabinjohnorganizing.com *.cabinjohnorganizing.com
	
	DocumentRoot /opt/content/cabinjohnorganizing
	<Directory />
		Options FollowSymLinks
		AllowOverride None
	</Directory>
	<Directory /opt/content/cabinjohnorganizing/>
		Options Indexes FollowSymLinks MultiViews
		AllowOverride None
		Order allow,deny
		allow from all
		# Uncomment this directive is you want to see apache2's
		# default start page (in /apache2-default) when you go to /
		#RedirectMatch ^/$ /apache2-default/
	</Directory>

	ScriptAlias /cgi-bin/ /usr/lib/cgi-bin/
	<Directory "/usr/lib/cgi-bin">
		AllowOverride None
		Options +ExecCGI -MultiViews +SymLinksIfOwnerMatch
		Order allow,deny
		Allow from all
	</Directory>

	ErrorLog /var/log/apache2/cabinjohnorganizing.log

	# Possible values include: debug, info, notice, warn, error, crit,
	# alert, emerg.
	LogLevel warn

	CustomLog /var/log/apache2/cabinjohnorganizing.log combined
	ServerSignature On
</VirtualHost>
