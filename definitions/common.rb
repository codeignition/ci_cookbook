define :edit_pipeline_group do
  require 'yaml'
  app_name = params[:app_name]
  pipeline_name = params[:pipeline_name]
  stages = params[:stages]
  pipelines = params[:pipelines]
  edit_pipeline_template =  params[:pipeline_template] || "edit_pipeline_template.yml.erb"
  cookbook_name = params[:cookbook_name] || 'ci'
  go_server_url = params[:go_server_url] || 'localhost:8153'
  git_url = params[:git_url]
  

  if pipelines
    edit_pipeline_yml = { app_name => {'git_url' => git_url, "pipelines" => pipelines}, 'go_server_url' =>  go_server_url}.to_yaml
  elsif pipeline_name && stages
    edit_pipeline_yml = { app_name => {"pipelines" => { pipeline_name => stages } }, 'go_server_url' =>  go_server_url}.to_yaml
  end

  template "tmp/edit_#{app_name}_pipeline.yml" do
    source edit_pipeline_template
    cookbook cookbook_name
    variables  edit_pipeline_yml: edit_pipeline_yml
  end

  bash "modify  #{app_name}" do
    cwd "/tmp"
    code <<-EOH
    gocd_pipeline edit_#{app_name}_pipeline.yml
    EOH
  end

end

