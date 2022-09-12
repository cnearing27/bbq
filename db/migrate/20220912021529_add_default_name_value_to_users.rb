class AddDefaultNameValueToUsers < ActiveRecord::Migration[7.0]
  def change
    change_table :users do |t|
      t.change :name, :string, default: ""
    end
  end
end
