class FieldsController < ApplicationController
  def new
    @group = Group.find(params[:group_id])
    @klass = Klass.find(params[:klass_id])
    @field = @klass.fields.new
  end

  def create
    ActiveRecord::Base.transaction do
      field = Field.build(field_params)
      if field.save
        field.create_column
        @klass = field.klass
        flash[:notice] = 'Field Successfully added.'
      else
        flash[:alert] = field.errors.full_messages.join(',')
      end
    rescue StandardError => e
    end
    # Todo: Make JS response
    redirect_to "#{request.referrer}##{@klass&.name&.underscore}"
  end

  def edit
    @group = Group.find(params[:group_id])
    @field = Field.unscoped.find(params[:id])
    @klass = @field.klass
  end

  def update
    @field = Field.unscoped.find(params[:id])
    @klass = @field.klass
    if @field.update(field_params)
      flash[:notice] = 'Field Successfully updated.'
    else
      flash[:alert] = @field.errors.full_messages.join(',')
    end
    # Todo: Make JS response
    redirect_to "#{request.referrer}##{@klass&.name&.underscore}"
  end

  def destroy
    ActiveRecord::Base.transaction do
      field = Field.unscoped.find(params[:id])
      @klass = field.klass
      field.klass.fields.where(klass: @klass).where('position > (?)', field.position).each do |field|
        field.update(position: field.position - 1)
      end
      field.destroy
    rescue StandardError => e
    end
    # Todo: Make JS response
    redirect_to "#{request.referrer}##{@klass&.name&.underscore}"
  end

  def change_position
    ActiveRecord::Base.transaction do
      @klass = Klass.find(params[:klass_id])
      group = Group.find(params[:group_id])
      params[:field_ids].each_with_index do |field_id, position|
        Field.unscoped.find(field_id).update(position: position, group: group)
      end
    rescue StandardError => e
    end
    @groups = @klass.groups.includes(:fields)
  end

  def change_position_in_table
    ActiveRecord::Base.transaction do
      klass = Klass.find(params[:klass_id])
      field = Field.unscoped.find(params[:field_id])
      details = params[:details]
      from = details[:from].to_i
      to = details[:to].to_i
      if from > to
        current_user.field_preferences_of_klass(klass: klass)
                    .where('position_in_table >= ? AND position_in_table < ?', to, from)
                    .each do |field_preference|
          field_preference.update(position_in_table: field_preference.position_in_table + 1)
        end
      elsif to > from
        current_user.field_preferences_of_klass(klass: klass)
                    .where('position_in_table > ? AND position_in_table <= ?', from, to)
                    .each do |field_preference|
          field_preference.update(position_in_table: field_preference.position_in_table - 1)
        end
      end
      field.user_preference(user: current_user).update(position_in_table: to)
    rescue StandardError => e
    end
  end

  def toggle_visible_in_table
    @klass = Klass.find(params[:klass_id])
    @field = Field.unscoped.find(params[:field_id])
    if params[:visible_in_table] == 'true'
      @field.user_preference(user: current_user).make_visible_in_table
    else
      @field.user_preference(user: current_user).make_invisible_in_table
    end
  end

  # TODO: Maybe this is useless
  def change_header_view; end

  def change_properties
    @field = Field.unscoped.find(params[:id])
    @field.update_attribute(params[:property_name], !@field.send(params[:property_name]))
    flash[:alert] = "Field #{@field.name}'s property was changed"
  end

  private

  def field_params
    params.require(:field).permit(:name, :label, :column_type, :klass_id, :position, :placeholder, :min_length,
                                  :max_length, :default_value, :info, :required, :quick_create, :key_field_view, :visible_in_table, :mass_edit, :group_id, :custom, :is_active)
  end
end
