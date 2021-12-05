# # Game functions
# mark(number)
# get_winner()
# score(board)
#
# # Data loading functions
# add_number_to_board(board, number, row, col)
#

function add_number_to_board(board, number, row, col) {
    board_numbers[board, number] = number
    board_columns[board, col, number] = number
    board_rows[board, row, number] = number
    board_columns_remaining[board, col]++
    board_rows_remaining[board, row]++
    # printf "added number %s to board %s at row %s col %s\n", number, board, row, col
}

function mark(number) {
    print "marking number " number
    for (b = 1; b <= current_board; b++) {
        #printf "does board %s has number %s? %s\n", b, number, board_numbers[b, number]
        delete board_numbers[b, number]
        # usar in en vez de if
        for (c = 1; c <= 5; c++) {
            # printf "board: %s, col: %s, num: %s\n", b, c, number
            # print "board_columns: " board_columns[b, c, number]
            # print "bc l: " length(board_columns)
            if ((b, c, number) in board_columns) {
             board_columns_remaining[b, c]--
            }
            #printf "%s numbers remaining in board %s, col %s\n", board_columns_remaining[b, c], b, c
        }
        for (r = 1; r <= 5; r++) {
            if ((b, r, number) in board_rows) {
             board_rows_remaining[b, r]--
            }
            #printf "%s numbers remaining in board %s, row %s\n", board_rows_remaining[b, r], b, r
        }
    }
}

function get_winner() {
    for (b = 1; b <= current_board; b++) {
        for (c = 1; c <= 5; c++) {
            # printf "%s numbers remaining in board %s, col %s\n", board_columns_remaining[b, c], b, c
            if (board_columns_remaining[b, c] == 0) {
                return b
            }
        }
        for (r = 1; r <= 5; r++) {
            #printf "%s numbers remaining in board %s, row %s\n", board_rows_remaining[b, r], b, r
            if (board_rows_remaining[b, r] == 0) {
                return b
            }
        }
    }
}

function score(board, called,  bn, result) { 
    for (bn in board_numbers) {
        split(bn, separate, SUBSEP)
        if (separate[1] == board) {
            result += separate[2]
        }
    }
    return result * called
}

BEGIN {
    FS = ","
}

NR == 1 {
    for (i = 1; i <= NF; i++) {
        numbers[i] = $i
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
    for (i = 1; i <= length(numbers); i++) {
        number = numbers[i]
        mark(number)
        winner = get_winner()
        if (winner != "") {
            printf "board %s won, score %s\n", winner, score(winner, number)
            exit
        }
    }
}
