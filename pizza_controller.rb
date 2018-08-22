require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative ('./models/pizza_order')
also_reload('./models')

#HOME
get '/' do
  erb :home
end

#INDEX
get '/pizza-orders' do
  @orders = PizzaOrder.all
  erb :index
end

#NEW
get '/pizza-orders/new' do
  erb :new
end

#SHOW
get '/pizza-orders/:id' do
  @name = PizzaOrder.find(params[:id]).pretty_name
  @topping = PizzaOrder.find(params[:id]).topping
  @quantity = PizzaOrder.find(params[:id]).quantity
  erb :show
end

#CREATE
post '/pizza-orders' do
  order = PizzaOrder.new(params)
  order.save
  erb :success
end

#EDIT
get '/pizza-orders/:id/edit' do
  @order = PizzaOrder.find(params[:id].to_i)
  erb :edit
end

#UPDATE
post '/pizza-orders/:id' do
  order = PizzaOrder.new(params)
  order.update
  erb :success
end

#DELETE
post '/pizza-orders/:id/delete' do
  order = PizzaOrder.find(params[:id])
  order.delete
  redirect to '/pizza-orders'
end
