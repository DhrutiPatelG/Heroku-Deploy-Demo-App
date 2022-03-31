namespace :free_coffee do
  task free_coffee_reward_at_end_of_month: :environment do
    User.all.each do |user|
      user.transactions.where(created_at: Date.today.last_month.beginning_of_month..Date.today.last_month.end_of_month).each do |transaction|
        points = user.currency == transaction.currency ? (transaction.amount/100).to_i * 10 : (transaction.amount/100).to_i * 20
      end

      # Reward if points a >100 in the current month
      if points > 100
        user.free_coffee_reward = true
        user.free_coffee_reward_collected_at = DateTime.now
        user.save!
      end

      # Reward if user's birthdate falls in the current month
      if (Date.today.at_beginning_of_month..Date.today.end_of_month).include?(user.birthdate)
        user.birthday_reward = true
        user.birthday_reward_collected_at = DateTime.now
        user.save!
      end
    end
  end
end
