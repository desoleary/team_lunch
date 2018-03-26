class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :first_name, null: false
      t.string :last_name
      t.references :team, index: true, foreign_key: true
      t.references :dietary_restriction, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
