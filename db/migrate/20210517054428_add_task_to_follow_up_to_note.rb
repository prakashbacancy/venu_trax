class AddTaskToFollowUpToNote < ActiveRecord::Migration[6.1]
  def change
    add_column :notes, :task_to_follow_up, :boolean, default: false
  end
end
