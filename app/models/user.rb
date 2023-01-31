class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  # Constants
  DEFAULT_CONFIRMATION_EMAIL_SENT_TIMES = 3

  # Scopes
  scope :unconfirmed, -> { where(confirmed_at: nil).where('confirmation_email_sent_times <= ?', DEFAULT_CONFIRMATION_EMAIL_SENT_TIMES) }

  # Callbacks
  after_create :update_confirmation_email_sent_times

  def name
    "#{self.first_name} #{self.last_name}"
  end

  def self.send_reminder_email(users)
    users.each do |user|
      user.send_confirmation_instructions
      user.update(confirmation_email_sent_times: user.confirmation_email_sent_times + 1)
    end
  end

  private

  def update_confirmation_email_sent_times
    self.update(confirmation_email_sent_times: 1)
  end
end
