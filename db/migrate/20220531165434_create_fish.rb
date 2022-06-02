class CreateFish < ActiveRecord::Migration[5.2]
  def change
    create_table :fish do |t|
      t.string :title
      t.text :body
      t.integer :fins
      t.string :school

      t.timestamps
    end
  end
end
