# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

get 'facturacion', :to => 'facturation#index'

put 'facturacion/update_project_assigned_user_total_bill', :to => 'facturation#update_project_assigned_user_total_bill'