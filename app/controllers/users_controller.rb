class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def profile
    user_id = current_user.id
    user_ratings = Rating.where(seller_id: user_id).sum(:rating)
    totalRater = Rating.select(:id).where(seller_id: user_id).count
    respond_to do |format|
        if totalRater != 0
          averageRating = user_ratings.to_f/totalRater.to_f
        else
          averageRating = 0.0
        end
        format.html { render :profile, locals:{user_rating: averageRating.round} }
    end
  end

  def report
    respond_to do |format|
      format.html do
        render :report
      end
    end
  end

  def report_authority
    report_data = Report.new(params.require(:report).permit(:subject, :body, :user_id))
    authority = User.where("authority = ?", true)
    reports = Report.where(user_id: report_data.user_id)
    respond_to do |format|
        format.html do
          if report_data.save
            flash[:success] = "Thank you for your feedback. We will take care of it."
            render :show, locals: { reports: reports }
          else
            flash[:warning] = "Error! couldn't report this time. Please try again!"
          end
        end
    end
  end

  def index
    reports = Report.where(user_id: current_user.id)
    respond_to do |format|
      format.html do
        render :show, locals: { reports: reports }
      end
    end
  end

  def authority_view
    reports = Report.all
    respond_to do |format|
      format.html do
        render :show, locals: { reports: reports }
      end
    end
  end

end