#!/usr/bin/env python
from gomatic import *
from sys import argv
import json
import yaml
import shlex

config = yaml.load(open(argv[1]))
app_names =  [i for i in config.keys() if i not in ['go_server_url']]
go_server_url = config["go_server_url"] if config.has_key("go_server_url") else "localhost:8153"

go_server = GoServer(HostRestClient(go_server_url))
for app_name in app_names:
  git_url = config[app_name]["git_url"] if config[app_name].has_key("git_url") else None
  for pipeline, value in config[app_name]["pipelines"].iteritems():
    pipeline = go_server \
      .ensure_pipeline_group(app_name) \
      .ensure_pipeline(pipeline)
    if value.has_key('env_vars'):
      pipeline.ensure_environment_variables(value['env_vars'])
      del value['env_vars']
    if git_url:
      pipeline.set_git_url(git_url)
    for stage, val in value.iteritems():
      stage = pipeline.ensure_stage(stage)
      if val.has_key('env_vars'):
        stage.ensure_environment_variables(val['env_vars'])
        del val['env_vars']
      for job, v in val.iteritems():
        j = stage.ensure_job(job)
        ipdb.set_trace()
        if v.has_key('env_vars'):
          j.ensure_environment_variables(v['env_vars'])
          del v['env_vars']
        for el in v['steps']:
          j.add_task(ExecTask(shlex.split(el)))
go_server.save_updated_config()

# ghus:
#  git_url: some git url 
#  pipeline_1:
#   stage1:
#     specs:
#       - step 1
#       - step 2
#     package:
#       - step 1
#       - step 2
#     staging_deploy:
#       - step 1
#       - step 2i
# go_server_url: localhost:8153
