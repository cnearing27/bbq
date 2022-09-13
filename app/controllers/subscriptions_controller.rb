class SubscriptionsController < ApplicationController
  before_action :set_event, only: [:create, :destroy]
  before_action :set_subscription, only: [:destroy]

  before_action :is_owner, only: [:create]
  before_action :email_registered, only: [:create]

  def create
    @new_subscription = @event.subscriptions.build(subscription_params)
    @new_subscription.user = current_user

    if @new_subscription.save
      redirect_to @event, notice: I18n.t("controllers.subscriptions.created")
    else
      render "events/show", alert: I18n.t("controllers.subscriptions.errors.create")
    end
  end

  def destroy
    message = { notice: I18n.t("controllers.subscriptions.destroyed") }
    if current_user_can_edit?(@subscription)
      @subscription.destroy
    else
      message = { alert: I18n.t("controllers.subscriptions.errors.destroy") }
    end

    redirect_to @event, message
  end

  private

  def set_subscription
    @subscription = @event.subscriptions.find(params[:id])
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def subscription_params
    params.fetch(:subscription, {}).permit(:user_email, :user_name)
  end

  def is_owner
    if current_user == @event.user
      redirect_to @event, alert: I18n.t("controllers.subscriptions.errors.owner")
    end
  end

  def email_registered
    if User.find_by(email: subscription_params[:user_email]).present?
      redirect_to @event, alert: I18n.t("controllers.subscriptions.errors.email_registered")
    end
  end
end
