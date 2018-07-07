namespace :delete do
  desc '６０日たったGmapオブジェクトを削除する'
  task :old_records => :environment do
    Gmap.where("created_at < '#{60.days.ago}'").destroy_all
  end
end
