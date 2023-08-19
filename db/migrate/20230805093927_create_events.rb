class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :name
      t.date :date
      t.time :time
      t.string :place
      t.string :language
      t.text :description

      t.timestamps
    end
  end
end
