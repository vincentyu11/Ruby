board = Array.new(8){Array.new(8, 0)}

def printboard(board)
    board.each.each do |row|
        print row
        print "\n"
    end
end

def checkifsafe(board, row, column)
    #check if there is a queen above
    for i in 0..row-1
        if board[i][column] == 1
            return false
        end
    end

    #check if there is a queen in upper-left diagonal
    a1 = Array.new
    b1 = Array.new
    for i in (row).downto(0)
        a1.append(i)
    end
    for i in (column).downto(0)
        b1.append(i)
    end
    c1 = Array[]
    if a1.length() > b1.length()
        c1 = a1.zip(b1)
        until c1.length() == b1.length()
            c1.pop()
        end
        c1.each do |r, c|
            if board[r][c] == 1
                return false
            end
        end
    elsif b1.length() > a1.length()
        c1 = b1.zip(a1)
        until c1.length() == a1.length()
            c1.pop()
        end
        c1.each do |r, c|
            if board[c][r] == 1
                return false
            end
        end
    else
        c1 = a1.zip(b1)
        c1.each do |r, c|
            if board[r][c] == 1
                return false
            end
        end
    end
    
    #check if there is a queen in upper-right diagonal
    a2 = Array.new
    b2 = Array.new
    for i in (row).downto(0)
        a2.append(i)
    end
    for i in column..7
        b2.append(i)
    end
    c2 = Array[]
    if a2.length() > b2.length()
        c2 = a2.zip(b2)
        until c2.length() == b2.length()
            c2.pop()
        end
        c2.each do |r, c|
            if board[r][c] == 1
                return false
            end
        end
    elsif b2.length() > a2.length()
        c2 = b2.zip(a2)
        until c2.length() == a2.length()
            c2.pop()
        end
        c2.each do |r, c|
            if board[c][r] == 1
                return false
            end
        end
    else
        c2 = a2.zip(b2)
        c2.each do |r, c|
            if board[r][c] == 1
                return false
            end
        end
    end


    return true
end

def placequeen(board, row)
    #if all queens are safely placed return true
    if row >= 8
        return true
    end
    #iterate through each column in the row
    for i in 0..7
        #check if you can place queen
        safe = checkifsafe(board,row,i)
        if safe == true
            #place queen
            board[row][i] = 1
            #recursive call place queen in next row
            nextrow = placequeen(board, row + 1)
            if nextrow == true
                return true
            end
            #backtrack
            board[row][i] = 0
        end
    end
    return false
end

#run algorithm and print solution
placequeen(board, 0)
printboard(board)
