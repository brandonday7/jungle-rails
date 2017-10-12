class UserMailer < ApplicationMailer
  default from: 'no-reply@jungle.com'

  def confirmation_email(user, order)
    @user = user
    @order = order
    @url  = 'https://www.youtube.com/watch?v=dQw4w9WgXcQ'
    mail(to: @user.email, subject: "Your Recent Order (Order ID: #{order.id})")
  end
end
