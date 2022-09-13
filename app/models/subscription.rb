class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validates :event, presence: true

  validates :user, uniqueness: { scope: :event_id }, if: -> { user.present? }
  validates :user_email, uniqueness: true, unless: -> { user.present? }, presence: true,
    format: { with: URI::MailTo::EMAIL_REGEXP }, unless: -> { user.present? }

  validates :user_name, presence: true, unless: -> { user.present? }

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
end
