Rails.application.routes.draw do
  root 'welcome#index'
  get '/megaball', to: "welcome#megaball"
  get '/cash4life', to: "welcome#cash4life"
  get '/match6', to: "welcome#match6"
  get '/cash5', to: "welcome#cash5"
  get '/treasurehunt', to: "welcome#treasurehunt"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


end
