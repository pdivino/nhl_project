class CreateTeamFollows < ActiveRecord::Migration[8.1]
  def change
    create_table :team_follows do |t|
      t.references :fan, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
