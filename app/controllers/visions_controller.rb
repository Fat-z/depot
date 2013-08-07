class VisionsController < ApplicationController
  # GET /visions
  # GET /visions.json
  def index
    if session[:user_id] != nil
      if User.find_by_id(session[:user_id]).identity == "customer"
        @visions = Vision.where(publisher: session[:user_id])
      else
        @visions = Vision.all
      end

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @visions }
      end
    else
      redirect_to store_path
    end
  end

  # GET /visions/1
  # GET /visions/1.json
  def show
    @vision = Vision.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @vision }
    end
  end

  # GET /visions/new
  # GET /visions/new.json
  def new
    if session[:user_id] != nil and User.find_by_id(session[:user_id]).identity != "seller"
      @vision = Vision.new

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @vision }
      end
    else
      redirect_to store_path
    end
  end

  # GET /visions/1/edit
  def edit
    if session[:user_id] != nil and User.find_by_id(session[:user_id]).identity != "seller"
      @vision = Vision.find(params[:id])
    else
      redirect_to store_path
    end
  end

  # POST /visions
  # POST /visions.json
  def create
    if session[:user_id] != nil and User.find_by_id(session[:user_id]).identity != "seller"
      @vision = Vision.new(params[:vision])

      @vision.publisher = session[:user_id]
      
      respond_to do |format|
        if @vision.save
          format.html { redirect_to @vision, notice: 'Vision was successfully created.' }
          format.json { render json: @vision, status: :created, location: @vision }
        else
          format.html { render action: "new" }
          format.json { render json: @vision.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to store_path
    end
  end

  # PUT /visions/1
  # PUT /visions/1.json
  def update
    if session[:user_id] != nil and User.find_by_id(session[:user_id]).identity != "seller"
      @vision = Vision.find(params[:id])

      respond_to do |format|
        if @vision.update_attributes(params[:vision])
          format.html { redirect_to @vision, notice: 'Vision was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @vision.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to store_path
    end
  end

  # DELETE /visions/1
  # DELETE /visions/1.json
  def destroy
    @vision = Vision.find(params[:id])
    @vision.destroy

    respond_to do |format|
      format.html { redirect_to visions_url }
      format.json { head :no_content }
    end
  end

  def dispose
    @vision = Vision.find(params[:id])
    VisionNotifier.published(@vision).deliver
    @vision.destroy
    redirect_to new_product_path
  end


end
