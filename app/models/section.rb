class Section < ActiveRecord::Base
    has_and_belongs_to_many :instructors
    belongs_to :course, :primary_key => :ecid, :foreign_key => :ecid
end
