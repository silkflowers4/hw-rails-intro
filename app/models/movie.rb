class Movie < ActiveRecord::Base
  def self.check_ratings(par)

    if par[:ratings].nil? || par[:ratings] == []
        return []
    end
    
    return par[:ratings].keys
end

  def self.get_movies(ratings, order)

    if ratings != [] and order
      res = Movie.where(rating: ratings).order(order)
    elsif ratings != []
      res = Movie.where(rating: ratings)
    elsif order
      res = Movie.all.order(order)
    else
      res = Movie.all
    end

    return res

  end

  def self.all_ratings
    ['G','PG','PG-13','R']
  end
  def self.with_ratings(ratings_list)
    # if ratings_list is an array such as ['G', 'PG', 'R'], retrieve all
    #  movies with those ratings
    return Movie.all 
    # if ratings_list is nil, retrieve ALL movies
  end

  end

  def self.sorted(order)
    return Movie.all.order(order)
  end

  
end