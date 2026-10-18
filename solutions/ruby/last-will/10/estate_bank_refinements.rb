require_relative 'bank_rules'
require_relative 'zhang'
require_relative 'khan'
require_relative 'garcia'

module EstateBankRefinements

  refine Zhang.singleton_class do
    import_methods BankRules
  end

  refine Khan.singleton_class do
    import_methods BankRules
  end

  refine Garcia.singleton_class do
    import_methods BankRules
  end

end
