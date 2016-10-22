Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :posts
      resources :users
      post 'reports/by_author' => 'reports#by_author'
    end
  end
end
