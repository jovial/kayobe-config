ansible_ssh_common_args: '-o ProxyCommand="ssh centos@${access_ip_v4} -W %h:%p"'
