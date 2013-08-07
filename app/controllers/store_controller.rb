class StoreController < ApplicationController
  skip_before_filter :authorize
  
  def index
    @catag = ""
    @about = ""
    @search = ""
    sort = "title"
    @page = 1
    @products2 = Product.all
    
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
           result = []
           products = Product.where("publish = ?", user.name )
           
           products.each do |pro|
             item = {"product_id" => pro.id,
                  "image_url" => pro.image_url, 
                  "photo" => pro.photo,
                  "description" => pro.description,
                  "title" => pro.title,
                  "price" => pro.price,
                  "comments_count" => CommentLineItem.where("product_id = ?", pro.id ).count
               }
             result.push(item)
           end
           
           if result.length > 0
             result.sort! { |k, v| v["comments_count"]}
             #result = result.reverse
           end
           
           render "show_seller", :locals =>{:user => user, :products=> result}
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
    
    if params[:order] == "popular" and @products.length != 0
                    
      popular = []
      products = []
      index = 0
      
      @products.each do |pro|
        item = {"id" => pro.id,
                "num" => CommentLineItem.where("product_id = ?", pro.id ).count }
                               
        count = index
        while count > 0
          if popular[count-1]["num"] >= item["num"]
            break
            
          end       
          count -= 1
        end
        
        tmp = [item]
        
        if index == 0 or count == index
          popular[count] = item
          
        elsif count == 0
          popular = tmp + popular
        
        else
          popular = popular[0..count-1] + tmp + popular[count..index-1]
        end
        index += 1
       
        #popular.push(item)
      end
      
      #popular.sort! {|k, v| v["num"] }
      
      popular.each do |pop|
        products.push( Product.find(pop["id"]) )
      end
      
      @products = products
    end
    
    if ("1".."4") === params[:page] and @products.length != 0
      index = Integer(params[:page])
      if index != @page
        @page = index
      end
    end
    @products = @products[(@page -1)*6..@page*6-1 ]
    #else
      #@products = @products[0..5]
    #end 
             
  end
  
  
  def show_customer
    
  end

  def show_seller
    
  end
        
end
