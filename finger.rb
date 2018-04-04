#!/usr/bin/ruby
# frozen_string_literal: true

require 'yaml'
require 'tty-table'

@content = YAML.load_file(File.join(__dir__, '/status.yaml'))

service = gets.chomp
service = service.split('@').first if service.include?('@')

service_table = TTY::Table.new header: ['Server', 'Service', 'Status', 'Last check', 'Response time']
@content.each do |server_name, services|
  services.each do |service_name, service_data|
    next unless serverName.downcase.include?(service.downcase) ||
                (service == 'all') || (service == '')
    service_table << [
      server_name,
      service_name,
      service_data['status'],
      "#{(Time.now - service_data['lastCheck']).floor} sec ago",
      "#{service_data['responseTime']} ms"
    ]
  end
end
puts service_table.render(:ascii)
