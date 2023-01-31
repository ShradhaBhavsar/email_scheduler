namespace :user_email do
  task :send_reminder => :environment do
    users = User.unconfirmed.where("DATE(confirmed_at) = ?", [Date.today - 2.days, Date.today - 7.days])
    User.send_reminder_email(users)
  end
end
