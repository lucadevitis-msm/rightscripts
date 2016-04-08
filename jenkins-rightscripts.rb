#
# ---
# run:
#   on:
#     deployments:
#       - ...
#     tags:
#       - ...
#   just_one: true|false
#   in_parallel: true|false
#   scripts:
#     -
#       from_repo:
#         host: ...
#         name: ...
#         ref: ...
#         file: ...
#       interpreter: ...
#       as:
#         user: ...
#         group: ...
#       args:
#         - ...
#         - ...
run = YAML.load(conf_file)['run']

@deployments = client.deployments.index
deployments = @deployments.select {|d| run['on']['deployments'].include? d.show.name}
@scripts = client.right_scripts.index
scripts.select {|s| s.show.name == 'generic.clone.and.run'}[0]
resources = deployments.map {|d| d.server_arrays.index + d.servers.index}.flatten
resources.each do |resource|
  tags = client.tags.by_resource(resource_hrefs: [resource.href])[0].tags
  if tags.hash == run['on']['tags'].hash
    run['scripts'].each do |script|
    end
  end
end
