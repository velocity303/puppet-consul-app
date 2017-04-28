define consul_cluster::node (
  $datacenter,
  $head_ip,
) {
  ensure_packages('unzip')

    class { '::consul':
      config_hash => {
        'bootstrap_expect' => 3,
        'data_dir'         => '/opt/consul',
        'datacenter'       => $::location,
        'log_level'        => 'INFO',
        'node_name'        => $::fqdn,
        'server'           => true,
        'bind_addr'        => $bind_addr,
        'start_join'       => [$consul_head_ip],
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
Consul_cluster::Node consumes Consulhead {
  datacenter  => $datacenter,
  head_ip     => $head_ip,
}
