
class HomesController < ApplicationController
  def welcome
    respond_to do |format|
      cars = Car.all
      makes = Car.distinct.pluck(:make)
      models = Car.distinct.pluck(:model)
      mileages = Car.distinct.pluck(:mileage)
      years = Car.distinct.pluck(:year)
      prices = Car.distinct.pluck(:price)
      format.html do 
        render :welcome, locals:{search_result: cars,makes:makes, models:models, mileages:mileages,years:years, prices:prices,is_search:false}
      end
    end
  end

  def search
    respond_to do |format|
      makes = Car.distinct.pluck(:make)
      models = Car.distinct.pluck(:model)
      mileages = Car.distinct.pluck(:mileage)
      years = Car.distinct.pluck(:year)
      prices = Car.distinct.pluck(:price)
      format.html do
        if params[:search].blank?
          search_result = "Empty! Please try again!"
          render :welcome, locals:{search_msg: search_result ,makes:makes, models:models, mileages:mileages,years:years, prices:prices, is_search:true}
        else
          search_result = Car.where(make: params[:search].downcase)
          render :welcome, locals:{search_result: search_result,makes:makes, models:models, mileages:mileages,years:years, prices:prices,is_search:true}
        end
      end
    end
  end
  
  def advance_search
    respond_to do |format|
      makes = Car.distinct.pluck(:make)
      models = Car.distinct.pluck(:model)
      mileages = Car.distinct.pluck(:mileage)
      years = Car.distinct.pluck(:year)
      prices = Car.distinct.pluck(:price)
      empty ||=check_empty 
      format.html do
        if empty
          search_result = "Empty! Please try again!"
          render :welcome, locals:{search_msg: search_result ,makes:makes, models:models, mileages:mileages,years:years, prices:prices, is_search:true}
        else
          search_result = Car.order(id: :asc)
          search_result = search_result.where(make: params[:make].downcase) if params[:make].present?
          search_result = search_result.where(model: params[:model].downcase) if params[:model].present?
          search_result = search_result.where(mileage: params[:mileage]) if params[:mileage].present?
          search_result = search_result.where(year: params[:year]) if params[:year].present?
          search_result = search_result.where(price: params[:price]) if params[:price].present?
          render :welcome, locals:{search_result: search_result,makes:makes, models:models, mileages:mileages,years:years, prices:prices,is_search:true}
        end 
      end
    end
  end
  private def check_empty
    empty = true
    params.each do |key, value|
      if key.eql? "make" or key.eql? "model" or key.eql? "mileage" or key.eql? "year" or key.eql? "price" and !value.empty?
        empty = false
      end
    end
    return empty
  end

  def message
    respond_to do |format|
      format.html { render :message }
    end
  end

  def about
    respond_to do |format|
      format.html { render :about }
    end
  end
end
