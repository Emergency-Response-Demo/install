# Emergency Response - Installer

A set of Ansible roles and playbooks that install the Emergency Response
project in an OpenShift cluster.

Prerequisites:
* `oc` client on the PATH
* logged in into the cluster with a user with cluster admin rights
* A Registry Credentials Secret with access to `registry.redhat.io` named `imagestreamsecret` should exist in the `openshift` Namespace. See https://access.redhat.com/RegistryAuthentication for more details.
* A MapBox access token. See https://docs.mapbox.com/help/how-mapbox-works/access-tokens/ for more details.

## Installing

Create a copy of the inventory template file:
```
$ cp inventories/inventory.template inventories/inventory
```

Replace the sample MapBox access token in the inventory file (`map_token`) with a real MapBox token.

To provision all the components:
```
$ ansible-playbook -i inventories/inventory playbooks/install.yml
```

This will take about 30 minutes to complete.

By default, the `developer` user will be given project admin permissions for
the Emergency Response projects. To give these permissions to another user,
override the `cluster_provisioner` variable during provisioning.

Individual components can be installed by the executing the corresponding playbook. For example, to install only the Kafka cluster:
```
$ ansible-playbook playbooks/strimzi_operator.yml
$ ansible-playbook playbooks/kafka_cluster.yml
$ ansible-playbook playbooks/kafka_topics.yml
```

Apart from the `strimzi_operator` playbook, none of the playbooks require cluster admin rights.

## Uninstalling

To uninstall:
```
$ ansible-playbook playbooks/install.yml -e ACTION=uninstall
```
