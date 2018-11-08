class EpicsController < ApplicationController

  def index
    @epics = Epic.where(id: 8)
  end
end
