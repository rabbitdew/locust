class rabbitdew_locust (
  $rabbitdew_locust_hostrole = "worker",
  $rabbitdew_locust_master   = "locust01",
  ){
  # UID 1000 is the one used to run the command in the dockerhub image 
  # Create that user on the host so that we can more easily
  # those processes at the host-layer.
  group { 'locust':
    ensure  => present,
    gid     => 1000,
  }
  user { 'locust':
    ensure  => present,
    uid     => 1000,
    gid     => 1000,
    system  => true,
    shell   => '/sbin/nologin',
  }
  file { '/usr/local/bin/locust_workers_start.sh':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template('rabbitdew_locust/locust_workers_start.sh.erb'),
  }
  file { '/usr/local/bin/locust_workers_destroy.sh':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    source  => 'puppet:///modules/rabbitdew_locust/locust_workers_destroy.sh',
  }
  file { '/var/log/locust_csv':
    ensure  => directory,
    owner   => 'locust',
    group   => 'locust',
    mode    => '0755',
  }
  if ( $rabbitdew_locust_hostrole == 'master' ) {
    file { '/usr/local/bin/locust_master_start.sh':
      ensure  => present,
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      source  => 'puppet:///modules/rabbitdew_locust/locust_master_start.sh',
    }
  }
  file { '/usr/local/bin/locust-files':
    ensure  => directory,
  }
  file { '/usr/local/bin/locust-files/stress_simple-get.py':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    source  => 'puppet:///modules/rabbitdew_locust/stress_simple-get.py',
  }
  file { '/usr/local/bin/locust-files/stress_email-signups.py':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    source  => 'puppet:///modules/rabbitdew_locust/stress_email-signups.py',
  }
}
