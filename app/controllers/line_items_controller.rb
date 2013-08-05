#---
# Excerpted from "Agile Web Development with Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
class LineItemsController < ApplicationController
  skip_before_filter :authorize, only: :create
  
  # GET /line_items
  # GET /line_items.json
  def index
    if session[:user_id] == nil or User.find_by_id(session[:user_id]).identity != "administrator"
      redirect_to store_path
    else
      @line_items = LineItem.all

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @line_items }    
      end
    end
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
    if session[:user_id] == nil or User.find_by_id(session[:user_id]).identity != "administrator"
      redirect_to store_path
    else
      @line_item = LineItem.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @line_item }
      end
    end
  end

  # GET /line_items/new
  # GET /line_items/new.json
  def new
    if session[:user_id] == nil or User.find_by_id(session[:user_id]).identity != "administrator"
      redirect_to store_path
    else
      @line_item = LineItem.new

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @line_item }
      end
    end
  end

  # GET /line_items/1/edit
  def edit
    if session[:user_id] != nil 
      if User.find(session[:user_id]).identity == "administrator" or session[:user_id] == LineItem.find(params[:id]).order.user_id 
        @line_item = LineItem.find(params[:id])
      else
        redirect_to store_path
      end
    else
      redirect_to store_path
    end
  end

  # POST /line_items
  # POST /line_items.json
  def create
    
    @cart = Cart.find(params[:cart_id])
    product = Product.find(params[:product_id]) 
    if product.temprepertory > 0
      @line_item = @cart.add_product(product.id)
      @line_item.product = product

      product.temprepertory -= 1
      product.save
    #else
      #flash[:notice] = "#{product.title} is not enough"
    end
    respond_to do |format|
      if @line_item.save
        format.html { redirect_to store_url }
        format.js   { @current_item = @line_item }
        format.json { render json: @line_item,
          status: :created, location: @line_item }
          
      else
        format.html { render action: "new" }
        format.json { render json: @line_item.errors,
          status: :unprocessable_entity }
      end
    end
  end

  # PUT /line_items/1
  # PUT /line_items/1.json
  def update
    @line_item = LineItem.find(params[:id])
    @cart = Cart.find(@line_item.cart_id)
    @product = @line_item.product
    @prerepertory = @line_item.pre_repertory

    respond_to do |format|
      
      if ((1..10) === params[:line_item]["quantity"].to_i) == false
        format.html { redirect_to edit_cart_path(@cart), notice: 'Unexpected quantity. Valid interval [1..10]' }
        
      elsif @line_item.quantity == params[:line_item]["quantity"].to_i
        format.html { redirect_to edit_cart_path(@cart), notice: 'No change.' }
      
      elsif @prerepertory < params[:line_item]["quantity"].to_i
        format.html { redirect_to edit_cart_path(@cart), notice: 'Repertory not enough.' }  
      elsif @line_item.update_attributes(params[:line_item])
        @product.temprepertory = @prerepertory - @line_item.quantity
        @product.save
        @cart = current_cart
        format.html { redirect_to edit_cart_path(@cart), notice: 'Successfully updated.' }
      else
        @cart = current_cart
        format.html { redirect_to edit_cart_path(@cart), notice: 'Unsuccessfully update.' }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    if session[:user_id] != nil 
      if User.find(session[:user_id]).identity == "administrator" or LineItem.find(params[:id]).order_id == nil or session[:user_id] == LineItem.find(params[:id]).order.user_id
        @line_item = LineItem.find(params[:id])
        
        if @line_item.cart_id != nil
          @cart = Cart.find(@line_item.cart_id)
        else
          @order = LineItem.find(params[:id]).order
        end
        
        @line_item.clear_the_item    
        @line_item.destroy
        
        respond_to do |format|
          if @line_item.cart_id != nil
            format.html { redirect_to edit_cart_path(@cart), notice: 'Remove line_item successfully.' }
          else
            format.html { redirect_to show_order_path(@order), notice: 'Remove line_item successfully'}
          end
        end
      else
        redirect_to store_path
      end
    else
      redirect_to store_path
    end
  end

end
