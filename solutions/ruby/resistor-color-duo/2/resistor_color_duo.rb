module ResistorColorDuo

  BANDS = {
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

  def self.value(bands)
    band1, band2 = bands

    (BANDS[band1] * 10) + BANDS[band2]
  end

end
