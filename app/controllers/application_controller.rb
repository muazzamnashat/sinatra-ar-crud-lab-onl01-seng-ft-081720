
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/articles/new' do
    erb :new
  end

  post '/articles' do
    @article= Article.create(params)
    redirect "/articles/#{@article.id}"
  end

  get '/articles/:id' do
    @id= Article.find_by_id(params[:id])
    erb :show 
  end

  get '/' do
  end

  get '/articles' do
    @articles= Article.all
    erb :index
  end

 

  get '/articles/:id/edit' do
    @articles= Article.all
    @article= Article.find_by_id(params[:id])
    erb :edit
  end

  patch '/articles/:id' do
    @article=Article.find_by_id(params[:id])
    params.delete("_method")
   if @article.update(params)
      redirect "/articles/#{@article.id}"
   else
      redirect "/articles/new"
   end
  end

  delete '/articles/:id/delete' do
    @article =Article.find_by_id(params[:id])
    @article.destroy
    redirect "/articles"
  end
end
