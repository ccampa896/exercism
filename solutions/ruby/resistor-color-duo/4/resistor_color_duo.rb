module ResistorColorDuo

  BAND = {
    'black'  => 0,
    'brown'  => 1,
    'red'    => 2,
    'orange' => 3,
    'yellow' => 4,
    'green'  => 5,
    'blue'   => 6,
    'violet' => 7,
    'grey'   => 8,
    'white'  => 9
  }

  def self.value(colors)
    colors.take(2).reverse.each_with_index.sum do |color, index|
      BAND[color] * 10**index
    end
  end

end
