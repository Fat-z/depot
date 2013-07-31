class SendingNotifier < ActionMailer::Base
  default from: 'Sam Ruby <depot@example.com>'


  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.sending_notifier.sended.subject
  #
  def sended(line_item)
    @line_item = line_item
    @order = Order.find(@line_item.order_id)
    @book_title = Product.find(@line_item.product_id).title 
    @item_number = @line_item.quantity

    mail to: @order.email, subject: 'Pragmatic Store Order Send'
    
  end

  def stockouted(line_item)
    @line_item = line_item
    @order = Order.find(@line_item.order_id)
    @book_title = Product.find(@line_item.product_id).title 
    @item_number = @line_item.quantity


    mail to: @order.email, subject: 'Pragmatic Store Order Stockouted'
  end


end
