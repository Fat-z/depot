require 'will_paginate/array'
class StoreController < ApplicationController
  skip_before_filter :authorize
  def index
    if params[:set_locale]
      redirect_to store_path(locale: params[:set_locale])
     end

    if params[:catagory]
      @products = Product.where("category = ?", params[:catagory])
    else
      @products = Product.order(:title)
    end
  
    @cart = current_cart
<<<<<<< HEAD
    
    @products = @products.paginate :page => params[:page], :per_page => 5
    
=======

>>>>>>> origin/dev3
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
