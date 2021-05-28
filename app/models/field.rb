class Field < ApplicationRecord
  belongs_to :klass

  has_many :field_picklist_values, dependent: :destroy
  # This is just for temporary purpose
  default_scope { order(created_at: :asc) }

  # 'Skype' => 'text'
  # 'File' => 'file',
  # 'Multi-Select Check Box' => 'text'
  # 'DateTime' => 'datetime',

  TYPE_CAST = { 'Text' => 'text', 'Decimal' => 'decimal', 'Integer' => 'integer', 'Percent' => 'float',
                'Currency' => 'decimal', 'Date' => 'date', 'Email' => 'text', 'Phone' => 'text',
                'Picklist' => 'text', 'URL' => 'text', 'Checkbox' => 'text', 'Text Area HTML' => 'text',
                'Time' => 'time', 'Text Area' => 'text', 'Label' => 'text',
                'Radio Button' => 'string' }.freeze
  PATTERNS =  {
    Text: nil,
    Decimal: '\d+(\.\d+)?',
    Integer: '',
    Percent: '(^100(\.0{1,2})?$)|(^([1-9]([0-9])?|0)(\.[0-9]{1,2})?$)',
    Currency: '/^[0-9]*(\.[0-9]{0,2})?$/',
    Date: '(0[1-9]|1[0-2])\/(0[1-9]|1\d|2\d|3[01])\/(19|20)\d{2}',
    Email: '^.+@.+$',
    Phone: '((\(\d{3}\) ?)|(\d{3}-))?\d{3}-\d{4}',
    Picklist: '//',
    # URL: '[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&\/\/=]*)',
    URL: '/((([A-Za-z]{3,9}:(?:\/\/)?)(?:[-;:&=\+\$,\w]+@)?[A-Za-z0-9.-]+|(?:www.|[-;:&=\+\$,\w]+@)[A-Za-z0-9.-]+)((?:\/[\+~%\/.\w-_]*)?\??(?:[-\+=&;%@.\w_]*)#?(?:[\w]*))?)/',
    Checkbox: '//',
    Text_Area: '//',
    Multi_Select_Combo_Box: '//',
    Skype: '[a-zA-Z][a-zA-Z0-9\.,\-_]{5,31}',
    Time: '((1[0-2]|0?[1-9]):([0-5][0-9]) ?([AaPp][Mm]))',
    field: '\w*',
    DateTime: '//'
  }.freeze

  def is_picklist?
    column_type == 'Picklist'
  end

  def is_date_time?
    column_type == 'DateTime'
  end

  def is_date?
    column_type == 'Date'
  end

  def is_date_or_date_time?
    is_date? || is_date_time?
  end

  def field_picklist_value_of(object)
    field_picklist_values.detect { |field_picklist_value| field_picklist_value.value == object.send(name) }
  end

  # Stands for the field that have values in `FieldPicklistValue`
  def self.field_picklist_valuable
    all.where(column_type: ['Picklist', 'Multi-Select Check Box', 'Radio Button'])
  end

  def create_column
    return if self.column_type == 'File'

    executor = SqlExecutor.new(self.klass.constant)
    executor.create_column(name: self.name, type: TYPE_CAST[self.column_type])
  end

  def destroy_column
    return if self.column_type == 'File'

    executor = SqlExecutor.new(self.klass.constant)
    executor.destroy_column(name: self.name)
  end

  def self.build(params)
    field = Field.new(params)
    field.position = field.klass.fields.any? ? field.klass.fields.pluck(:position).compact.max + 1 : 0
    field.name = Field.snakecase(params[:label])
    # field.have_custom_value = true # TODO: This is wrong we have to remove this
    field
  end

  def snakecase(custom_string)
    custom_string.downcase.gsub(/[^a-z0-9]+/, '_')
  end

  def user_preference(user:)
    user_field_preferences.find_by(user: user)
  end

  # Build field preference for existing users
  def build_user_field_preferences
    User.all.each do |user|
      user_field_preferences.build(user: user)
    end
  end
end
