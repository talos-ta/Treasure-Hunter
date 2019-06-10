require 'curses'
require './monster.rb'
require './hunter.rb'
require './treasure.rb'
require './medicine.rb'
include Curses

# 階数
STAGE = 10
# タイマーの回復量
RESTORE_NUM = 50
# タイマーの初期設定
TIME_INIT = 100

# 初期設定
init_screen
curs_set(0)
noecho()
cbreak()
stdscr.keypad(true)

key = ''
game_over = false
timer = TIME_INIT

# スタート画面
title = "~Treasure Hunter~"
setpos(lines / 2.5, (cols - 1 - title.length) / 2)
addstr(title)
message = "Enter to Start"
setpos(lines / 1.5, (cols - 1 - message.length) / 2)
addstr(message)
refresh
while key == ''
    key = getch
end

hunter = Hunter.new
monster = Array.new
treasure = Array.new
medicine = Medicine.new

for stage in 0...STAGE
    # 集めた宝の個数
    treasure_num = 0

    # 開始画面
    clear
    message = "Stage " + (stage + 1).to_s
    setpos((lines - 1) / 2, (cols - 1 - message.length) / 2)
    addstr(message)
    refresh
    sleep(3)
    clear
    
    hunter.set_center
    treasure << Treasure.new
    monster << Monster.new
    for num in 0..stage
        monster[num].appear
        treasure[num].reset
    end
    refresh

    while key != 'q'
        # ステージ、タイマー、宝を何個取ったかフッターに表示
        separation = ''
        for i in 0...cols
            separation += '-'
        end
        setpos(lines - 2, 0)
        addstr(separation)
        footer = "Stage " + (stage + 1).to_s + " | Time " + "%3d" % timer  + " | Treasure "
        treasure_num.times do
            footer += '* '
        end
        setpos(lines - 1, 0)
        addstr(footer)

        # キー操作をするたびにタイマー減少
        timer -= 1 if key = getch

        hunter_pos = hunter.move(key)

        for num in 0..stage 
            treasure_num += 1 if treasure[num].gotten(hunter_pos)
            treasure[num].appear
            monster[num].move(hunter_pos)
        end

        # 回復薬を取るとタイマーが増加
        if medicine.gotten(hunter_pos)
            timer += RESTORE_NUM 
            medicine.reset
        end
        medicine.appear

        refresh

        # ステージ数と同じ数の宝を取ると次ステージへ
        if treasure_num == stage + 1
            timer += 100
            break
        end

        # 敵に捕まったらゲームオーバー
        for num in 0..stage
            if monster[num].catch_hunter(hunter_pos)
                game_over = true
                break
            end
        end

        # タイマーが0になってもゲームオーバー
        game_over = true if timer <= 0

        # 終了画面       
        if game_over
            clear
            message = "Game over"
            setpos((lines - 1) / 2, (cols - 1 - message.length) / 2)
            addstr(message)
            refresh
            sleep(5)
            break
        end
    end

    break if game_over || key == 'q'
end

# クリア画面
unless game_over || key == 'q'
    clear
    message = "Game clear!"
    setpos((lines - 1) / 2, (cols - 1 - message.length) / 2)
    addstr(message)
    refresh
    sleep(5)
end

close_screen