module TimeSchedulesHelper
  def genre_icon_with_background_and_color(genre)
    case genre
    when 'ランチ'
      ['fas fa-utensils', 'bg-color-red']
    when 'ディナー'
      ['fas fa-glass-martini-alt', 'bg-color-orange']
    when 'カフェ'
      ['fas fa-coffee', 'bg-color-yellow']
    when 'アクティビティ'
      ['fas fa-running', 'bg-color-green']
    when '観光'
      ['fas fa-landmark', 'bg-color-blue']
    when 'ショッピング'
      ['fas fa-shopping-bag', 'bg-color-purple']
    else
      ['fas fa-ellipsis-h', 'bg-color-gray']
    end
  end
end