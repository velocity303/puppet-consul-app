application consul_cluster (
  $datacenter,
) {

  $consul_count = collect_component_titles($nodes, Consul_cluster::Node)

  consul_cluster::head { "${name}":
    datacenter => $datacenter,
    export     => Consulhead["${name}"],
  }

  $consul_count.each |$j| {
  consul_cluster::node { $j:
    consume => Consulhead["${name}"],
  }

}

}
