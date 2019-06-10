require 'curses'
include Curses

class Hunter
    # 初期状態では中心に配置
    def set_center
        @hunter_pos = [(lines - 3) / 2, (cols - 1) / 2]
        setpos(@hunter_pos[0], @hunter_pos[1])
        addstr('@')
    end

    # 移動先を決める
    # 方向キー操作
    def move(key)
        y = 0
        x = 0

        case(key)
        when KEY_UP
            if @hunter_pos[0] > 0
                y -= 1
            else
                y += lines - 3
            end
        when KEY_DOWN
            if @hunter_pos[0] < lines - 3
                y += 1
            else
                y -= lines - 3
            end
        when KEY_LEFT
            if @hunter_pos[1] > 0
                x -= 1
            else
                x += cols - 1
            end
        when KEY_RIGHT
            if @hunter_pos[1] < cols - 1
                x += 1
            else
                x -= cols - 1
            end
        end

        setpos(@hunter_pos[0], @hunter_pos[1])
        addstr(' ')

        @hunter_pos[0] += y
        @hunter_pos[1] += x
        setpos(@hunter_pos[0], @hunter_pos[1])
        addstr('@')

        @hunter_pos
    end
end