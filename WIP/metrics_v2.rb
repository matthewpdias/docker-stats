require 'docker'
require 'json'


file = File.open("sample.txt", "w")

trap('INT') do
  puts 'Cleaning up..'
  file.close()
  puts 'Exiting...'
  exit
end

running_containers = Docker::Container.all()

loop do
  running_containers.each do |container|

	#container/stat meta-info
	id = container.id
	stats = container.stats
	timestamp = stats["read"]

	#collect statistics

	#cpu percentage = total precpu total usage / precpu system cpu usage
	docker_cpu_diff = stats["cpu_stats"]["cpu_usage"]["total_usage"] - stats["precpu_stats"]["cpu_usage"]["total_usage"]
	local_cpu_diff = stats["cpu_stats"]["system_cpu_usage"] - stats["precpu_stats"]["system_cpu_usage"]
	#container_cpu_usage = docker_cpu_diff.to_f / local_cpu_diff * 100

	current_memory = stats["memory_stats"]["usage"]
	memory_limit = stats["memory_stats"]["limit"]

	puts "id: " + id
	#memory_percentage used = current_memory.to_f / memory_limit
  end
  exit
end





#Name, Memory Used, CPU Used, Time
