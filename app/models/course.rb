class Course < ActiveRecord::Base
    has_many :sections, :primary_key => :ecid, :foreign_key => :ecid
end
