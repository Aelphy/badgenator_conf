Badgenator::Application.routes.draw do
  match 'contacts' => 'welcome#contacts', :as => :contacts

  #ceты
  resources :archive, :controller => :badge_sets
  match 'archive/page/:page' => 'badge_sets#index', :via => :get

  #бэйджи
  resources :badge_set, :controller => :badges, :path => "archive" do 
    resources :badges do
      collection do
        get 'page/:page', :action => :index
      end
    end
  end 
   
  root :to => 'welcome#index'
end
