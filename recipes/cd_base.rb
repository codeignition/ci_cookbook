#
# Cookbook Name:: ci
# Recipe:: server
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

if node[:ci_service] == 'gocd'
  include_recipe 'go::server'

  if node[:complete_with_agents]
    include_recipe 'go::agent'
  end
end


