class Order < ApplicationRecord
  before_create -> {generate_number(hash_size)}
  belongs_to :user
  validates_uniqueness_of :number, on: :create, message: "must be unique"
  # before_create :generate_number
  
  
  has_many :order_items
  has_many :products, through: :order_items
  
  has_many :payments
  def add_product(product_id, quantity)
    product = Product.find(product_id)
    if product && product.stock > 0
      order_items.create(product_id: product.id, quantity: quantity, price: product.price)
    end
  end
  
  def generate_number(hash_size)
    self.number ||= loop do
      random = random_candidate(hash_size) 
      break random unless Order.exists?(number: random)
    end
  end
  
  def random_candidate(hash_size)
    "#{hash_prefix}#{Array.new(hash_size){rand(hash_size)}.join}"
  end
  
  def hash_prefix
    "BO"
  end
  
  def hash_size
    9
  end
  
  def compute_total
    sum = 0
    order_items.each do |item|
      sum += item.price
    end
    
    self.update_attribute(:total, sum)
    self.total
  end
  
end
