class CreateInstructors < ActiveRecord::Migration
  def change
    create_table :instructors do |t|
      t.string  :name
      t.string  :first_name
      t.string  :middle_name
      t.string  :last_name
      t.string  :sunet
      t.string  :role
    end
  end
end
