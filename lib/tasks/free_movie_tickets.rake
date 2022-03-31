namespace :free_movie_tickets do
  task free_movie_tickets: :environment do
    User.all.each do |user|
      first_transaction_created_at = user.transactions.order(created_at: :asc).first.created_at
      if (60.days.ago.beginning_of_day..Date.today.end_of_day).include? first_transaction_created_at
        if user.transactions.where(currency_id: user.currency.id).sum(:amount).to_f > 1000
          user.movie_tickets_reward = true
          user.movie_tickets_reward_collected_at = DateTime.now
          user.save!
        end
      end
    end
  end
end
