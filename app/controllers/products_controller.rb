class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :is_admin?, only: [:show, :edit, :update, :destroy]
  # GET /products
  # GET /products.json
  def index
    @products = Product.includes(:brand).all
    @products = filter(@products).page(params[:page])
    respond_to do |format|
      format.html
      format.xlsx{
        response.headers['Content-Disposition'] = 'attachment; filename="products.xlsx"'
      }
    end

  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.fetch(:product, {})
    end

    def is_admin?
      return current_user.present? && current_user.admin_user_type?
    end

    def filter(products)
      parameters = params[:filter]
      
      #If no filter present
      return products unless parameters.present?

      if parameters[:brand_id].present?
        products = products.where(brand_id: parameters[:brand_id])
      end
      if parameters[:ram].present?
        products = products.where(ram: parameters[:ram])
      end
      if parameters[:internal_storage].present?
        products = products.where(internal_storage: parameters[:internal_storage])
      end
      if parameters[:from_price].present?
        products = products.where("price >= ?", parameters[:from_price])
      end
      if parameters[:to_price].present?
        products = products.where("price >= ?", parameters[:to_price])
      end
      return products
    end
end
