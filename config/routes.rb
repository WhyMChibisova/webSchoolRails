Rails.application.routes.draw do
root 'home#index'

namespace :admin do
  resources :users
end

get 'profile', to: 'users#show'
get 'profile/edit', to: 'users#edit'
delete 'profile', to: 'users#destroy'

resources :courses, :events, :books, :users
resource :session, only: %i[new create destroy]

get 'book/sort', to: 'books#sort'
get 'course/sort', to: 'courses#sort'
get 'event/sort', to: 'events#sort'
get 'admin/sort', to: 'admin/users#sort'

resources :courses_users, only: %i[show destroy]

resources :translations, only: %i[index]
post 'translations/translate', as: :translate

resources :tests, only: %i[index]

end
