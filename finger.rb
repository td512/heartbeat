#!/usr/bin/ruby
# frozen_string_literal: true

require 'yaml'
require 'tty-table'

@content = YAML.load_file(File.join(__dir__, '/status.yaml'))

service = gets.chomp
service = service.split('@').first if service.include?('@')

serviceTable = TTY::Table.new header: ['Server', 'Service', 'Status', 'Last check', 'Response time']
@content.each do |serverName, services|
  services.each do |serviceName, serviceData|
    next unless serverName.casecmp(service.downcase).zero? ||
                (service == 'all') || (service == '') || serverName.downcase.include?(service.downcase)
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
