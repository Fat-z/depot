class UsersController < ApplicationController
  skip_before_filter :authorize, only: [:new, :create]
  # GET /users
  # GET /users.json
  def index
    
    if session[:user_id] == nil or User.find_by_id(session[:user_id]).identity != "administrator"
      redirect_to store_path
    else 
      @users = User.order(:name)
  
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @users }
      end
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
<<<<<<< HEAD
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
=======
    
    if session[:user_id] != nil
      if User.find(session[:user_id]) == User.find(params[:id]) or User.find(session[:user_id]).identity == "administrator" 
        @user = User.find(params[:id])
        respond_to do |format|
          format.html # show.html.erb
          format.json { render json: @user }
        end
      else
         redirect_to store_path
      end
    else 
      redirect_to store_path
>>>>>>> origin/dev3
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
<<<<<<< HEAD
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
=======
    if session[:user_id] == nil or User.find(session[:user_id]).identity == "administrator"
      @user = User.new

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @user }
      end
    else
      redirect_to store_path
>>>>>>> origin/dev3
    end
  end

  # GET /users/1/edit
  def edit
<<<<<<< HEAD
    @user = User.find(params[:id])
=======
    if session[:user_id] != nil
      if User.find(session[:user_id]) == User.find(params[:id]) or User.find(session[:user_id]).identity == "administrator" 
        @user = User.find(params[:id])
      else
        redirect_to store_path
      end
    else
      redirect_to store_path

    end 
>>>>>>> origin/dev3
  end

  # POST /users
  # POST /users.json
  def create
<<<<<<< HEAD
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_url, 
          notice: "User #{@user.name} was successfully created." }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
=======
    if session[:user_id] == nil or User.find_by_id(session[:user_id]).identity == "administrator"
      @user = User.new(params[:user])

      respond_to do |format|
        if @user.save
          format.html { redirect_to users_url, 
            notice: "User #{@user.name} was successfully created." }
          format.json { render json: @user, status: :created, location: @user }
        else
          format.html { render action: "new" }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to store_path
>>>>>>> origin/dev3
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
<<<<<<< HEAD
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to admin_url, 
          notice: "User #{@user.name} was successfully updated." }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
=======
    if session[:user_id] != nil
      if User.find(session[:user_id]) == User.find(params[:id]) or User.find(session[:user_id]).identity == "administrator"
        @user = User.find(params[:id])

        respond_to do |format|
          if @user.update_attributes(params[:user])
            format.html { redirect_to admin_url, 
              notice: "User #{@user.name} was successfully updated." }
            format.json { head :no_content }
          else
            format.html { render action: "edit" }
            format.json { render json: @user.errors, status: :unprocessable_entity }
          end
        end
      else
        redirect_to store_path
      end
    else
      redirect_to store_path
>>>>>>> origin/dev3
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
<<<<<<< HEAD
    @user = User.find(params[:id])
    begin
      @user.destroy
      flash[:notice] = "User #{@user.name} deleted"
    rescue Exception => e
      flash[:notice] = e.message
    end
    
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
=======
    if session != nil and User.find(session[:user_id]).identity == "administrator"
      @user = User.find(params[:id])
      begin
        @user.destroy
        flash[:notice] = "User #{@user.name} deleted"
      rescue Exception => e
        flash[:notice] = e.message
      end
      
      respond_to do |format|
        format.html { redirect_to users_url }
        format.json { head :no_content }
      end
>>>>>>> origin/dev3
    end
  end
end
