class FiguresController < ApplicationController

  get '/figures' do
    erb :'/figures/index'
  end

  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'/figures/new'
  end

  post '/figures' do
    @figure = Figure.create(params["figure"])
    if !params["title"]["name"].empty?
      @figure.titles << Title.create(name: params["title"]["name"])
    end
    if !params["landmark"]["name"].empty?
      @figure.landmarks << Landmark.create(name: params["landmark"]["name"])
    end
    @figure.save
    redirect "figures/#{@figure.id}"
  end

  get '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    erb :'/figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find_by_id(params[:id])
    erb :'/figures/edit'
  end

  patch '/figures/:id' do
    if !params[:figure].keys.include?("title_ids")
      params[:figure]["title_ids"] = []
    end
    if !params[:figure].keys.include?("landmarks_ids")
      params[:figure]["landmarks_ids"] = []
    end
    @figure = Figure.find(params[:id])
    @figure.update(params["figure"])
    if !params["title"]["name"].empty?
      @figure.titles << Title.create(name: params["title"]["name"])
    end
    if !params["landmark"]["name"].empty?
      @figure.landmarks << Landmark.create(name: params["landmark"]["name"])
    end
    redirect "owners/#{@owner.id}"
  end
end
