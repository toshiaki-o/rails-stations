namespace :remind_mail do
  desc '前日メール配信'
  task reminder: :environment do
    reservations = Reservation.where(date: Time.current.tomorrow)
    reservations.each do |reservation|
      ReservationMailer.with(reservation: reservation).reminder.deliver_now
    end
  end
end
