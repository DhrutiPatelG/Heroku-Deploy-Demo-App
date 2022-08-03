# frozen_string_literal: true

set :output, "log/cron.log"

# runs every last day of month at 8am. Updates free_coffee rewards
every '0 8 28-31 * *' do
  rake 'free_coffee:free_coffee_reward_at_end_of_month'
end

# runs every last day of month at 10am. Updates free_coffee rewards
every '0 10 28-31 * *' do
  rake 'free_movie_tickets:free_movie_tickets'
end

# runs everyday at 12 am. Points expire every year
every 1.day, at: '12:00 AM' do
  rake 'update_points:set_points_at_end_of_year'
end

# runs every first of the month at 9 am
every '0 9 1 * *' do
  rake 'birthday_reward:reward_user_on_birthday'
end

# runs every calendar quarterly at 11 pm i.e. on last day of every 3 months at 11 pm.
every '0 23 28-31 */3 *' do
  rake 'quaterly_rewards:bonus_points_to_user'
end
