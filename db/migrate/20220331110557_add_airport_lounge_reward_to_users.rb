class AddAirportLoungeRewardToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :airport_lounge_reward, :boolean, default: false
  end
end
