class AndroidController < ApplicationController
  def stats
    stats = UserStat.where(:user_email => params[:email])
    count = {}
    stats.each do |s|
      if(count[s.category].nil?)
        count[s.category] = 1
      else
        count[s.category]+=1
      end
    end
    pie = Gchart.pie(
      :line_colors => '00a1e2',
      :labels => count.keys, 
      :data => count.values, 
      :size => '500x300'
    )
    raise 'alok'
  end
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
    points = {
      'art'=>6,
      'education'=>10, 
      'fitness'=>9,
      'food'=>4,
      'literature'=>8,
      'movies'=>2,
      'music'=>5,
      'photography'=>7,
      'science'=>10,
      'sports'=>4,
      'technology'=>6,
      'television'=>1
    }
    a = Article.find_by_id(id)
    s = UserStat.new(
      :user_email => params[:user_email], 
      :points => points[a.category],
      :category => a.category
    ).save
    render :inline => a.code
  end
end
