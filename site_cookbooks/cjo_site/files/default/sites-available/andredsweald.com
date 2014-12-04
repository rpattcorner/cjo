NameVirtualHost *
<VirtualHost *>
	ProxyRequests Off
	ProxyPreserveHost On
	<Proxy *>
	    	Order deny,allow
    		Allow from all
	</Proxy>

	ProxyPass / http://www.andredsweald.com:8080/
	ProxyPassReverse / http://www.andredsweald.com:8080/
	<Location />
    		Order allow,deny
    		Allow from all
	</Location>

	ServerAdmin webmaster@andredsweald.org
	ServerName andredsweald.com
	ServerAlias andredsweald.com *.andredsweald.com
	DocumentRoot /opt/content/andredsweald
	<Directory />
		Options FollowSymLinks
		AllowOverride None
	</Directory>
	<Directory /opt/content/andredsweald/>
		Options FollowSymLinks MultiViews
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

	ErrorLog /var/log/apache2/error.log

	# Possible values include: debug, info, notice, warn, error, crit,
	# alert, emerg.
	LogLevel warn

	CustomLog /var/log/apache2/aw.log combined
	ServerSignature On

    Alias /doc/ "/usr/share/doc/"
    <Directory "/usr/share/doc/">
        Options Indexes MultiViews FollowSymLinks
        AllowOverride None
        Order deny,allow
        Deny from all
        Allow from 127.0.0.0/255.0.0.0 ::1/128
    </Directory>

</VirtualHost>
