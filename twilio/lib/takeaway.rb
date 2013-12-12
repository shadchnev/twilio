require 'twilio-ruby'

class Takeaway

  attr_accessor :menu, :customer


  def send_text message
    # These should be in env vars
    @account_sid = 'AC43d77607fa6f337a4cff8330401372f5'
    @auth_token = '98aa8b7b7e6a611b8a47de55cd8a7077'
    # set up a client to talk to the Twilio REST API
    @client = Twilio::REST::Client.new(@account_sid, @auth_token)
    @account = @client.account
    @message = @account.sms.messages.create({
      :from => '+441634621074',
      :to => '+447796686972',
      :body => message.to_s})
    puts @message
  end

  @@customer_history ||= []

  # why would you need it? :)
  def self.customer_history
    p @@customer_history
  end

  #object stuff...
  def initialize customer
    @customer = customer
    @@customer_history << @customer
    menu
  end

  # This could be just a constant
  def menu
    @menu = {:Italian, 7.50, :French, 6.75, :Mexican, 8.25, :Indian, 9.00, :Thai, 12.20}
  end

  def total_cost *items
    items = items.flatten
    # well done for using reduce
    # another approach: items.map{|i| @menu[i]}.reduce(:+)
    cost = items.reduce(0) do |cost, item|
      cost += @menu[item]
    end
    cost
  end

  def order *items
    @order = items.inject([]) {|order, item| order << item }
    cost = total_cost items
    send_text "Thanks for your order of #{@order.map(&:to_s).flatten} #{@customer}. It should arrive before #{Time.now.hour+1}: #{Time.now.min} and will cost you the bargain price of sum of £#{cost}0"
  end

end
# Don't do this in a class
Takeaway.new('Tom').order(:Italian, :Thai)
