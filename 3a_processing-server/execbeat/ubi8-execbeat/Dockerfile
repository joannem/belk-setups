FROM registry.access.redhat.com/ubi8-minimal:8.4-212

COPY execbeat-3.3.0-x86_64.rpm /tmp/execbeat-3.3.0-x86_64.rpm
RUN  rpm --install /tmp/execbeat-3.3.0-x86_64.rpm

WORKDIR /usr/share/execbeat/
CMD execbeat.sh -c /usr/share/execbeat/execbeat.yml -e --strict.perms=false
