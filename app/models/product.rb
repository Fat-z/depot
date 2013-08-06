class Product < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  has_many :comment_line_items, dependent: :destroy
  has_many :orders, through: :line_items
  
  before_destroy :ensure_not_referenced_by_any_line_item

  #...


  attr_accessible :description, :image_url, :price, :title, :publish, :repertory, :category, :temprepertory, :photo
  attr :comment_number, true
  
  has_attached_file :photo,
                  :url => "/assets/products/:id/:basename.:extension",  
                  :path => ":rails_root/public/assets/products/:id/:basename.:extension" 
  
  PRODUCT_CATEGORY = ["literature", "science", "life", "culture", "economic"]
  validates :category, inclusion: PRODUCT_CATEGORY
  
  validates :title, :description, :image_url, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :repertory, numericality: {greater_than_or_equal_to: 0}
# 
  validates :title, uniqueness: true
  
  #validates_attachment_presence :photo 
  validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_content_type :photo, :content_type =>['image/jpeg','image/png','image/gif']

  validates :image_url, allow_blank: true, format: {
    with:    %r{\.(gif|jpg|png)\Z}i,
    message: 'must be a URL for GIF, JPG or PNG image.'
  }
  validates :title, length: {minimum: 10}
  
  before_create :randomize_file_name
  before_update :randomize_file_name
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
    
    def randomize_file_name
      if photo_file_name!=nil
      extension = File.extname(photo_file_name).downcase
      self.photo.instance_write(:file_name, "#{Time.now.strftime("%Y%m%d%H%M%S")}#{rand(1000)}#{extension}")
      end
    end
   

end