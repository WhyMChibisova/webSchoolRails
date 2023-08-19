class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :name
      t.string :author
      t.string :language
      t.string :level
      t.text :description

      t.timestamps
    end
  end
end
