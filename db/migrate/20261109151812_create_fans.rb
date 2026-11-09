class CreateFans < ActiveRecord::Migration[8.1]
  def change
    create_table :fans do |t|
      t.string :name
      t.string :email
      t.string :city

      t.timestamps
    end
  end
end
