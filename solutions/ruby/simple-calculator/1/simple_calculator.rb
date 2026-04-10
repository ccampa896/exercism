class SimpleCalculator
  class UnsupportedOperation < StandardError; end
  ALLOWED_OPERATIONS = ['+', '/', '*'].freeze

  def self.calculate(first_operand, second_operand, operation)
    raise UnsupportedOperation, "Unsupported operation" unless ALLOWED_OPERATIONS.include?(operation)
    raise ArgumentError, "Invalid argument type" unless first_operand.is_a?(Numeric) && second_operand.is_a?(Numeric)
    raise ZeroDivisionError, "Division by zero is not allowed." if operation == '/' && second_operand == 0

    result =
      case operation
      when '+' then first_operand + second_operand
      when '*' then first_operand * second_operand
      when '/' then first_operand / second_operand
      end

    "#{first_operand} #{operation} #{second_operand} = #{result}"
    rescue ZeroDivisionError => e
      e.message
  end
end
