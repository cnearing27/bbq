class NotifyPhotoJob < ApplicationJob
  queue_as :default

  def perform(photo)
    all_emails = (
      photo.event.subscriptions.map(&:user_email) + [photo.event.user.email] - [photo.user.email]
    ).uniq

    all_emails.each do |email|
      EventMailer.photo(photo, email).deliver_later
    end
  end
end
