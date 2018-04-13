class Api::V1::PhotosController < ApiController

  def index
    @photos = Photo.all
    #render json: @photos

    if false #use jbuilder
      render json: {
        data: @photos.map do |photo|{
          title: photo.title,
          date: photo.date,
          description: photo.description
        }
        end
      }
    end
  end

  def show
    #@photo = Photo.find(params[:id])
    @photo = Photo.find_by(id: params[:id])
    if !@photo
      render json: {
        message: "Can't find the photo!",
        status: 400
      }
    else                          # 此行可以省略, default jbuilder template
      render "api/v1/photos/show" # 此行可以省略, default jbuilder template
    end
  end

  def create
    @photo = Photo.new(photo_params)
    if @photo.save
      render json: {
        message: "Photo created successfully!",
        result: @photo
      }
    else
      render json: {
        errors:  @photo.errors
      }
    end
  end

  def update
    @photo = Photo.find_by(id: params[:id])
    if !@photo
      render json: {
        message: "Can't find the photo!",
        status: 400
      }
    else
      if @photo.update(photo_params)
        render json: {
          message: "Photo updated successfully!",
          result: @photo
        }
      else
        render json: {
          errors:  @photo.errors
        }
      end
    end
  end


  def destroy
    @photo = Photo.find_by(id: params[:id])
    if !@photo
      render json: {
        message: "Can't find the photo!",
        status: 400
      }
    else
      @photo.destroy
      render json: {
        message: "Photo destroy successfully!"
      }
    end
  end

  private


  def photo_params
    params.permit(:title, :date, :description, :file_location)
  end

end
