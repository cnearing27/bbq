class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validates :event, presence: true

  with_options if: -> { user.present? } do
    validates :user, uniqueness: { scope: :event_id }
    validate :is_owner
  end

  with_options unless: -> { user.present? } do
    validates :user_email, uniqueness: { scope: :event_id },
      presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :user_name, presence: true
    validate :email_registered
  end

  def user_name
    if user.present?
     user.name
    else
     super
    end
  end

  def user_email
    if user.present?
      user.email
    else
      super
    end
  end

  private

  def is_owner
    if user == event.user
      errors.add(:user, :owner)
    end
  end

  def email_registered
    if User.find_by(email: user_email).present?
      errors.add(:user_email, :email_registered)
    end
  end
end
