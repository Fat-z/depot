class StoreController < ApplicationController
  skip_before_filter :authorize
  def index
    if params[:set_locale]
      redirect_to store_path(locale: params[:set_locale])
     end

    @products = Product.order(:title)
  
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
