module Activities
  module ActsAsDoer

    def self.included(base)
      base.extend DoerMethods
      base.class_eval do
        include ActivityLib
      end
    end  

    module DoerMethods
      def acts_as_doer
        has_many :activities, :as => :doer, :dependent => :nullify

        unless included_modules.include? InstanceMethods
          extend  ClassMethods
          include InstanceMethods          
        end      
      end
    end
    module ClassMethods

      def all_activities
        # Activity.find_all
      end

    end #ClassMethods

    module InstanceMethods

      def add_action(options ={})
        target = options[:target]
        activity = Activity.create!(:target => target, :doer => self, :text => options[:text])
      end

      def actions(options = {})
        Activity.for_doer(self)
      end

      def targets(options = {})
        self.activities.targets.uniq!
      end

      def acting_on?(target)
        Activity.find(:first, :conditions => ["doer_id = ? AND doer_type = ? AND target_id = ? AND target_type = ?", self.id, parent_class_name(self), target.id, parent_class_name(target)])
      end
      
      def follower_actions(options = {})
        follows = self.follows
        follow_ids = follows.collect {|c| c.followable.id}
        Activity.for_follows(follow_ids,parent_class_name(follows[0].followable))
      end

      def following_actions(options = {})
        followings = self.followings
        following_ids = followings.collect {|c| c.follower.id}
        Activity.for_follows(following_ids,parent_class_name(followings[0].follower))
      end

    end #InstanceMethods

  end #ActsAsDoer

end #Activities