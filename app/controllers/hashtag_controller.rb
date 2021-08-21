require 'json'
require_relative '../models/hashtag.rb'

class HashtagController
    def trending
        hashtag = Hashtag.new
        hashtag.trending.to_json
    end
end
