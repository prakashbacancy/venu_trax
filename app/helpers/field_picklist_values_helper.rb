module FieldPicklistValuesHelper
  def klass_option(klasses)
    klasses.collect { |klass| [klass.label.gsub(/(?<=[a-z])(?=[A-Z])/, ' '), klass.id] }
  end
end
