require 'erb'

#load the template
template = File.read('./report_template.erb')
report = ERB.new(template, 0, "%<>")

#ruby magic, gets the full path to all non-hidden files in the stats directory
csv_list =  Dir.glob("stats/*").map(&File.method(:realpath))

#ensure there is data
if csv_list.empty?
  puts "No csv files available in stats directory.. \n try running metrics.rb first"
  exit 1
end

#kindly ask the user what they want to call their report
puts "Enter a filename to for your report"
fname = gets.chomp()

#generate and write the report to a file
file = File.open("reports/#{fname}.rmd", "w")
file.puts report.result
file.close

puts "Your report is available in reports/#{fname}.rmd"
exit 0
