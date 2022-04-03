class SavedCarsController < ApplicationController
    before_action :authenticate_user!
    def save_car
        user_id = current_user.id
        car_exist = SavedCar.where(user_id: user_id, car_id: params[:id])
        save_car = SavedCar.new(user_id: user_id, car_id: params[:id])

        respond_to do |format|
            format.html do
                if car_exist.empty?
                    if save_car.save
                        flash[:success] = 'Car saved successfully'
                        redirect_to favorite_car_url                                       
                    else                     
                        flash.now[:success] = 'Car can not be saved'
                        redirect_to car_details_url
                    end
                else
                    flash[:success] = 'Car is already saved'
                    redirect_to car_details_url
                end
            end
        end

    end

    def favorite_car
        user_id = current_user.id
        favs = SavedCar.where(user_id: user_id )
        
        i = 0
        find_car = Array.new()
        find_seller = Array.new()
        find_seller_rating = Array.new()
        if !favs.empty?
            favs.each do |f|
                car = Car.find(f.car_id)
                find_car.insert(i, car)
                seller = User.find(car.user_id)
                find_seller.insert(i, seller)
                user_ratings = Rating.where(seller_id: car.user_id).sum(:rating)
                totalRater = Rating.select(:id).where(seller_id: car.user_id).count
                if totalRater != 0
                    averageRating = user_ratings.to_f/totalRater.to_f
                  else
                    averageRating = 0.0
                  end
                user_rating  = Rating.where(seller_id: car.user_id)
                find_seller_rating.insert(i, averageRating.round)

                i=i+1

            end
        end
          
        respond_to do |format|
            format.html { render :saved_car, locals: {find_car: find_car, find_seller: find_seller.uniq, find_seller_rating: find_seller_rating }}
        end
    end

end 
