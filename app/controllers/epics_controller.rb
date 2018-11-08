class EpicsController < ApplicationController

  def index
    @epics = Epic.where(id: 3)
  end
end
