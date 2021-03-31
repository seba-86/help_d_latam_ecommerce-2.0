require "test_helper"

class OrderTest < ActiveSupport::TestCase
  
  test 'creates a random number on create' do
    user = users(:one)
    order = Order.create(user_id: user.id)
    assert !order.number.nil?
  end

  test 'number must be unique' do 
    user = users(:one)
    order = Order.create(user_id: user.id)
    duplicated_order = order.dup
    assert_not duplicated_order.valid?
  end

  test 'adds products as order_items' do 
    user = users(:one)
    order = Order.create(user_id: user.id)
    product = products(:one)
    order.add_product(product.id, 1)

    assert_equal order.order_items.count, 1
  end

  test "products with zero stock cannot be added to cart" do 
    user = users(:one)
    order = Order.create(user_id: user.id)
    product = products(:two)
    order.add_product(product.id, 1)

    assert_equal order.order_items.count, 0
  end
end
