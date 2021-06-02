class GroupsController < ApplicationController
  before_action :authenticate_user!

  def new
    @klass = Klass.find(params[:klass_id])
    @group = Group.new
  end

  def edit
    @group = Group.find(params[:id])
    @klass = @group.klass
  end

  def create
    updated_group_params = group_params
    updated_group_params[:name] = updated_group_params[:label]
    @group = Group.new(updated_group_params)
    @group.save
    @klass = @group.klass
    @groups = Group.includes(:fields).where(klass: @klass)
  end

  def update
    @group = Group.find(params[:id])
    @group.update(group_params)
    @klass = @group.klass
    @groups = Group.includes(:fields).where(klass: @klass)
  end

  def change_position
    @klass = Klass.find(params[:klass_id])
    params[:group_ids].reject(&:blank?).each_with_index do |group_id, position|
      Group.find(group_id).update(position: position)
    end
    @groups = @klass.groups.includes(:fields)
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    @klass = @group.klass
    @groups = Group.includes(:fields).where(klass: @klass)
  end

  private

  def group_params
    params.require(:group).permit(Group::PERMITTED_PARAM)
  end
end
