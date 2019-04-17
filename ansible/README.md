Ansible playbooks to provision the naps-emergency-response-project to OpenShift.

Prerequisites:
* `oc` client on the PATH
* logged in into the cluster with a user with cluster admin rights
* A Registry Credentials Secret with access to `registry.redhat.io` named `imagestreamsecret` should exist in the `openshift` Namespace. See https://access.redhat.com/RegistryAuthentication for more details.

#### Installing the NAPS demo

To provision all the components:
```
$ ansible-playbook playbooks/install.yml
```
Notes:
* The user currently logged in must have cluster admin rights
* The user `developer` is given project admin ights to the  projects created by the playbook: `naps-emergency-response`, `tools-naps`.
  If you want to substitute the `developer` user by another user, set the `cluster_provisioner` parameter when running the install playbook:
  ```
  $ ansible-playbook playbooks/install.yml -e cluster_provisioner=user1
  ```

To uninstall:
```
$ ansible-playbook playbooks/install.yml -e ACTION=uninstall
```

Individual components can be installed by the executing the corresponding playbook. For example, to install only the Kafka cluster:
```
$ ansible-playbook playbooks/strimzi_operator.yml
$ ansible-playbook playbooks/kafka_cluster.yml
$ ansible-playbook playbooks/kafka_topics.yml
```

Apart from the `strimzi_operator` playbook, none of the playbooks require cluster admin rights.
