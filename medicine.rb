require 'curses'
require './item.rb'
include Curses

class Medicine < Item
    def initialize
        super
        @mark = '+'
        @p = 15
    end
end