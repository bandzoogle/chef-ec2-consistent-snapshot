def whyrun_supported?
  true
end

use_inline_resources

action :create do
  template new_resource.path do
    source "wrapper.erb"
    cookbook "ec2-consistent-snapshot"

    variables({
      :region            => new_resource.region,
      :mysql_username    => new_resource.mysql_username,
      :freeze_filesystem => new_resource.freeze_filesystem,
      :volumes           => new_resource.volumes
    })
  end

  new_resource.updated_by_last_action(true)
end
