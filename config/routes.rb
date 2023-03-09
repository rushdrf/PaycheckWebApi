Rails.application.routes.draw do
  post '/api/v1/generatepaycheck', to: 'api#create'

  get '/api/v1/listemployeepaycheck', to: 'employee_salary_tabs#salary_compute'

end