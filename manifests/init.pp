application consul_cluster (
  $datacenter,
) {

  consul_cluster::head { $name:
    datacenter => $datacenter,
    export     => Consulhead["node-${name}"],
  }

  consul_cluster::node { $name:
    consume => Consulhead["node-${name}"],
  }

}
