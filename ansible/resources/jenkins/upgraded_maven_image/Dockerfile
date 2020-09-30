# buildah bud -f Dockerfile -t quay.io/emergencyresponsedemo/jenkins_slave_upgraded_mvn:1.9 .

FROM quay.io/openshift/origin-jenkins-agent-base:4.1.0

ENV MAVEN_VERSION=3.6.3 \
    JAVA_HOME=/etc/alternatives/java_sdk \
    JAVA_VERSION=java-11 \
    JAVA_TOOLS_OPTS="-Dsun.zip.disableMemoryMapping=true" \
    BASH_ENV=/usr/local/bin/scl_enable \
    ENV=/usr/local/bin/scl_enable \
    PROMPT_COMMAND=". /usr/local/bin/scl_enable" \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    MAVEN_OPTS="-Duser.home=$HOME"

# Install Maven
RUN INSTALL_PKGS="java-11-openjdk-devel.x86_64" && \
    curl https://raw.githubusercontent.com/cloudrouter/centos-repo/master/CentOS-Base.repo -o /etc/yum.repos.d/CentOS-Base.repo && \
    curl http://mirror.centos.org/centos-7/7/os/x86_64/RPM-GPG-KEY-CentOS-7 -o /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7 && \
    DISABLES="--disablerepo=rhel-server-extras --disablerepo=rhel-server --disablerepo=rhel-fast-datapath --disablerepo=rhel-server-optional --disablerepo=rhel-server-ose --disablerepo=rhel-server-rhscl" && \
    yum $DISABLES install -y $INSTALL_PKGS && \
    rpm -V java-11-openjdk-devel.x86_64 && \
    yum clean all -y && \
    mkdir -p $HOME/.m2 

# When bash is started non-interactively, to run a shell script, for example it
# looks for this variable and source the content of this file. This will enable
# the SCL for all scripts without need to do 'scl enable'.
ADD contrib/bin/scl_enable /usr/local/bin/scl_enable
ADD contrib/bin/configure-agent /usr/local/bin/configure-agent
ADD contrib/bin/run-jnlp-client /usr/local/bin/run-jnlp-client
ADD ./contrib/settings.xml $HOME/.m2/


RUN curl http://apache.mirrors.hoobly.com/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz -o $HOME/apache-maven-$MAVEN_VERSION-bin.tar.gz && \
    tar -zxvf $HOME/apache-maven-$MAVEN_VERSION-bin.tar.gz -C $HOME && \
    ln -s $HOME/apache-maven-$MAVEN_VERSION/bin/mvn /usr/bin/mvn 

RUN chown -R 1001:0 $HOME && \
    chmod -R g+rw $HOME

USER 1001
