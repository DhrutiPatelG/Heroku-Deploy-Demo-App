namespace :quaterly_rewards do

  # credit 100 bonus points to users having transactions amount more than 2000 in last 3 months
  task bonus_points_to_user: :environment do

    User.includes(:transactions).where(
      transactions: {created_at: Date.today.months_since(-3).beginning_of_day..Date.today.end_of_day}
    ).find_each(batch_size: 1000) do |user|

      # ASSUMPTION: consider transactions with the same currency
      # that a user is registered with, exclude foreign transactions.
      if user.fetch_native_transactions.sum(:amount) > 2000
        user.points = user.points + 100
        user.save!
      end
    end
  end

end
