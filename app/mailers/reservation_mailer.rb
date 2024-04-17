class ReservationMailer < ApplicationMailer
  default from: 'info@example.com'
  def complete
    @reservation = params[:reservation]
    mail(to: @reservation.email, subject: "予約完了メールです")
  end

  def reminder
    @reservation = params[:reservation]
    mail(to: @reservation.email, subject: "予約前日の確認メールです")
  end
end
