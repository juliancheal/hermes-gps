require "celluloid"
require "scanner"

module Hermes
  module GPS
    class Superviser < Celluloid::SupervisionGroup
      supervise Hermes::GPS::Scanner, as: :scanner
    end
  end
end
