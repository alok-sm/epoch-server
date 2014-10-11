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
  		post.code = entry.summary
  		post.photo = entry.summary.scan(/<img.*?src=\".*?\".*?\/>/)[0].scan(/src=\".*?\"/)[0].slice(5..-2)

  		post.category = category
  		post.time = "5m"
  		post.save
  		
  	end
  	render :json => "Success"


  end
end
