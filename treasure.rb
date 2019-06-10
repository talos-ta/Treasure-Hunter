require 'curses'
require './item.rb'
include Curses

class Treasure < Item
    def initialize
        super
        @mark = '*'
        @p = 20
    end

    # ハンターに取られたか判定
    # 一度取られた宝が再出現しないようにオーバーライド
    def gotten(hunter_pos)
       if (@item_pos[0] - hunter_pos[0]).abs < 1 && (@item_pos[1] - hunter_pos[1]).abs < 1 && @flg == 1
            @flg = -1
            return true
        else
            return false
        end
    end
end