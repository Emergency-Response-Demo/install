Ansible playbooks to provision the naps-emergency-response-project OpenShift.

Prerequisites:
* You need to be logged in into the Openshift cluster with access to the project namespace
* `oc` client on the PATH

### Global vaiables:
* namespace: defaults to `naps-emergency-response`

### Postgresql

To provision: 
```
$ ansible-playbook playbooks/postgresql
```

To unprovision:
```
$ ansible-playbook playbooks/postgresql -e ACTION=uninstall"
```

Variables:
* postgresql user: defaults to `naps`
* postgresql password: defaults to `naps`
* postgresql database: defaults to `naps-emergency-response`