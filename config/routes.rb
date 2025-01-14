Rails.application.routes.draw do
  resources :horarios do
    collection do
      get :horarios_por_dia
    end
  end
  resources :curricular_components
  get 'pages/home'
  resources :teachers do
    member do
      get :horarios_do_professor
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "pages#home"
end
