# Puppet manifest to install nginx 

# Install Nginx package
package { 'nginx':
  ensure => 'installed',
}

# Configure Nginx
file { '/etc/nginx/sites-available/default':
  ensure  => 'file',
  content => "
    server {
      listen 80;
      server_name robinsonvictor.tech;

      location / {
        return 200 'Hello World!';
      }

      location /redirect_me {
        return 301 https://www.example.com; # Replace with the actual URL
      }
    }
  ",
}

# Create symbolic link for Nginx configuration
file { '/etc/nginx/sites-enabled/default':
  ensure => 'link',
  target => '/etc/nginx/sites-available/default',
}

# Restart Nginx service
service { 'nginx':
  ensure    => 'running',
  enable    => true,
  subscribe => File['/etc/nginx/sites-available/default'],
}

