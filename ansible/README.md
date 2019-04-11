Ansible playbooks to provision the naps-emergency-response-project to OpenShift.

Prerequisites:
* You need to be logged in into the Openshift cluster with access to the project namespace
* `oc` client on the PATH

#### Global variables:
* namespace: defaults to `naps-emergency-response`

#### Postgresql

To provision: 
```
$ ansible-playbook playbooks/postgresql.yml
```

To unprovision:
```
$ ansible-playbook playbooks/postgresql -e ACTION=uninstall"
```

Variables:
* postgresql user: defaults to `naps`
* postgresql password: defaults to `naps`
* postgresql database: defaults to `naps_emergency_response`

#### PgAdmin4

PgAdmin4 is a web-based administration and development tool for Postgresql.

PgAdmin4 is deployed in the `Tools` namespace.

To provision: 
```
$ ansible-playbook playbooks/pgadmin4.yml
```

To unprovision:
```
$ ansible-playbook playbooks/pgadmin4 -e ACTION=uninstall"
```

#### Responder service

The playbook creates the following artifacts:
* buildconfig for s2i build and binary builds
* serviceaccount and rolebinding (cluster view access)
* imagestream for images created by the build
* configmap for application configuration properties
* deploymentconfig, service and route for the application

To provision:
```
$ ansible-playbook playbooks/responder-service.yml
```

To unprovision:
```
$ ansible-playbook playbooks/responder-service -e ACTION=uninstall
```

To start a binary build (without using the fabric8 maven plugin):
```
$ mvn clean package
$ oc start-build responder-service-s2i --target/responder-service-0.0.1-SNAPSHOT.jar
```

#### Incident service

The playbook creates the following artifacts:
* buildconfig for s2i build and binary builds
* serviceaccount and rolebinding (cluster view access)
* imagestream for images created by the build
* configmap for application configuration properties
* deploymentconfig, service and route for the application

To provision:
```
$ ansible-playbook playbooks/incident-service.yml
```

To unprovision:
```
$ ansible-playbook playbooks/incident-service -e ACTION=uninstall
```

To start a binary build (without using the fabric8 maven plugin):
```
$ mvn clean package
$ oc start-build incident-service-s2i --target/incident-service-0.0.1-SNAPSHOT.jar
```
