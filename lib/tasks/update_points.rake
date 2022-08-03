namespace :update_points do
  task set_points_at_end_of_year: :environment do

    # Points expire after a year
    # runs everyday to set points to the origin for the user that are created a year ago.
    User.
      where(
        created_at: Date.today.last_year.beginning_of_day..Date.today.last_year.end_of_day
      ).update_all(
        points:0
      )
  end
end
