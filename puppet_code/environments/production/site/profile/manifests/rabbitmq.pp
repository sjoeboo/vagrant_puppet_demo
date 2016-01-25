class profile::rabbitmq inherits profile::base {
  include erlang
  include rabbitmq
  include rabbitmq::repo::rhel

  $rabbitmq_users=hiera('rabbitmq_users',{})
  create_resources(rabbitmq_user, $rabbitmq_users)

  $rabbitmq_vhosts=hiera('rabbitmq_vhosts',{})
  create_resources(rabbitmq_vhost, $rabbitmq_vhosts)

  $rabbitmq_user_permissions=hiera('rabbitmq_user_permissions',{})
  create_resources(rabbitmq_user_permissions, $rabbitmq_user_permissions)
}
