class SlidesController < ApplicationController
  # GET /slides
  # GET /slides.json
  def index
    @slide_search_form = SlideSearchForm.new(params[:slide_search_form], current_user.home_id)
    @recents = Slide.recents

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @slides }
    end
  end

  def list
    @slides = Slide
              .where(home_id: current_user.home_id)
              .order('id')
              .page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @slides }
    end
  end

  # GET /slides/1
  # GET /slides/1.json
  def show
    @slide = find_slide(params[:id])

    if @slide.blank?
      raise ActiveRecord::RecordNotFound.new("Couldn't find Slide with 'id'=#{params[:id]}")
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @slide }
    end
  end

  # GET /slides/1/detail
  def detail
    @slide = find_slide(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @slide }
    end
  end

  def preview
    @slide = Slide.new(body:params[:body])
    render layout: false
  end

  # GET /slides/new
  # GET /slides/new.json
  def new
    @slide = Slide.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @slide }
    end
  end

  # GET /slides/1/edit
  def edit
    @slide = find_slide(params[:id])
  end

  # POST /slides
  # POST /slides.json
  def create
    @slide = Slide.new(slide_params)
    @slide.home_id = current_user.home_id

    respond_to do |format|
      if @slide.save
        format.html { redirect_to @slide, notice: 'Slide was successfully created.' }
        format.json { render json: @slide, status: :created, location: @slide }
      else
        format.html { render action: "new" }
        format.json { render json: @slide.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /slides/1
  # PUT /slides/1.json
  def update
    @slide = find_slide(params[:id])

    respond_to do |format|
      if @slide.update_attributes(slide_params)
        format.html { redirect_to @slide, notice: 'Slide was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @slide.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /slides/1
  # DELETE /slides/1.json
  def destroy
    @slide = find_slide(params[:id])
    @slide.destroy

    respond_to do |format|
      format.html { redirect_to slides_url }
      format.json { head :no_content }
    end
  end

  def search
    @slide_search_form = SlideSearchForm.new(params[:slide_search_form])
    @slides = @slide_search_form.search.page(params[:page])
  end

  private def slide_params
    params.require(:slide).permit(
      :home_id, :title, :body, :author
    )
  end

  private def find_slide(slide_id)
    find_model(Slide, slide_id)
  end
end
