application consul_cluster (
  $datacenter,
) {
  consul_cluster::head {
    datacenter => $datacenter,
    export     => Consulhead["${name}"],
  }
  consul_cluster::node {
    consume => Consulhead["${name}"],
  }
}
