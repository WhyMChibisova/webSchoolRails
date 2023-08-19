class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.string :name
      t.string :language
      t.string :level
      t.integer :quantity_of_students
      t.integer :age_of_group
      t.float :price
      t.text :description

      t.timestamps
    end
  end
end
