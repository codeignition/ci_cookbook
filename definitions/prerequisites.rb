define :pipeline_prerequisites do 
  include_recipe 'python::pip'
  python_pip 'gomatic'
  python_pip 'pyyaml'
  package 'git'

  cookbook_file "/usr/bin/gocd_pipeline" do
    source 'gocd/pipeline.py'
    mode 0777
  end

end

