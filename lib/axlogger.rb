require 'yell'

levels = [:debug, :info, :warn, :error, :fatal]
Yell.new :stdout, { 
  :name => 'AxLogger', 
  :format => Yell.format( "%L -- %d -- (F. <%f>:M. <%M>:L. <%n>) -- %m --", "[%d/%m/%y %H:%M:%S]" ), 
  :level => levels, :trace => levels }

class AxLogger;  include Yell::Loggable; end
