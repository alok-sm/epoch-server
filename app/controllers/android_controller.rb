class AndroidController < ApplicationController
  def stats
    stats = UserStat.where(:user_email => params[:email])
    count = {}
    points = []
    stats.each do |s|
      points << s.points
      if(count[s.category].nil?)
        count[s.category] = 1
      else
        count[s.category]+=1
      end
    end
    @pie = Gchart.pie(
      :title => 'Most viewed categories',
      :line_colors => '00a1e2',
      :labels => count.keys, 
      :data => count.values, 
      :size => '400x250'
    )

    @line = Gchart.line(
      :title => 'Self improvement over time',
      :data => points, 
      :size => '400x250', 
      :line_colors => '00a1e2',
      :axis_with_labels => 'y',
      :axis_labels => ['0|1|2|3|4|5|6|7|8|9|10']
    )
    @avg = (points.inject{ |sum, el| sum + el }.to_f / points.size).round(1)
    # render :json => line+"@"+pie+"@"+(avg.round(1)).to_s
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
    if(not params[:loc].nil?)
      loc = params[:loc]
      if(loc == 'work' )
        category_list.delete("fitness")
        category_list.delete("art")
       category_list.delete("health")
         end
    end

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
      reply += title+'$,'
    end
    if(reply != '')
      reply[-1] = '$;'
    end
  	titles.each do |title|
  		reply += title+'$,'
  	end
  	if(reply != '')
  		reply[-1] = '$;'
  	end
  	fotos.each do |title|
  		reply += title+'$,'
  	end
  	if(reply != '')
  		reply[-1] = '$;'
  	end
  	cats.each do |title|
  		reply += title+'$,'
  	end
  	if(reply != '')
  		reply[-1] = ''
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
