class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validates :event, presence: true

  validates :user, uniqueness: { scope: :event_id }, if: -> { user.present? }
  validates :user_email, uniqueness: { scope: :event_id }, presence: true,
    format: { with: URI::MailTo::EMAIL_REGEXP }, unless: -> { user.present? }

  validates :user_name, presence: true, unless: -> { user.present? }

  validate :email_registered, unless: -> { user.present? }
  validate :is_owner, if: -> { user.present? }

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
      errors.add(:user, I18n.t("controllers.subscriptions.errors.owner"))
    end
  end

  def email_registered
    if User.find_by(email: user_email).present?
      errors.add(:user_email, I18n.t("controllers.subscriptions.errors.email_registered"))
    end
  end
end
