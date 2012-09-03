Mastermind::Application.routes.draw do

  controller :game do
    get :index
    post :bet
    delete :reset
  end

  root :to => 'games#index'
end
