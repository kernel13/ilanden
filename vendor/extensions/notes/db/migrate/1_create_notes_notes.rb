class CreateNotesNotes < ActiveRecord::Migration

  def up
    create_table :refinery_notes do |t|
      t.string :name
      t.text :body
      t.integer :user_id
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-notes"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/notes/notes"})
    end

    drop_table :refinery_notes

  end

end
