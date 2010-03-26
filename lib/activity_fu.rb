# ActivityFu
require 'acts_as_target'
require 'acts_as_doer'
# require 'has_points'
require 'models/activity.rb'

ActiveRecord::Base.send(:include, Activities::ActsAsTarget)
ActiveRecord::Base.send(:include, Activities::ActsAsDoer)
# ActiveRecord::Base.send(:include, Activity::ActivityFu::Points)
# RAILS_DEFAULT_LOGGER.info "** activity_fu: initialized properly."
