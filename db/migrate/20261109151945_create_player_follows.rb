class CreatePlayerFollows < ActiveRecord::Migration[8.1]
  def change
    create_table :player_follows do |t|
      t.references :fan, null: false, foreign_key: true
      t.references :player, null: false, foreign_key: true

      t.timestamps
    end
  end
end
