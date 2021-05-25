class ChangeColumnTypeForAnnualAttendancePer < ActiveRecord::Migration[6.1]
  def change
  	change_column :simulations, :annual_attendance_per, :bigint
  	change_column :simulations, :visitor_wifi_login, :bigint
  end
end
