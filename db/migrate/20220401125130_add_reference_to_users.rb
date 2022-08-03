class AddReferenceToUsers < ActiveRecord::Migration[6.0]
  def up
    add_reference :users, :reward
  end
  
  def down
    remove_reference :users, :reward
  end
end
