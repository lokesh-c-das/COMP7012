
class CarsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :car_details]
    def index
        cars = Car.all
        respond_to do |format|
            format.html { render :index, locals: { cars: cars } }
        end
    end 
    
    def car_details
        car_id = params[:id]
        car = Car.find(car_id)
        seller_id = Car.select(:user_id).where(id: car_id)
        seller_id = seller_id[0].user_id
        user_ratings = Rating.where(seller_id: seller_id).sum(:rating)
        totalRater = Rating.select(:id).where(seller_id: seller_id).count
        seller = User.where(id: car.user_id).pluck :name

        ## this section for my ratings for seller
        if user_signed_in?
            myRatingToThisSeller = Rating.select(:rating).where(seller_id: seller_id, buyer_id: current_user.id)
        end
        
        respond_to do |format|
            format.html do
                if totalRater > 0
                    averageRating = user_ratings.to_f/totalRater.to_f
                else
                    averageRating = 0.0
                end
                if user_signed_in? and !myRatingToThisSeller[0].nil? and myRatingToThisSeller[0].rating > 0
                    myRatingToThisSeller = myRatingToThisSeller[0].rating
                else
                    myRatingToThisSeller = 0
                end
                render :index, locals:{car: car, seller: seller, user_rating: averageRating.round, myRating: myRatingToThisSeller}
            end
        end
    end

    def upload_car
        car_data = Car.new
        respond_to do |format|
            format.html { render :upload_car, locals: { car: {}, car_data: car_data } }
        end
    end

    def upload_car_form

        errors = ""
        car_data = Car.new(params.require(:car).permit(:image, :year, :mileage, :model, :make, :description, :price))
    
        respond_to do |format|
            format.html do
                car_data.model = car_data.model.downcase
                car_data.make = car_data.make.downcase
                car_data.user_id = current_user.id

                car_data.model.strip!
                car_data.make.strip!
 
                if car_data.save
                    flash.now[:success] = "Car saved successfully"
                    redirect_to dashboard_url
                else
                    car_data.errors.full_messages.each do |e|
                        errors = errors + e
                    end
                    flash[:error] = car_data.errors.full_messages.join(", ") 
                    render :upload_car, locals: { car_data: car_data }
                end
            end
        end       
    end

    private def upload_image(img)
        File.open(Rails.root.join('app', 'assets', 'images', 'cars', img.original_filename), 'wb') do |f|
            f.write(img.read)
            return img.original_filename
        end
    end

    private def delete_car_image(img)
        path = Rails.root.join('app', 'assets', 'images', 'cars', img)
        if File.exist?(path)
            File.delete(path)
            return true
        else
            return false
        end
    end

    def delete_car
        car = Car.find(params[:id])
        respond_to do |format|
            format.html do
                render :confirm_delete, locals:{car: car}
            end
        end
    end

    def destroy
        car = Car.find(params[:id])

        respond_to do |format|
            format.html do
                if car.destroy
                    flash[:success] = 'Car removed successfully'
                    redirect_to dashboard_url
                else
                    flash[:error] = "Error: cannot delete record" 
                end
            end
        end
    end

    def edit
        car = Car.find(params[:id])
        respond_to do |format|
            format.html do
                render :edit, locals:{car: car}
            end
        end
    end

    def update
        car = Car.find(params[:id])
        

        respond_to do |format|
            format.html do
                if car.update(params.require(:car_edit).permit(:image, :year, :mileage, :model, :make, :description, :price))

                    car.make = car.make.downcase
                    car.make.strip!
                    car.model = car.model.downcase
                    car.model.strip!
                    car.update_attribute(:make, car.make)
                    car.update_attribute(:model, car.model)
                    
                    flash[:success] = "Car updated successfully"
                    redirect_to car_details_url

                else
                    errors = ""
                    car.errors.full_messages.each do |e|
                        errors = errors + e
                    end
                    flash[:error] = car.errors.full_messages.join(", ") 
                    render :edit, locals: { car: car }
                end
            end
        end
    end

    ## this method for seller rating
    def rate_this_seller
        message = nil
        car_id = params[:car_id]
        stars = params[:stars]
        user_id = Car.select(:user_id).where(id: car_id)
        seller_id = user_id[0].user_id
        buyer_id = current_user.id
        isAleadyExist = Rating.where(seller_id: seller_id, buyer_id: buyer_id)
        if !isAleadyExist.empty?
            isAleadyExist[0].update_attribute(:rating, stars)
            message = "Updated!"
        else
            # create a new row
            _newRecord = Rating.new()
            _newRecord.seller_id = seller_id
            _newRecord.buyer_id = buyer_id
            _newRecord.rating = stars
            if _newRecord.save
                message = "Created!"
            else
                message = "Error!"
            end
        end
        render :json => message
    end
    

    def mark_as_sold
        car_id = params[:car_id]
        value = params[:sold]
        car = Car.where(id: car_id)
        car[0].update_attribute(:sold, value)
        render :json => "success"
    end
end
