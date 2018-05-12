namespace :delete do
  desc '６０日たったGmapオブジェクトを削除する'
  task :old_records => :environment do
    Gmap.delete_all("created_at < '#{60.days.ago}'")
    end
end
