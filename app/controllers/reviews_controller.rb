class ReviewsController < ApplicationController
  def create
    current_product = Product.find(params[:product_id])

    current_product.reviews.create!({
      user_id: session[:user_id],
      description: params[:review][:description],
      rating: params[:review][:rating].to_i})


    redirect_to "/products/#{current_product[:id]}"

  end

end
