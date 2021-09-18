# encode: utf-8
class SongsController < ApplicationController
  # GET /songs
  # GET /songs.json
  def index
    @song_search_form = SongSearchForm.new(params[:song_search_form], current_user.home_id)
    @recents = Song.recents(current_user.home_id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @songs }
    end
  end

  def list
    @songs = Song
             .where(home_id: current_user.home_id)
             .order('id')
             .page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @songs }
    end
  end

  def list_all
    @songs = Song.where(home_id: current_user.home_id).order('id')
  end

  # GET /songs/1
  # GET /songs/1.json
  def show
    @song = find_song(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @song }
    end
  end

  # GET /songs/1/detail
  def detail
    @song = find_song(params[:id])

    respond_to do |format|
      format.html # detail.html.erb
      format.json { render json: @song }
    end
  end

  def preview
    @song = Song.new(words:params[:words])
  end

  # GET /songs/new
  # GET /songs/new.json
  def new
    @song = Song.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @song }
    end
  end

  # GET /songs/1/edit
  def edit
    @song = find_song(params[:id])
  end

  # POST /songs
  # POST /songs.json
  def create
    @song = Song.new(song_params)
    @song.home_id = current_user.home_id
    @song.romanize!
    @song.update_words_for_search!

    respond_to do |format|
      if @song.save
        format.html { redirect_to edit_song_path(@song), notice: 'Song was successfully created.' }
        format.json { render json: @song, status: :created, location: @song }
      else
        format.html { render action: "new" }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /songs/1
  # PUT /songs/1.json
  def update
    @song = find_song(params[:id])

    is_roman_button = (params[:button] == 'roman')
    is_saved = @song.update_with(is_roman_button, song_params)

    respond_to do |format|
      if is_saved
        format.html { redirect_to @song, notice: 'Song was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /songs/1
  # DELETE /songs/1.json
  def destroy
    @song = find_song(params[:id])
    @song.destroy

    respond_to do |format|
      format.html { redirect_to songs_url }
      format.json { head :no_content }
    end
  end

  def search
    @song_search_form = SongSearchForm.new(
      params[:song_search_form],
      current_user.home_id
    )
    @songs = @song_search_form.search.page(params[:page])
  end

  private def song_params
    params.require(:song).permit(
      :code, :title, :words, :cright
    )
  end

  private def find_song(song_id)
    find_model(Song, song_id)
  end
end
