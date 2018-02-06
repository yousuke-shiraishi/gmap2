class BirthFormatValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.nil? or !date_valid?(value)
      record.errors[attribute] << (options[:message] || '生年月日を入力してください')
    end
  end
end
