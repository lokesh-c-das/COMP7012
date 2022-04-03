class DashboardsController < ApplicationController
  before_action :authenticate_user!
  
  def dashboard
    user_id = current_user.id
    your_cars = Car.where(user_id: user_id)
    sold_cars = Car.where(user_id: user_id, sold: 1).count
    bought_cars = Car.where(user_id: user_id, bought: 1).count
    most_recents = Car.limit(2).order('id desc')

    ## User Rating Calculation
    user_ratings = Rating.where(seller_id: user_id).sum(:rating)
    totalRater = Rating.select(:id).where(seller_id: user_id).count
    respond_to do |format|
      format.html do
        if totalRater != 0
          averageRating = user_ratings.to_f/totalRater.to_f
        else
          averageRating = 0.0
        end
        #flash[:success] = averageRating
        render :dashboard, locals: {your_cars: your_cars, most_recents: most_recents, sold_cars: sold_cars, bought_cars: bought_cars,user_rating: averageRating.round }
      end
    end
  end

end
