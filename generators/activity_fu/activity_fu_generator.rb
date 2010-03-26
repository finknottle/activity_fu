class ActivityFuGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      # m.directory "lib"
      m.migration_template 'migration.rb', 'db/migrate', :migration_file_name => 'activity_fu_migration'
    end
  end
end
