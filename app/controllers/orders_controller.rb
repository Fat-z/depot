class OrdersController < ApplicationController
  skip_before_filter :authorize, only: [:new, :create]
  
  # GET /orders
  # GET /orders.json
  def index
    if session[:user_id] != nil
      @orders = Order.paginate page: params[:page], order: 'created_at desc',
        per_page: 10
        
      @line_items = LineItem.paginate page: params[:page], order: 'created_at desc',
        per_page: 10

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @orders }
      end
    else
      redirect_to store_url
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    if session[:user_id] != nil
      if User.find(session[:user_id]).identity == "administrator" or session[:user_id] == Order.find(params[:id]).user_id
        @order = Order.find(params[:id])
        @orders_all = Order.all

        respond_to do |format|
          format.html # show.html.erb
          format.json { render json: @order }
        end
      else
        redirect_to store_url
      end
    else
      redirect_to store_url
    end
  end

  # GET /orders/new
  # GET /orders/new.json
  def new
    
    @cart = nil
       
    if (session[:cart_id] != nil)
      @cart = Cart.find(session[:cart_id])
    end 
      
    if @cart == nil or @cart.line_items.empty?
      redirect_to store_url, notice: "Your cart is empty"
      
    else
      @order = Order.new
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @order }
      end      
    end
  end
  
  def add
    user = User.find(session[:user_id])
    @cart = Cart.find(params[:cart_id])
   
   if user.id != @cart.user_id
     redirect_to edit_cart_path(@cart), notice: "Attempt to checkout other's carts, failed !!"
     
   elsif @cart.line_items.empty?
      redirect_to edit_cart_path(@cart), notice: "Your cart is empty"
      
   else
      @order = Order.new
  
      respond_to do |format|
        format.html 
        format.json { render json: @order }
      end      
   end
  end
  
  # GET /orders/1/edit
  def edit
    if session[:user_id] != nil
      if User.find(session[:user_id]).identity == "administrator" or session[:user_id] == Order.find(params[:id]).user_id
        @order = Order.find(params[:id])
      else
        redirect_to store_url
      end
    else
      redirect_to store_url
    end
  end

  def make
    @order = Order.new(params[:order])
    @cart = Cart.find(params[:cart_id])
    @order.add_line_items_from_cart(@cart)
    
    respond_to do |format|
      if @order.save
        Cart.destroy(@cart.id)
        OrderNotifier.received(@order).deliver
        format.html { redirect_to carts_path, notice:
           I18n.t('.thanks') }
      else
        format.html { render action: "add" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
    
  end
  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(params[:order])
    @order.add_line_items_from_cart(current_cart)

    respond_to do |format|
      if @order.save
         @order.user_id = session[:user_id]
         @order.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        OrderNotifier.received(@order).deliver
        format.html { redirect_to store_url, notice:
           I18n.t('.thanks') }
          #notice: 'Thank you for your order.' }
        format.json { render json: @order, status: :created, location: @order }
      else
        @cart = current_cart
        format.html { render action: "new" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.json
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    if session[:user_id] != nil
      if User.find(session[:user_id]).identity == "administrator" or session[:user_id] == Order.find(params[:id]).user_id
        @order = Order.find(params[:id])
        @order.after_destroying_the_order
        @order.destroy

        respond_to do |format|
          format.html { redirect_to orders_url }
          format.json { head :no_content }
        end
      else
        redirect_to store_url
      end
    else
      redirect_to store_url
    end
  end

end
