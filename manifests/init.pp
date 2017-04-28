application consul_cluster (
  $datacenter,
) {
  consul_cluster::head {
    datacenter => $datacenter,
    export     => Consulhead["node-${name}"],
  }
  consul_cluster::node {
    consume => Consulhead["node-${name}"],
  }
}
