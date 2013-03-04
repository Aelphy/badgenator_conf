Badgenator::Application.routes.draw do
  match 'contacts' => 'welcome#contacts', :as => :contacts, :via => :get

  match 'archive/:id/print' => 'badge_sets#print', :via => :get, :as => :print_bs

  match '/archive/page/:page' => 'badge_sets#index', :via => :get    


  resources :badge_sets, :except => :show, :path => :archive do
    resources :badges do
      collection do
        match 'page/:page', :action => :index, :via => :get
      end
    end
  end 
   
  root :to => 'welcome#index'
  
  match '*path' => 'not_found#index'
end
