Refinery::Core::Engine.routes.append do
  # Frontend routes
  namespace :mailinglists do
    resources :subscribers, :path => '', :only => [:create]
  end

  # Admin routes
  namespace :mailinglists, :path => '' do
    namespace :admin, :path => 'refinery/mailinglists' do
      resources :subscribers, :path => ''# , :only => [:index, :update, :destroy]
    end
  end
end