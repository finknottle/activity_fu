class Activity < ActiveRecord::Base

  named_scope :for_doer,    lambda { |*args| {:conditions => ["doer_id = ? AND doer_type = ?", args.first.id, (args.first.class.superclass.name == "User" ? args.first.class.superclass.name : args.first.class.name)], :order => "created_at DESC"} }
  named_scope :for_target, lambda { |*args| {:conditions => ["target_id = ? AND target_type = ?", args.first.id, args.first.class.name], :order => "created_at DESC"} }
  named_scope :recent,       lambda { |*args| {:conditions => ["created_at > ?", (args.first || 1.week.ago).to_s(:db)]} }
  named_scope :descending, lambda {|*args| {:order => "created_at DESC", :limit => args.first || 100}}
  named_scope :for_follows, lambda { |*args| {:conditions => ["doer_id in (?) AND doer_type = ?", args.first, args.second], :order => "created_at DESC"} }

  # NOTE: Activities belong to the "target" interface, and also to doer
  belongs_to :target, :polymorphic => true
  belongs_to :doer,    :polymorphic => true

  validates_uniqueness_of :target_id, :scope => [:target_type, :doer_id, :doer_type, :text]
  
end
