def run param

end

def process_id_for process_name
  `ps aux | grep '#{process_name}' | grep -v grep`.split(' ')[1].to_s
end

process_id = process_id_for 'helpcentre-poc'
puts "Killing process #{process_id}"
`kill -9 #{process_id}` if process_id != ''

load "#{File.dirname(__FILE__)}/config.ru"
puts 'running now....'
Helpcentre.run! :port => 4567