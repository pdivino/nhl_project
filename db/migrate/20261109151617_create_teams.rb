class CreateTeams < ActiveRecord::Migration[8.1]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :abbrev
      t.integer :wins
      t.integer :losses
      t.integer :ot_losses
      t.integer :points
      t.string :logo_url
      t.references :division, null: false, foreign_key: true

      t.timestamps
    end
  end
end
