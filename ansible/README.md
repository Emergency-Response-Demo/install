# Emergency Response - Installer

A set of Ansible roles and playbooks that install the Emergency Response
project.

Prerequisites:
* access to an OpenShift 4.2 cluster.   
Note: OpenShift 3.11 is not longer supported.   
Note: previous versions of the Emergency Response Demo required Integreatly to be installed prior to installing the demo. This is not longer required.
* `oc` client on the PATH
* logged in into the cluster with a user with cluster admin rights
* A MapBox access token. See https://docs.mapbox.com/help/how-mapbox-works/access-tokens/ for more details.

## Installing

There are two ways to deploy the demo: from source code or from pre-built images. Building from source code is useful when doing development work on the Emergency Response project. When provisioning to actually use the demo, building from images is recommended as it is a lot faster to provision.

Create a copy of the inventory template file:
```
$ cp inventories/inventory.template inventories/inventory
```

Replace the sample MapBox access token in the inventory file (`map_token`) with a real MapBox token.

Choose the deployment method by providing the desired value for the `deploy_from` entry in the inventory file. Accepted values are `image` and `source`.

To provision all the components:
```
$ ansible-playbook -i inventories/inventory playbooks/install.yml
```

This will take about 15 minutes to complete when deploying from images.

By default, the `developer` user will be given project admin permissions for
the Emergency Response projects. To give these permissions to another user,
override the `cluster_provisioner` entry in the inventory.

Individual components can be installed by the executing the corresponding playbook. For example, to install only the Kafka cluster:
```
$ ansible-playbook -i inventories/inventory playbooks/openshift_strimzi_operator.yml
$ ansible-playbook -i inventories/inventory playbooks/openshift_kafka_cluster.yml
$ ansible-playbook -i inventories/inventory playbooks/openshift_kafka_topics.yml
```

## Reset the demo

Resetting the demo will scale down all the services, re-deploy the Kafka cluster, datagrid and database, and scale the services back up.

To reset:
```
$ ansible-playbook -i inventories/inventory playbooks/install.yml -e ACTION=reset
```

## Uninstalling

To uninstall:
```
$ ansible-playbook -i inventories/inventory playbooks/install.yml -e ACTION=uninstall
```
