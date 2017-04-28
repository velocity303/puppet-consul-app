application consul_cluster (
  $datacenter,
) {

  $consul_count = collect_component_titles($nodes, Consul_cluster::Node)

  consul_cluster::head { "${name}-head":
    datacenter => $datacenter,
    export     => Consulhead["head-${name}"],
  }

  $consul_count.each |$j| {
  consul_cluster::node { $j:
    consume => Consulhead["head-${name}"],
  }

}

}
