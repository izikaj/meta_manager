module MetaManager
  module Taggable
    extend ActiveSupport::Concern
    
    included do          
      has_many :meta_tags, :as => :taggable, :dependent => :destroy, :autosave => true
        
      accepts_nested_attributes_for :meta_tags, :reject_if => :all_blank, :allow_destroy => true
    end
    
    module InstanceMethods
    
      # Find meta tag by name or build new record
      def find_or_build_meta_tag(attr_name)
        key = normalize_meta_tag_name(attr_name)
        self.meta_tags.where(:name => key).first || self.meta_tags.build(:name => key)
      end
      
      # Save meta tags records into one hash
      def meta_tag(attr_name)
        key = normalize_meta_tag_name(attr_name)
        @meta_tag ||= {}
        @meta_tag[key] ||= find_or_build_meta_tag(key)
      end
      
      protected
      
        def normalize_meta_tag_name(value)
          key = value.to_s.downcase.strip
          key
        end
      
    end
  end
end