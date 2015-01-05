define :pipelines do

  app_name = params[:app_name]
  pipelines = params[:pipelines]

  edit_pipeline_template =  params[:pipeline_template]
  cookbook_name = params[:cookbook_name] 
  go_server_url = params[:go_server_url] 
  git_url = params[:git_url]
  edit_pipeline_group params[:name] do
    app_name app_name
    pipelines pipelines
    git_url git_url

    edit_pipeline_yml edit_pipeline_yml
    cookbook_name cookbook_name
    go_server_url go_server_url
  end
end

