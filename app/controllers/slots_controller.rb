class SlotsController < ApplicationController
  before_action :set_slot, only: %i[show ]

  # GET /slots
  def index
    @slots = Slot.all
    render json: { slots: SlotSerializer.new(@slots).serializable_hash }
  end

  # GET /slots/1
  def show
    render json: { slots: SlotSerializer.new(@slot).serializable_hash }
  end

  # POST /slots]
  def create
    slot_creator = SlotCreator.new(slot_params).call
    if slot_creator
      render json: { slot: SlotSerializer.new(slot_creator).serializable_hash },
             status: :created,
             location: slot_creator
    else
      render json: slot_creator.errors.messages, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_slot
    @slot = Slot.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def slot_params
    params.fetch(:slot, {})
  end
end
