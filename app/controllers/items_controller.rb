class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  def index
    if params[:user_id]
      items = User.find(params[:user_id]).items
    else
    items = Item.all
  end
    render json: items, include: :user

end

def create
  if params[:user_id]
    items = User.find(params[:user_id]).items.create(permitted_params)
end
  render json: items, status: :created
end

def show
 item =  Item.find(params[:id])

 render json: item
 
end


private

def render_not_found_response
  render json: { error: "Items not found" }, status: :not_found
end

def permitted_params
  params.permit(:name, :description, :price)
end

end
