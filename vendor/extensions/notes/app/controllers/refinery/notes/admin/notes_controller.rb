  
module Refinery
  module Notes
    module Admin
      class NotesController < ::Refinery::AdminController
          rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
        
          crudify 'refinery/notes/note',
                :title_attribute => 'name', :xhr_paging => true
                
          def find_all_notes
            @notes = Note.where(:user_id => current_refinery_user.id)
          end 
          
          def edit           
              @note = Note.find(params[:id])
              if(@note == nil || (@note != nil && @note.user_id != current_refinery_user.id))
                redirect_to refinery.notes_admin_notes_path
              end
          end 
            
          protected
            
          def record_not_found  
            flash[:notice] = "Record not found: " + params[:id]    
            redirect_to refinery.notes_admin_notes_path
          end
      end
    end
  end
end
