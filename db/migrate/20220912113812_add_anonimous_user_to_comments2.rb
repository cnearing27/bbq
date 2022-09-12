class AddAnonimousUserToComments2 < ActiveRecord::Migration[7.0]
  def change
    change_table :comments do |t|
      t.change :user_id, :integer
    end
  end
end
