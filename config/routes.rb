Rails.application.routes.draw do
  root 'welcome#index'
  get '/megaball', to: "welcome#megaball"
  get '/match6', to: "welcome#match6"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


end
