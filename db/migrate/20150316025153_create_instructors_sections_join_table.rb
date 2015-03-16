class CreateInstructorsSectionsJoinTable < ActiveRecord::Migration
  def change
    create_table :instructors_sections, id: false do |t|
      t.integer :instructor_id
      t.integer :section_id
    end
    add_index :instructors_sections, :instructor_id
    add_index :instructors_sections, :section_id
  end
end
