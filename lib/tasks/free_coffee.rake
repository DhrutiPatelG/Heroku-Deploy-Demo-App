namespace :free_coffee do
  task free_coffee_reward_at_end_of_month: :environment do

    # reward users with free coffee if 100 points are accumulated in a calendar month.
    User.includes(:transactions).where(transactions:
      {created_at: Date.today.beginning_of_month..Date.today.end_of_month}
    ).find_each(batch_size: 1000) do |user|

      # Calculate points of the transaction that has been created in a month and reward accordingly
      # for calculating points, currency of user and transactions are taken into consideration.
      points = user.calculate_reward_points

      # if total points are > 100, user gets free coffe reward.
      if points > 100
        user.free_coffee_reward = true
        user.free_coffee_reward_collected_at = DateTime.now
        user.save!
      end
    end
  end
end
