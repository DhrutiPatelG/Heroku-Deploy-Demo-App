namespace :birthday_reward do

  task reward_user_on_birthday: :environment do
    # Reward users during their birthday month
    User.
      where(
        birthdate: Date.today.at_beginning_of_month..Date.today.end_of_month
      ).update_all(
        birthday_reward: true,
        birthday_reward_collected_at: DateTime.now
      )
  end

end
