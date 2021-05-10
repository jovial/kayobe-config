resource "local_file" "kayobe-proxy" {
  for_each = toset( ["${path.module}/../etc/kayobe/environments/aio/inventory/group_vars/all/proxy",
                     "${path.module}/../etc/kayobe/environments/aio/kolla/inventory/group_vars/all/proxy",
                     # kolla inventory generation for seed doesn't seem to support group_vars
                     "${path.module}/../etc/kayobe/environments/aio/kolla/inventory/host_vars/seed0/proxy"] )
  content  = templatefile("${path.module}/templates/proxy.yml.tpl",
                          {
                            "access_ip_v4": openstack_compute_instance_v2.kayobe-aio.access_ip_v4
                          },
                          )
  filename = each.value
  file_permission = "0660"
}
