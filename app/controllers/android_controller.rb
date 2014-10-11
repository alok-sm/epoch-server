class AndroidController < ApplicationController
  def fetch
  	reply = ''
  	category_list = params[:categories]
  	category_list = category_list.split(',')
  	titles = []
  	fotos = []
  	cats = []
  	min = params[:min]
  	category_list.each do |category|
  		posts = Article.where(:category=>category,:time=>min)
  		if(posts==nil)
  			next
  		end
 
  			
  		
  			posts.each do |post|
          
  				titles.push(post.title)
  				fotos.push(post.photo)
  				cats.push(post.category)
  			end
  		

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
end
