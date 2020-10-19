# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :ledgers do
  	member do
  		get 'total'
  		get 'current_balance'
  	end
		resources :transactions
  end
end
