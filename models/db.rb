
require './lib/axlogger'

class Db < ActiveRecord::Base
  self.abstract_class = true

  @@logger = AxLogger.new.logger
end
