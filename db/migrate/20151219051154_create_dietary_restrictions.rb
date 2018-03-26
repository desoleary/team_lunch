class CreateDietaryRestrictions < ActiveRecord::Migration
  def change
    create_table :dietary_restrictions do |t|
      t.string :name, null: false
    end
  end
end
