require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?

require './models'

enable :sessions

get '/' do
  @question = Question.order("RANDOM()").first
  erb :index
end

post '/question' do
  question = Answer.create(reply: params[:answer], user_id: session[:user], question_id: params[:question])
  redirect "/show"
end

get '/signin' do
  erb :sign_in
end

get '/signup' do
  erb :sign_up
end

post '/signin' do
  user=User.find_by(mail: params[:mail])
  if user && user.authenticate(params[:password])
    session[:user] = user.id
  end
  redirect '/'
end

post '/signup' do
  @user=User.create(mail: params[:mail], password: params[:password], password_confirmation:params[:password_confirmation], name: params[:name], sex: params[:sex], birthday: params[:birthday], job: params[:job])
  if @user.persisted?
    session[:user] = @user.id
  end
  redirect '/'
end

get '/signout' do
  session[:user] = nil
  redirect '/'
end

get "/show" do
  @answer = Answer.order("RANDOM()").first
  @question = Question.find_by(id: @answer.question_id)
  @user = User.find_by(id: @answer.user_id)
  erb :show
end