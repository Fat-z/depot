require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  fixtures :products

  # test "the truth" do
  #   assert true
  # end
  test "buy a product" do
    LineItem.delete_all
    Order.delete_all
    ruby_book = products(:ruby)
    user = User.create(name: 'lc',
                        password: '123',
                        password_confirmation: '123',
                        identity: 'customer'
                      )
    
    assert_equal user.name, 'lc'
    
    get "/login"
    assert_response :success
    post_via_redirect "login", :name => user.name, :password => user.password
    assert_response :success
    assert_equal '/admin', path
    
    get "/"
    assert_response :success
    assert_template "index"    
    assert_not_nil(session[:cart_id])

    cart = Cart.find(session[:cart_id])
    xml_http_request :post, '/line_items', product_id: ruby_book.id, cart_id: cart.id
    assert_response :success
    
    assert_equal 1, cart.line_items.size
    assert_equal ruby_book, cart.line_items[0].product
   
    get "orders/new"
    assert_response :success
    assert_template "new"     
    #assert_redirected_to store_path
    #assert_equal flash[:notice], 'Your cart is empty'

    post_via_redirect "/orders",
                    order: {  name:     "Dave Thomas",
                              address:  "123 The Street",
                              email:    "dave@example.com",
                              pay_type: "Check" }
    assert_response :success
    assert_template "index"
    cart = Cart.find(session[:cart_id])
    assert_equal 0, cart.line_items.size

    orders = Order.all
    assert_equal 1, orders.size
    order = orders[0]

    assert_equal "Dave Thomas",       order.name
    assert_equal "123 The Street",    order.address
    assert_equal "dave@example.com",  order.email
    assert_equal "Check",             order.pay_type

    assert_equal 1, order.line_items.size
    line_item = order.line_items[0]
    assert_equal ruby_book, line_item.product

    mail = ActionMailer::Base.deliveries.last
    assert_equal ["dave@example.com"], mail.to
    assert_equal 'Sam Ruby <depot@example.com>', mail[:from].value
    assert_equal "Pragmatic Store Order Confirmation", mail.subject  
  end 
end

