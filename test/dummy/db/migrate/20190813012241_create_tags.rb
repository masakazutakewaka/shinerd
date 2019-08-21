class CreateTags < ActiveRecord::Migration[6.0]
  def change
    create_table :tags do |t|
      t.string :name
      t.integer :count
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end