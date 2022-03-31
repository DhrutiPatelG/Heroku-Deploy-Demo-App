# frozen_string_literal: true

set :output, "log/cron.log"

# runs every last day of month at 8am. Updates free_coffee rewards
every '0 8 1 * *' do
  rake 'free_coffee:free_coffee_reward_at_end_of_month', environment: 'development'
end

# runs every last day of month at 10am. Updates free_coffee rewards
every '0 10 28-31 * *' do
  rake 'free_movie_tickets:free_movie_tickets'
end
