# Use an official Ubuntu base image
FROM ubuntu:22.04
# Update the package list
RUN apt-get update \
&& apt-get install -y python3 python3-pip \
&& apt-get clean && rm -rf /var/lib/apt/lists/*