module Refinery
  module Notes
    class NotesController < ::ApplicationController
      
      
      before_filter :find_all_notes
      before_filter :find_page
      before_filter :find_all_tags

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @note in the line below:
        present(@page)
      end

      def show
        @note = Note.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @note in the line below:
        present(@page)
      end

      def tagged
         @tag = ActsAsTaggableOn::Tag.find(params[:tag_id])
         @tag_name = @tag.name
         @notes = Note.where(:user_id => current_refinery_user.id).tagged_with(@tag_name).page(params[:page])
      end

    protected

      def find_all_notes
        @notes = Note.where(:user_id => current_refinery_user.id).paginate(:page => params[:page]).order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/notes").first
      end
      
      def find_all_tags
        @tags = Note.where(:user_id => current_refinery_user.id).tag_counts_on(:tags)
      end

    end
  end
end
