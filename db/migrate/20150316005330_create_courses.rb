class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string    :subject
      t.string    :code
      t.string    :title
      t.string    :description
      t.integer   :ecid
    end
  end
end
