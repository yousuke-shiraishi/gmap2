set :output, 'log/crontab.log'
set :environment, :production
every 1.day, :at => '8:00 am' do
  rake "delete:old_records"
end
