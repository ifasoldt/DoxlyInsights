class EpicsChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'epics'
  end
end
