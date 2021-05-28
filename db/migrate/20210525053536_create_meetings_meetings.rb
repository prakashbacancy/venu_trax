class CreateMeetingsMeetings < ActiveRecord::Migration[6.1]
  def change
    create_table :meetings_meetings do |t|
      t.string :title
      t.references :meetingable, polymorphic: true
      t.references :user, foreign_key: true
      t.string :google_event_id, default: ''
      t.string :location
      t.date :date
      t.time :start_time
      t.time :end_time
      t.string :duration # In Case requirement changes
      t.text :description
      t.text :team_note
      t.timestamps
    end
  end
end
