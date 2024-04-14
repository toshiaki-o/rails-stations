module Admin::ReservationsHelper
  def sheet_list
    Sheet.all.map { |sheet| ["#{sheet.row}-#{sheet.column}", sheet.id] }
  end
end
