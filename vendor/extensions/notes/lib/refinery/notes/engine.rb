module Refinery
  module Notes
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Notes

      engine_name :refinery_notes

      initializer "register refinerycms_notes plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "notes"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.notes_admin_notes_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/notes/note',
            :title => 'name'
          }
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Notes)
      end
    end
  end
end
