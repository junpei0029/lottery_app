class CreateLotteries < ActiveRecord::Migration[5.2]
  def change
    create_table :lotteries do |t|
      t.string :name, null: false
      t.integer :winning_number, null: false, default: 1
      t.text :detail
      t.integer :status, null: false, default: 10
      t.string :user_session, null: false
      t.timestamps
    end
  end
end
