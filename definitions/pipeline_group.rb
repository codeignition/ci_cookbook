define :pipeline_group do

  app_name = params[:name]
  framework = params[:framework]
  pipeline_template =  params[:pipeline_template] || "#{framework}/pipeline_template.yml.erb"
  cookbook_name = params[:cookbook_name] || 'ci'
  go_server_url = params[:go_server_url] || 'localhost:8153'
  git_url = params[:git_url]

  template "tmp/#{app_name}_pipeline_template.yml" do
    source pipeline_template
    cookbook cookbook_name
    variables app_name: app_name,
              go_server_url: go_server_url,
              git_url: git_url
  end

  bash "setup #{app_name} pipeline" do
    cwd "/tmp"
    code <<-EOH
    gocd_pipeline #{app_name}_pipeline_template.yml
    EOH
  end

end

