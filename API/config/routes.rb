Tacker::Application.routes.draw do
  namespace :v1 do |v1|

    get 'auth/signin'
    post 'auth/signin'

    resources :blocked_users do
      collection do
        post 'create'
        post 'destroy'
      end
    end

    resources :friendships do
      collection do
        post 'ask_to_create'
        post 'create'
        post 'destroy'
        post 'update'
      end
    end

    #post 'me/update_account'
    #post 'me/update_password'
    resources :me do
      collection do
        get 'friendships'
        get 'recent_friendships'
        get 'requests'
        get 'trackers'
        post 'update_account'
        post 'update_name'
        post 'update_password'
        post 'update_push_device'
      end
    end

    resources :signout do
      collection do
        post 'index'
      end
    end

    resources :requests do
      collection do
        post 'approve'
        post 'create'
        post 'destroy'
      end
    end

    resources :trackers do
      collection do
        get 'trackers_with_user'
        post 'destroy'
        post 'see'
      end
    end

    resources :users do
      collection do
        get 'find_from_contacts'
        post 'create'
      end
    end

  end
end
