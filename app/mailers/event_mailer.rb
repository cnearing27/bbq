class EventMailer < ApplicationMailer
  def subscription(event, subscription, app_link)
    @email = subscription.user_email
    @name = subscription.user_name
    @event = event
    @app_link = app_link

    mail to: event.user.email, subject: "Новая подписка на #{event.title}"
  end

  def comment(event, comment, email, app_link)
    @comment = comment
    @event = event
    @app_link = app_link

    mail to: email, subject: "Новый комментарий @ #{event.title}"
  end

  def photo(event, photo, email, app_link)
    @photo = photo
    @event = event
    @app_link = app_link

    mail to: email, subject: "Новая фотография @ #{event.title}"
  end
end
