class CommentLineItemsController < ApplicationController
  skip_before_filter :authorize, only: [:new, :create]
  # GET /comment_line_items
  # GET /comment_line_items.json
  def index
    @comment_line_items = CommentLineItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comment_line_items }
    end
  end

  # GET /comment_line_items/1
  # GET /comment_line_items/1.json
  def show
    @comment_line_item = CommentLineItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comment_line_item }
    end
  end

  # GET /comment_line_items/new
  # GET /comment_line_items/new.json
  def new
    @comment_line_item = CommentLineItem.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment_line_item }
    end
  end

  # GET /comment_line_items/1/edit
  def edit
    @comment_line_item = CommentLineItem.find(params[:id])
  end

  # POST /comment_line_items
  # POST /comment_line_items.json
  def create
    @comment_line_item = CommentLineItem.new(params[:comment_line_item])
    
    respond_to do |format|
      if @comment_line_item.save
        format.html { redirect_to product_path(@comment_line_item.product_id),
          notice: 'Comment line item was successfully created.' }
        format.json { render json: @comment_line_item, status: :created, location: @comment_line_item }
      else
        format.html { render action: "new" }
        format.json { render json: @comment_line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /comment_line_items/1
  # PUT /comment_line_items/1.json
  def update
    @comment_line_item = CommentLineItem.find(params[:id])

    respond_to do |format|
      if @comment_line_item.update_attributes(params[:comment_line_item])
        format.html { redirect_to @comment_line_item, notice: 'Comment line item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment_line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comment_line_items/1
  # DELETE /comment_line_items/1.json
  def destroy
    @comment_line_item = CommentLineItem.find(params[:id])
    @comment_line_item.destroy

    respond_to do |format|
      format.html { redirect_to comment_line_items_url }
      format.json { head :no_content }
    end
  end
end
