# Create a new run stage to ensure certain modules are included first
stage { 'pre':
    before => Stage['main']
}

# Add the baseconfig module to the new 'pre' run stage
class { 'baseconfig':
    stage => 'pre'
}

# Set defaults for file ownership/permissions
File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
}

node default {
  # All boxes get the base config
  include baseconfig
}

# Install Apache/PHP/Mariadb client
node 'lamp-app-vagrant' {
    include lamp::app
}

# Install MariaDB server
node 'lamp-db-vagrant' {
    include lamp::db
}
