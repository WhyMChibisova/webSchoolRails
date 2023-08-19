class CreateCoursesUsersJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_join_table :courses, :users do |t|
      t.index :course_id
      t.index :user_id
    end
  end
end
