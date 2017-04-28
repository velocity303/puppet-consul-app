define consul_cluster::head (
  $datacenter,
) {
  ensure_packages('unzip')
    class { '::consul':
      config_hash => {
        'bootstrap_expect' => 3,
        'data_dir'         => '/opt/consul',
        'datacenter'       => $datacenter,
        'log_level'        => 'INFO',
        'node_name'        => $::fqdn,
        'server'           => true,
        'bind_addr'        => $::ipaddress,
        'client_addr'      => '0.0.0.0',
        'ui_dir'           => '/opt/consul/ui',
      },
      require     => Package['unzip'],
    }

  firewall { '100 allow various consul tcp ports':
    dport  => [ 8300, 8301, 8302, 8400, 8500, 8600 ],
    proto  => tcp,
    action => accept,
  }
  firewall { '100 allow various consul udp ports':
    dport  => [ 8301, 8302, 8600 ],
    proto  => udp,
    action => accept,
  }

}
Consul_cluster::Head produces Consulhead {
  datacenter => $datacenter,
  head_ip    => $::ipaddress,
}

