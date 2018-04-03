#!/usr/bin/ruby
require 'yaml'
require 'tty-table'


@content = YAML.load_file(File.join(__dir__, '/status.yaml'))

service = gets.chomp
if service.include?('@')
  service = service.split('@').first
end

if service == "all" or service == ""
serviceTable = TTY::Table.new header: ['Server', 'Service', 'Status', 'Last check', 'Response time']
serviceRows  = Array.new
  @content.each do |serverName, services|
    services.each do |serviceName, serviceData|
      serviceTable << [
        serverName,
        serviceName,
        serviceData['status'],
        "#{(Time.now - serviceData['lastCheck']).floor} sec ago",
        "#{serviceData['responseTime']} ms"
      ]
  end
end
puts serviceTable.render(:ascii)
else
serviceTable = TTY::Table.new header: ['Server', 'Service', 'Status', 'Last check', 'Response time']
serviceRows  = Array.new
  @content.each do |serverName, services|
    services.each do |serviceName, serviceData|
      next unless serverName.downcase == service.downcase
      serviceTable << [
        serverName,
        serviceName,
        serviceData['status'],
        "#{(Time.now - serviceData['lastCheck']).floor} sec ago",
        "#{serviceData['responseTime']} ms"
      ]
  end
end
puts serviceTable.render(:ascii)
end
