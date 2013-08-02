# encoding: utf-8
class IsDateValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, '不是有效日期') if (Date.parse(value.to_s) rescue ArgumentError) == ArgumentError
  end
end