class ReservationMailer < ApplicationMailer
  default from: 'info@example.com'
  def complete
    @reservation = params[:reservation]
    mail(to: @reservation.email, subject: "予約完了メールです")
  end
end
