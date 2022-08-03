class CreateUserRewards < ActiveRecord::Migration[6.0]
  def change
    create_table :user_rewards do |t|
      t.boolean :reward_status
      t.references :user, null: false, foreign_key: true
      t.references :reward, null: false, foreign_key: true

      t.timestamps
    end
  end
end
