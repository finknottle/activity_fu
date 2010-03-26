module Activities
  module ActsAsTarget

    def self.included(base)
      base.extend TargetMethods
      base.class_eval do
        include ActivityLib
      end
    end  

    module TargetMethods
      def acts_as_target
        has_many :activities, :as => :target, :dependent => :nullify

        unless included_modules.include? InstanceMethods
          extend  ClassMethods
          include InstanceMethods          
        end      
      end
    end

    module ClassMethods
      # find all the activities for a particular model type
      def all_activities
        # Activity.find_all
      end
      
    end

    module InstanceMethods

      def add_activity(options ={})
        doer = options[:doer]
        # target = options[:target]
        # activity = Activity.create!(:target => target, :doer => doer)
        activity = Activity.create!(:target => self, :doer => doer, :text => options[:text])
      end

      def activities(options = {})
        Activity.for_target(self)
      end

      def actors(options = {})
        self.activities.doers.uniq!
      end
      
      def acted_by?(doer)
        Activity.find(:first, :conditions => ["doer_id = ? AND doer_type = ? AND target_id = ? AND target_type = ?", doer.id, parent_class_name(doer), self.id, parent_class_name(self)])
      end

    end #InstanceMethods

  end #ActsAsTarget

end #Activities