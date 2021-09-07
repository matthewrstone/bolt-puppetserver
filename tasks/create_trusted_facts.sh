!/bin/sh
# Puppet Task Name: create_trusted_facts

# Create the fact directory if it doesn't exist
if [ ! -d /etc/puppetlabs/puppet ]; then
  mkdir -p /etc/puppetlabs/puppet;
fi

cat << EOF > /etc/puppetlabs/puppet/csr_attributes.yaml
---
extension_requests:
  pp_role: $PT_role
  pp_environment: $PT_env
EOF
