class AddSubscribingForUsersWithoutSignIn < ActiveRecord::Migration[7.0]
  def change
    change_table :subscriptions do |t|
      t.change :user_id, :integer, null: true
    end
  end
end
