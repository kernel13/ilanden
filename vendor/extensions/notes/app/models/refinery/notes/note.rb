require 'acts-as-taggable-on'

module Refinery
  module Notes
    class Note < Refinery::Core::BaseModel
      self.table_name = 'refinery_notes'
      self.per_page = 10
      
      belongs_to :author, :class_name => 'Refinery::User', :foreign_key => :user_id, :readonly => true
      
      attr_accessible :name, :body, :user_id, :position, :tag_list

      acts_as_indexed :fields => [:name, :body]

      validates :name, :presence => true, :uniqueness => true
      
      acts_as_taggable

    end
  end
end
