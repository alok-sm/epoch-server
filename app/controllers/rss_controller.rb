class RssController < ApplicationController
  def extract
  	category = params[:category]
  	url = params[:url]
  	feeds = Feedjira::Feed.fetch_and_parse url
  	entries = feeds.entries.first(5)
  	foto = ''
  	entries.each do |entry|
  		post = Article.new
  		post.title = entry.title
      if(entry.content.nil?)
        post.code = entry.summary
      else
        post.code = entry.content
      end
  		pic = entry.summary.scan(/<img.*?src=\".*?\".*?\/>/)[0]
  		if(pic.nil?) 
  			pic = 'null'
  		else
  			pic = pic.scan(/src=\".*?\"/)[0].slice(5..-2)
  		end
  		post.photo = pic
  		post.category = category
  		post.time = "5m"
  		post.save
  		
  	end
  	render :json => "Success"


  end
end
