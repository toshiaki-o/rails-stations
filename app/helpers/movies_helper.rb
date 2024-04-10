module MoviesHelper
  def select_date_oneweek
    (0..7).map {|n| [(Date.current + n)]}
  end
end
