class StoreController < ApplicationController
  skip_before_filter :authorize
  
  def index
    @catag = ""
    @about = ""
    @search = ""
    sort = "title"
    
    if params[:order] == "price" or params[:order] == "publish" or params[:order] == "title"
      sort = params[:order]
    end
    
    if params[:set_locale]
      redirect_to store_path(locale: params[:set_locale])
    end
    
    if params[:catagory] and params[:catagory].lstrip != ""
      @catag = params[:catagory]
      @products = Product.where("category = ?", params[:catagory]).order(sort)
      
    else
      @products = Product.order(sort)
    end
  
    @cart = current_cart
    
    if params[:search] and params[:search].lstrip != ""
      @search = params[:search]
      
      case params[:about]
        
      when "Book"
        @about = "Book"
        product = []
        products = Product.order(sort)
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
            
      when "Seller"
        user = User.find_by_name(params[:search])
        
        if user.identity != "seller"
          respond_to do |format|
            format.html { redirect_to store_url, notice: "no seller called #{params[:search]}" }
          end
         
        else
           products = Product.where("publish = ?", user.name )
           render "show_seller", :locals =>{:user => user, :products=> products}
        end
                
      when "Customer"
        user = User.find_by_name(params[:search])
        
        if user.identity != "customer"
          respond_to do |format|
            format.html { redirect_to store_url, notice: "no customer called #{params[:search]}" }
          end
         
        else
           comments = CommentLineItem.where("comment_user_name = ? ", user.name )
           render "show_customer", :locals =>{:user => user, :comments => comments }
        end
                
      else
         respond_to do |format|
           format.html { redirect_to store_url, notice: "invalid params" }
         end        
      end   
    end   
  end
    
end
