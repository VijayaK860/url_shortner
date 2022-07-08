class UrlsController < ApplicationController
  def index
    @urls = Url.all
  end

  def show
    @url = Url.find_by_shortcode(params[:slug])
    if @url.nil?
      render file: 'public/404.html', status: :not_found, layout: false
    else
      redirect_to @url.url
    end
  end

  def new
    @url = Url.new
  end

  def create
    @url = Url.generate_link(params[:url][:url])
    if @url.save
      flash[:notice] = 'You have successfully shortened URL.'
      redirect_to root_path
    else
      render 'new'
    end
  end

  def destroy
    @url = Url.find(params[:id])
    @url.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: "Url was successfully removed." }
      format.json { head :no_content }
    end
  end
end
