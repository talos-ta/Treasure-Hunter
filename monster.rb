require 'curses'
include Curses

class Monster
    # モンスターがランダムな場所に出現
    def appear
        random = Random.new
        @monster_pos = [random.rand(lines - 3), random.rand(cols - 1)]
        setpos(@monster_pos[0], @monster_pos[1])
        addstr('M')
    end

    # 移動先を決める
    # ハンター方向への単位ベクトルを求めることでハンターを追うように行動
    def move(hunter_pos)
        y = 0
        x = 0

        scalar = Math.sqrt((hunter_pos[0] - @monster_pos[0])**2 + (hunter_pos[1] - @monster_pos[1])**2)
        y = (hunter_pos[0] - @monster_pos[0]) / scalar
        x = (hunter_pos[1] - @monster_pos[1]) / scalar

        setpos(@monster_pos[0], @monster_pos[1])
        addstr(' ')

        @monster_pos[0] += y
        @monster_pos[1] += x
        setpos(@monster_pos[0], @monster_pos[1])
        addstr('M')
    end

    # モンスターがハンターを捕まえたか判定
    def catch_hunter(hunter_pos)
        if (@monster_pos[0] - hunter_pos[0]).abs < 0.5 && (@monster_pos[1] - hunter_pos[1]).abs < 0.5
            return true
        else
            return false
        end
    end
end


