# Dockerfile for Elasticsearch using Fedora base image.
#
# Version: 0.1

# Using Docker Fedora base image.
FROM fedora:20

MAINTAINER Anurag Patel apatel@redhat.com

# Update Fedora image
RUN yum -y update

# Install OpenJDK 1.8
RUN yum install -y java-1.8.0-openjdk 

# Add Elasticsearch GPG key
RUN curl http://packages.elasticsearch.org/GPG-KEY-elasticsearch > /tmp/GPG-KEY-elasticsearch
RUN rpm --import /tmp/GPG-KEY-elasticsearch
RUN rm /tmp/GPG-KEY-elasticsearch

# Install ELasticsearch RPM directly from upstream
RUN yum install -y https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-0.90.11.noarch.rpm

# Comment out MAX_OPEN_FILES
RUN sed -i 's/MAX_OPEN_FILES=/# MAX_OPEN_FILES=/g' /etc/sysconfig/elasticsearch

# Open necessary Elasticsearch ports
EXPOSE 9200
EXPOSE 9300

# Define an entry point.
ENTRYPOINT ["/usr/share/elasticsearch/bin/elasticsearch"]
CMD ["-f"]

# TODO: Run Elasticsearch as elasticsearch user, instead of the default root user.
#USER elasticsearch
