require 'curses'
include Curses

class Item
    # flg:状態フラグ 0->出現していない 1->出現中 -1->もう出現しない
    # p:出現確率
    def initialize
        @flg = 0
        @item_pos = [0, 0]
        @mark = ''
        @p = 0
    end

    # また出現できるようにする
    def reset
        @flg = 0
    end

    # アイテム出現
    def appear
        random = Random.new
    
        if @flg == 0 && random.rand(@p) == 1
            @item_pos = [random.rand(lines - 1), random.rand(cols - 1)]
            @flg = 1
        end
        
        if @flg == 1
            setpos(@item_pos[0], @item_pos[1])
            addstr(@mark)
        end
    end

    # ハンターに取られたか判定
    def gotten(hunter_pos)
        if (@item_pos[0] - hunter_pos[0]).abs < 1 && (@item_pos[1] - hunter_pos[1]).abs < 1 && @flg == 1
            @flg = 0
            return true
        else
            return false
        end
    end
end