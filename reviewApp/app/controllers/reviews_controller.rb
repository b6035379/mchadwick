class ReviewsController < ApplicationController


	def new
		@review = Review.new
	end

	def show
		@review = Review.find(params[:id])
	end

	def index
		@reviews = Review.all
	end

	def create
		@review = Review.new(review_params)
		if @review.save
			redirect_to @review
		else
			render 'new'
		end
	end

	def update
	end

	def edit
	end

	def destroy
	end

	private 
	def review_params 
		params.require(:review).permit(:author, :productRating, :reviewContent, :dateOfReview, :productID)
	end
end