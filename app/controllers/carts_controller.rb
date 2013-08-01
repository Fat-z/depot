class CartsController < ApplicationController
  skip_before_filter :authorize,only: [:create, :update, :destroy]
  
  # GET /carts
  # GET /carts.json
  def index
    user = User.find(session[:user_id])
    
    if user.identity == "administrator"
      @carts = Cart.all
    else
      @carts = Cart.where(user_id: session[:user_id])
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @carts }
    end
  end

  # GET /carts/1
  # GET /carts/1.json
  def show
    begin
      @cart = Cart.find(params[:id])
      
    rescue ActiveRecord::RecordNotFound
      logger.error "Attempt to access invalid cart #{params[:id]}"
      redirect_to store_url, notice: 'Invalid cart'
      
    else
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @cart }
      end
    end
  end

  # GET /carts/new
  # GET /carts/new.json
  def new
    user = User.find(session[:user_id])
    
    if user.identity != "customer"
      respond_to do |format|
        format.html { redirect_to carts_path, notice: "Attempt to add a cart, failure:  You are not a customer!!" }
      end
      
    else
      @cart = Cart.new

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @cart }
      end
    end
  end

  # GET /carts/1/edit
  def edit
    user = User.find(session[:user_id])
    @cart = Cart.find(params[:id])
    
    if @cart.user_id != session[:user_id]
      
      respond_to do |format|
        format.html { redirect_to carts_path, notice: "Attempt to edit other's cart, failure" }
      end
      
    else
      respond_to do |format|
        format.html
        format.json { render json: @cart }
      end  
    end
    
  end

  # POST /carts
  # POST /carts.json
  def create
    user = User.find(session[:user_id])
    
    if user.identity != "customer"
      respond_to do |format|
        format.html { redirect_to carts_path, notice: "Attempt to add a cart, failure:  You are not a customer !!" }
      end
      
    else  
      @cart = Cart.new(params[:cart])

      respond_to do |format|
        if @cart.save
          session[:cart_id] = @cart.id
          format.html { redirect_to @cart, notice: 'Cart was successfully created.' }
          format.json { render json: @cart, status: :created, location: @cart }
        else
          format.html { render action: "new" }
          format.json { render json: @cart.errors, status: :unprocessable_entity }
        end
      end
     end
     
  end

  # PUT /carts/1
  # PUT /carts/1.json
  def update
    @cart = Cart.find(params[:id])
    
    if @cart.user_id != session[:user_id]
      
      respond_to do |format|
        format.html { redirect_to carts_path, notice: "Attempt to access other's cart, failure" }
      end
      
    else
      respond_to do |format|
        if @cart.update_attributes(params[:cart])
          format.html { redirect_to @cart, notice: 'Cart was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @cart.errors, status: :unprocessable_entity }
        end
      end
      
    end
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    user = User.find(session[:user_id])
    @cart = Cart.find(params[:id])
    
    respond_to do |format|
      if user.identity == "administrator" or @cart.user_id == Integer(session[:user_id])
        @cart.destroy
        format.html { redirect_to carts_path, notice: "Destroy cart, successfully" }
       
      else
        format.html { redirect_to carts_path, notice: "Attempt to destroy other's cart, failed" }
        
      end     
    end
    
   end

  def empty
    user = User.find(session[:user_id])
    @cart = Cart.find(params[:id])
    
    respond_to do |format|
      if @cart.user_id == Integer(session[:user_id])
        @cart.destroy
        format.html { redirect_to store_path, notice: "Empty cart, successfully" }
       
      else
        format.html { redirect_to store_path, notice: "Attempt to empty other's cart, failed" }
        
      end
     end    
  end
       
end
