class Product < ActiveRecord::Base
<<<<<<< HEAD
  has_many :line_items
=======
  has_many :line_items, dependent: :destroy
>>>>>>> origin/dev3
  has_many :comment_line_items, dependent: :destroy
  has_many :orders, through: :line_items
  
  before_destroy :ensure_not_referenced_by_any_line_item

  #...


<<<<<<< HEAD
  attr_accessible :description, :image_url, :price, :title, :publish, :repertory, :category
=======
  attr_accessible :description, :image_url, :price, :title, :publish, :repertory, :category, :temprepertory
>>>>>>> origin/dev3
  attr :comment_number, true
  
  PRODUCT_CATEGORY = ["literature", "science", "life", "culture", "economic"]
  validates :category, inclusion: PRODUCT_CATEGORY
  
  validates :title, :description, :image_url, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :repertory, numericality: {greater_than_or_equal_to: 0}
# 
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: {
    with:    %r{\.(gif|jpg|png)\Z}i,
    message: 'must be a URL for GIF, JPG or PNG image.'
  }
  validates :title, length: {minimum: 10}

  def decrease(number)
      repertory - number
  end

  private

    # ensure that there are no line items referencing this product
    def ensure_not_referenced_by_any_line_item
      if line_items.empty?
        return true
      else
        errors.add(:base, 'Line Items present')
        return false
      end
    end

end