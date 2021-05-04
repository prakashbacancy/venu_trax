class CreateSimulations < ActiveRecord::Migration[6.1]
  def change
    create_table :simulations do |t|
      t.integer :event_per_year
      t.bigint :daily_seating_capacity
      t.float :annual_attendance_per
      t.float :visitor_wifi_login
      t.float :cost_lp_impression
      t.integer :event_usage_impression
      t.float :cpm_impression_cost
      t.integer :contract_month

      t.float :annual_seating_capacity
      t.float :avg_attendance_event
      t.float :avg_attendance_annual_event
      t.float :wifi_lp_per_day_login
      t.float :wifi_lp_annual_login
      t.float :lp_rev_per_day_total
      t.float :lp_rev_annual_total
      t.float :user_impression_per_day
      t.float :user_impression_annual
      t.float :cpm_impression_per_day
      t.float :cpm_impression_annual
      t.float :wifi_annual_total
      t.timestamps
    end
  end
end
