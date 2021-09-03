!/bin/sh

# Create the fact directory if it doesn't exist
if [ ! -d /etc/puppetlabs/facter/facts.d ]; then
  mkdir -p /etc/puppetlabs/facter/facts.d;
fi

echo $PT_facts >> /etc/puppetlabs/facter/facts.d/${PT_filename}