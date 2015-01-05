pipeline_prerequisites

pipeline_group 'Project1' do
  git_url 'git://git_url'
  framework 'rails'
end
  
pipeline_group 'Project2' do
  git_url 'git://git_url'
  framework 'rails'
end

stages 'Project1' do
  app_name 'Project1'
  pipeline_name 'Project1_Pipeline'
  stages 'stage' => { 'Additional_specs' => {"steps" =>  ['ls -al', 'pwd', 'whois' ,'who am i', 'whoami']}}
end

pipelines 'Project1' do
  app_name 'Project1'
  git_url 'git://git_url'
  pipelines 'new_pipeline' => {'stage' => {'Additional_specs' => { 'steps' => ['ls -al', 'pwd', 'whois', 'who am i', 'whoami']}}}
end
