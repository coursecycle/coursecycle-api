class Section < ActiveRecord::Base
    has_and_belongs_to_many :instructors
    has_many :courses, :primary_key => :ecid, :foreign_key => :ecid
end
