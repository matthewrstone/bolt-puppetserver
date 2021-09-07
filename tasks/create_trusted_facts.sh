# Puppet Task Name: create_trusted_facts
# Create the puppet dir

if [ ! -d /etc/puppetlabs/puppet ]; then
  mkdir -p /etc/puppetlabs/puppet;
fi

cat << EOF > /etc/puppetlabs/puppet/csr_attributes.yaml
---
extension_requests:
  pp_role: $PT_role
  pp_environment: $PT_env
EOF
