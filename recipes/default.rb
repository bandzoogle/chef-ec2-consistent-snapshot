#
# Cookbook Name:: ec2-consistent-snapshot
# Recipe:: default
#

#include_recipe "yum::epel"
include_recipe "xfs"

%w{
  perl-Net-Amazon-EC2 perl-File-Slurp perl-DBI perl-DBD-MySQL perl-Net-SSLeay perl-IO-Socket-SSL perl-Time-HiRes
  perl-DateTime perl-Params-Validate
}.each do |p|
  package p
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
