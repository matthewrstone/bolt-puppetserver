plan puppetize::configure_puppet_agent(
  String[0] $puppetserver,
  String[0] $vm_name,
  TargetSpec $targets
){

  # Setup target for more Bolt or Puppet agent config
  apply_prep($target)

  # Create a symlink if none exists.
  run_command('sudo ln -s /opt/puppetlabs/bin/puppet /usr/bin/puppet', $targets)

  # TODO: Fix this. In our test env we have no public hostname for the Puppet server.
  # The inventory shows an IP for the name and I will map it to `puppet` 
  # in the hosts file.
  run_command("echo '${puppetserver}     puppet' >> /etc/hosts", $targets)

  # Change the certname for the agent
  run_command("sudo puppet config set --section agent certname ${vm_name}", $targets)

  # Set the puppet server address.
  run_command('sudo puppet config set server puppet', $targets)

  # Fire away
  $puppet_run = run_command('sudo puppet agent -t', $targets, { '_catch_errors' => true })
  $exit_code = $puppet_run.to_data[0]['value']['exit_code']
  case $exit_code {
    0: {return 'The run succeeded with no changes or failures; the system was already in the desired state.'}
    1: {return 'The run failed, or wasn\'t attempted due to another run already in progress.'}
    2: {return 'The run succeeded, and some resources were changed.'}
    4: {return 'The run succeeded, and some resources failed.'}
    6: {return 'The run succeeded, and included both changes and failures.'}
    default: {fail('unknown error code')}
  }

}