#!/usr/bin/ruby

#get the current timestamp
current = Time.now.strftime("%F-%H-%M")

#create a timestamped file in the stats directory and add headers
file = File.open("stats/#{current}.csv", "w")
file.puts "Name, Memory Used, CPU Used, Time"

#clean up the file descriptor and exit gracefully on user-interruption
trap('INT') do
  puts 'Cleaning up..'
  file.close()
  puts 'Exiting...'
  exit
end

#collect statistics from the `docker stats` command and write them
# => to the open file created above
while true
  sleep(1)
  data = `docker stats --no-stream --format "{{.Name}}\t{{.MemPerc}}\t{{.CPUPerc}}"`
  data = data.split("\n")

  for line in data do
    line = line.split
    file.puts (line[0] + ", " + line[1] + ", " + line[2] + ", " + Time.now.strftime("%H:%M:%S")).tr("%","")
  end
end
