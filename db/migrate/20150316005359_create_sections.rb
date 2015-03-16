class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.integer   :ecid
      t.string    :season
      t.string    :year
      t.datetime  :start
      t.datetime  :end
      t.string    :location
      t.string    :component
    end
  end
end
