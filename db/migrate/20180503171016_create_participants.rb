class CreateParticipants < ActiveRecord::Migration[5.2]
  def change
    create_table :participants do |t|
      t.references :lottery, foreign_key: true
      t.string :user_name, null: false
      t.integer :result, null: false, default: 10

      t.timestamps
    end
  end
end
