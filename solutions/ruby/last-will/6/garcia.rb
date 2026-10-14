module Garcia

  extend BankRules

  BASE = 4_023

  module Red

    extend self

    def code_fragment
      118
    end

  end

  module Blue

    extend self

    def code_fragment
      923
    end

  end

end
