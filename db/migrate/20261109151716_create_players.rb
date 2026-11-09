class CreatePlayers < ActiveRecord::Migration[8.1]
  def change
    create_table :players do |t|
      t.integer :nhl_id
      t.string :first_name
      t.string :last_name
      t.integer :sweater_number
      t.string :position_code
      t.integer :height_inches
      t.integer :weight_pounds
      t.date :birth_date
      t.string :birth_country
      t.string :headshot_url
      t.references :team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
