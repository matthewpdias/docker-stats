import docker
import pprint

pp = pprint.PrettyPrinter(indent=1)

#get list of running containers
container_list = docker.from_env().containers.list()

try:
    while True:
        for container in container_list:

            stats = next(container.stats(decode=True))
            id = stats['id']
            timestamp = stats['read']

            pp.pprint(stats)

            docker_cpu_diff = stats['cpu_stats']['cpu_usage']['total_usage'] - stats['precpu_stats']['cpu_usage']['total_usage']
            local_cpu_diff = stats['cpu_stats']['system_cpu_usage'] - 0 #stats['precpu_stats']['system_cpu_usage']
            container_cpu_usage = float(docker_cpu_diff) / local_cpu_diff * 100

            current_memory = stats["memory_stats"]["usage"]
            memory_limit = stats["memory_stats"]["limit"]
except KeyboardInterrupt:
    pass
print "exiting"
