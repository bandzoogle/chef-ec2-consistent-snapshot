#
# Cookbook Name:: ec2-consistent-snapshot
# Recipe:: default
#

#include_recipe "yum::epel"
include_recipe "xfs"

package "cpan"

%w{
  Module::Build Net::Amazon::EC2 File::Slurp DBI DBD::mysql Net::SSLeay IO::Socket::SSL Time::HiRes DateTime Params::Validate
}.each do |p|
  cpan_client p do
    action 'install'
    install_type 'cpan_module'
    user 'root'
    group 'root'
  end
end

remote_file "/usr/bin/ec2-consistent-snapshot" do
  source   "https://raw.github.com/alestic/ec2-consistent-snapshot/master/ec2-consistent-snapshot"
 # checksum "cd401d2e1aedf7c9d390e4bc50c08b7cebc631e709a9677c146800c06d42069a"
  owner    "root"
  group    "root"
  mode     0700
end

template "/root/.awssecret" do
  source "awssecret.erb"
  variables({
    access_key_id: node['ec2-consistent-snapshot']['aws_access_key_id'],
    secret_access_key: node['ec2-consistent-snapshot']['aws_secret_access_key']
  })
end
