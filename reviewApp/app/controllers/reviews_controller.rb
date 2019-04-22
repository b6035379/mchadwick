class ReviewsController < ApplicationController
  before_action :login_required, only: [:create, :edit, :destroy]
  before_action :set_product, only: [:index, :create]
  before_action :set_profile, except: [:index]




  def index
    @reviews = Review.where(:product_id => @product).paginate(:page => params[:page], :per_page => 4)
  end

  def show
        @review = Review.find(params[:id])

  end

  def new
    @review = Review.new
  end

  def edit
    @review = Review.find(params[:id])
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.product_id = @product.id
    @review.author = @profile.fullName
    @review.image_file_name = @profile.image
      if @review.save
        redirect_to @product
      else
        render 'new'
      end
    end
  

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      redirect_to @review
    else
      render 'edit'
    end
    end
  
def set_product
  @product = Product.find(params[:product_id])
end

def set_profile
            if current_user.present? 
@profile = Profile.where(:user_id => current_user.id).first
end end
 
  def destroy
          @review = Review.find(params[:id])
          @review.destroy
          redirect_back(fallback_location: root_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:author, :rating, :reviewText, :reviewDate, :user_id, :image_file_name)
    end
end
