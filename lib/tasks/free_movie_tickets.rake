namespace :free_movie_tickets do

  # reward movie tickets to the user having transaction sum >1000 in 60 days since their first transaction
  task free_movie_tickets: :environment do
    User.joins(:transactions).
      find_each(batch_size: 1000) do |user|

      # ASSUMPTION: consider transactions with the same currency
      # that a user is registered with, exclude foreign transactions.

        first_transaction_created_at = user.transactions.order(created_at: :asc).first&.created_at
        if (60.days.ago.beginning_of_day..Date.today.end_of_day).include? first_transaction_created_at &&
            user.fetch_native_transactions.sum(:amount).to_f > 1000

          user.movie_tickets_reward = true
          user.movie_tickets_reward_collected_at = DateTime.now
          user.save!
        end
    end
  end
end
