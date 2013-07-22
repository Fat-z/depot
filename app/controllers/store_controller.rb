class StoreController < ApplicationController
  skip_before_filter :authorize
  
  def index
    if params[:set_locale]
      redirect_to store_path(locale: params[:set_locale])
     end

    if(session[:user_id] == nil or User.find_by_id(session[:user_id]).identity == "customer")
      @products = Product.order(:title)
    else
      @products = Product.where(publish: User.find_by_id(session[:user_id]).name).order(:title)
    end
    @cart = current_cart

    if params[:search] and params[:search].lstrip != ""
      #product = Product.where("title = ?", params[:search])

      product = []
      products = Product.all
      products.each  do |pro|
        if pro.title.upcase.include?(params[:search].upcase)
          product.push(pro)
        end
      end
      
      if product.length != 0
        @products = product
      else
         respond_to do |format|
           format.html { redirect_to store_url, notice: "#{params[:search]} not found" }
         end
      end
    end
        
  end
end
