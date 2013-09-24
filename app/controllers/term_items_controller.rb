class TermItemsController < ApplicationController
  # GET /term_items
  # GET /term_items.json
  def index
    @term_items = TermItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @term_items }
    end
  end

  # GET /term_items/1
  # GET /term_items/1.json
  def show
    @term_item = TermItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @term_item }
    end
  end

  # GET /term_items/new
  # GET /term_items/new.json
  def new
    @term_item = TermItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @term_item }
    end
  end

  # GET /term_items/1/edit
  def edit
    @term_item = TermItem.find(params[:id])
  end

  # POST /term_items
  # POST /term_items.json
  def create
    @term_item = TermItem.new(params[:term_item])

    respond_to do |format|
      if @term_item.save
        format.html { redirect_to @term_item, notice: 'Term item was successfully created.' }
        format.json { render json: @term_item, status: :created, location: @term_item }
      else
        format.html { render action: "new" }
        format.json { render json: @term_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /term_items/1
  # PUT /term_items/1.json
  def update
    @term_item = TermItem.find(params[:id])

    respond_to do |format|
      if @term_item.update_attributes(params[:term_item])
        format.html { redirect_to @term_item, notice: 'Term item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @term_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /term_items/1
  # DELETE /term_items/1.json
  def destroy
    @term_item = TermItem.find(params[:id])
    @term_item.destroy

    respond_to do |format|
      format.html { redirect_to term_items_url }
      format.json { head :no_content }
    end
  end

  def build
    Dataset.all.each do |dataset|
      
  end 
end
