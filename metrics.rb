names = `docker stats --no-stream --format "{{.Name}}"`

file = File.open("stats", "w")

file.puts "Name, Memory Used, CPU Used, Time"

trap('INT') do
  puts 'Cleaning up..'
  file.close()
  puts 'Exiting...'
  exit
end

while true
  sleep(1)
  data = `docker stats --no-stream --format "{{.Name}}\t{{.MemPerc}}\t{{.CPUPerc}}"`
  data = data.split("\n")

  for line in data do
    line = line.split
    file.puts (line[0] + ", " + line[1] + ", " + line[2] + ", " + Time.now.strftime("%H:%M:%S")).tr("%","")
  end
end
