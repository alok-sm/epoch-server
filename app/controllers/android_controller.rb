class AndroidController < ApplicationController
  def fetch
  	reply = ''
  	category_list = params[:categories]
  	category_list = category_list.split(',')
  	titles = []
  	fotos = []
  	cats = []
    ids = []
  	min = params[:min]
  	category_list.each do |category|
  		posts = Article.where(:category=>category,:time=>min)
  		if(posts==nil)
  			next
  		end
 
  			
  		
  			posts.each do |post|
          ids.push(post.id.to_s)
  				titles.push(post.title)
  				fotos.push(post.photo)
  				cats.push(post.category)
  			end
  		

  	end
    ids.each do |title|
      reply += title+','
    end
    if(reply != '')
      reply[-1] = ';'
    end
  	titles.each do |title|
  		reply += title+','
  	end
  	if(reply != '')
  		reply[-1] = ';'
  	end
  	fotos.each do |title|
  		reply += title+','
  	end
  	if(reply != '')
  		reply[-1] = ';'
  	end
  	cats.each do |title|
  		reply += title+','
  	end
  	if(reply != '')
  		reply[-1] = ''
  	end
  	render :json => reply
  end
  def renderview
    id = params[:id]
    a = Article.find_by_id(id)
    render :inline => a.code
  end
end
