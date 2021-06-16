class RemoveDefaultValueFromBusiness < ActiveRecord::Migration[6.1]
  def change
    change_column_default :businesses, :annual_revenue, nil
    change_column_default :businesses, :no_of_employee, nil
  end
end
