Refinery::Core::Engine.routes.append do

  # Frontend routes
  namespace :notes do
    resources :notes, :path => '', :only => [:index, :show]
    get 'tagged/:tag_id(/:tag_name)' => 'notes#tagged', :as => 'tagged_notes'
  end

  # Admin routes
  namespace :notes, :path => '' do
    namespace :admin, :path => 'refinery' do
      resources :notes, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
