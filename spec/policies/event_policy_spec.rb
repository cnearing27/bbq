require "rails_helper"

RSpec.describe EventPolicy do
  subject { EventPolicy }

  let(:user) { FactoryGirl.create(:user) }
  let(:user_context) { UserContext.new(user, {} , "") }

  let(:event) { FactoryGirl.create(:event, user: user) }
  let(:event_with_pincode) { FactoryGirl.create(:event, user: user, pincode: "123") }

  let(:another_user) { FactoryGirl.create(:user) }

  let(:another_user_context_empty) { UserContext.new(another_user, "", {}) }

  let(:another_user_context_right) { UserContext.new(another_user, "123", {}) }
  let(:another_user_context_right_cookies) { UserContext.new(another_user, "",
    { "events_#{event_with_pincode.id}_pincode" => "123" }) }

  let(:another_user_context_wrong) { UserContext.new(another_user, "111", {}) }
  let(:another_user_context_wrong_cookies) { UserContext.new(another_user, "",
    { "events_#{event_with_pincode.id}_pincode" => "111" }) }


  permissions :destroy?, :edit?, :update? do
    it "event owner can edit" do
      expect(subject).to permit(user_context, event)
    end

    it "another user can't edit" do
      expect(subject).not_to permit(another_user_context_empty, event)
    end
  end

  permissions :show? do
    context "when event doesn't have pincode" do
      it "event owner can look at it" do
        expect(subject).to permit(user_context, event)
      end

      it "another user can look at it" do
        expect(subject).to permit(another_user_context_empty, event)
      end
    end

    context "when event have pincode" do
      it "event owner can look at it" do
        expect(subject).to permit(user_context, event_with_pincode)
      end

      it "another user can look at it if cookies pincode is correct" do
        expect(subject).to permit(another_user_context_right_cookies, event_with_pincode)
      end

      it "another user can't look at it if cookies pincode is wrong" do
        expect(subject).not_to permit(another_user_context_wrong_cookies, event_with_pincode)
      end

      it "another user can look at it if taken pincode is correct" do
        expect(subject).to permit(another_user_context_right, event_with_pincode)
      end

      it "another user can't look at it if taken pincode is wrong" do
        expect(subject).not_to permit(another_user_context_wrong, event_with_pincode)
      end
    end
  end
end
