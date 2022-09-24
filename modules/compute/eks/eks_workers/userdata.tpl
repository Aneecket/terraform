#!/bin/bash

${before_cluster_joining_userdata}
/etc/eks/bootstrap.sh '${cluster_name}' --kubelet-extra-args '${kubelet_extra_args}'
${after_cluster_joining_userdata}