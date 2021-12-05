# variable prefixes:
# s_: set-like array
# n_: array of numbers
# l_: list-like arrays
function add_number_to_board(board, number, row, col) {
    s_board_numbers[board, number] = number
    s_board_columns[board, col, number] = number
    s_board_rows[board, row, number] = number
    n_board_cols_unmarked_nums[board, col]++
    n_board_rows_unmarked_nums[board, row]++
    n_board_numbers_grid[board, row, col] = number
    s_board_remaining[board] = board
}

# Useful for debugging
function print_board(board,    num) {
    printf "Numbers for board %s:\n", board
    for (r = 1; r <= 5; r++) {
        for (c = 1; c <= 5; c++) {
            num = n_board_numbers_grid[board, r, c]
            if ((board, num) in s_board_numbers)
                printf "%4s ", num
            else
                printf "(%2s) ", num
        }
        printf ": %s\n", n_board_rows_unmarked_nums[board, r]
    }
}

function is_winner(board,    i) {
    for (i = 1; i <= 5; i++) {
        if (n_board_cols_unmarked_nums[board, i] == 0 || n_board_rows_unmarked_nums[board, i] == 0) {
            return 1
        }
     }
     return 0
}
function mark(num,    b, i) {
    print "marking number " num
    for (b in s_board_remaining) {
        for (i = 1; i <= 5; i++) {
            if ((b, i, num) in s_board_columns) {
                n_board_cols_unmarked_nums[b, i]--
            }
            if ((b, i, num) in s_board_rows) {
                n_board_rows_unmarked_nums[b, i]--
            }
        }
        if ((b, num) in s_board_numbers) {
            delete s_board_numbers[b, num]
        }
        if (is_winner(b) == 1) {
            delete s_board_remaining[b]
            print "found winner: " b
            l_add(l_winners, b)
            l_add(l_winners_draw, num)
        }
    }
}

function score(board, called,    bn, result) {
    for (bn in s_board_numbers) {
        # idiom to get the indices back from an array key. 
        # see https://www.gnu.org/software/gawk/manual/gawk.html#Scanning-Multidimensional-Arrays
        split(bn, separate, SUBSEP)
        if (separate[1] == board) {
            result += separate[2]
        }
    }
    return result * called
}

## Support functions
# adds an item to an list-like array
function l_add(list, item,    l_len) {
    l_len = length(list)
    list[++l_len] = item
}

# returns the las element of a list-like array
function l_last(list) {
    return list[length(list)]
}

BEGIN {
    FS = ","
}

NR == 1 {
    for (i = 1; i <= NF; i++) {
        l_add(l_numbers, $i)
    }
    FS = " "
}

$0 == "" {
    current_board++
    current_row = 1
}

NR > 1 && $0 != "" {
    for (i = 1; i <= NF; i++) {
        add_number_to_board(current_board, $i, current_row, i)
    }
    current_row++
}

END {
    print "total boards: " length(s_board_remaining)
    printf "numbers to draw: "
    for (i = 1; i <= length(l_numbers); i++) {
        printf "%s, ", l_numbers[i]
    }
    printf "\n"
    
    for (i = 1; i <= length(l_numbers); i++) {
        print "boards in play: " length(s_board_remaining)
        number = l_numbers[i]
        print "drew number: " number
        mark(number)
        if (length(s_board_remaining) > 0) {
            print "boards in play after draw: " length(s_board_remaining)
        } else {
            break
        }
    }
    last_winner = l_last(l_winners)
    last_winner_draw = l_last(l_winners_draw)
    printf "board %s won last with number %s, score %s\n", last_winner, last_winner_draw, score(last_winner, last_winner_draw)
}
