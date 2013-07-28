class ProductsController < ApplicationController
  skip_before_filter :authorize, only: :show
  # GET /products
  # GET /products.json
  def index
    if User.find_by_id(session[:user_id]).identity == "administrator"
      @products = Product.all
    else
      @products = Product.where(publish: User.find_by_id(session[:user_id]).name)
    end
    #@products = Product.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
    end
    
  end

  # GET /products/1
  # GET /products/1.xml
  def show
    @cart = current_cart
    @comment_line_item = CommentLineItem.new
    @user = User.find_by_id(session[:user_id])
    @product = Product.find(params[:id])
    product_id = params[:id]
    @comments = CommentLineItem.where(:product_id => product_id).order("created_at desc").paginate :page=>params[:page],
     :per_page => 3
    @comments2 = CommentLineItem.where(:product_id => product_id)
    @product.comment_number = @comments2.length
    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @product }
    end
  end

  # GET /products/new
  # GET /products/new.json
  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(params[:product])
    if session[:user_id] != nil
      @product.publish = User.find_by_id(session[:user_id]).name
    end
    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render json: @product, status: :created, location: @product }
      else
        format.html { render action: "new" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.json
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to store_url }
      format.json { head :no_content }
    end
  end

  def who_bought
    @product = Product.find(params[:id])
    respond_to do |format|
      format.atom
      
    end
  end

end
