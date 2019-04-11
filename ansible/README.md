Ansible playbooks to provision the naps-emergency-response-project to OpenShift.

Prerequisites:
* `oc` client on the PATH
* logged in into the cluster with a user with cluster admin rights

#### Installing the NAPS demo

To provision all the components:
```
$ ansible-playbook playbooks/install
```
Notes:
* The user currently logged in must have cluster admin rights
* The user `developer` is given project admin ights to the  projects created by the playbook: `naps-emergency-response`, `tools-naps`.
  If you want to substitute the `developer` user by another user, set the `cluster_provisioner` parameter when running the install playbook:
  ```
  $ ansible-playbook playbooks/install -e cluster_provisioner=user1
  ```

To uninstall:
```
$ ansible-playbook playbooks/install -e ACTION=uninstall
```