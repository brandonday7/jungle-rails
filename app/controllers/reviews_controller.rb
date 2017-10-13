class ReviewsController < ApplicationController

  before_filter :verify_logged_in

  def create
    current_product = Product.find(params[:product_id])

    current_product.reviews.create!({
      user_id: session[:user_id],
      description: params[:review][:description],
      rating: params[:review][:rating].to_i})


    redirect_to "/products/#{current_product[:id]}"

  end

  def destroy
    current_product = Product.find(params[:product_id])
    review = Review.find(params[:id])
    review.destroy
    redirect_to "/products/#{current_product[:id]}"
  end

  private
  def verify_logged_in
    if !session[:user_id]
      redirect_to "/products/#{current_product[:id]}"
    end
  end


end
