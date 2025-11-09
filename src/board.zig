const std = @import("std");

const Piece = struct {
    pub const Empty = 0;
    pub const Pawn = 1;
    pub const Knight = 2;
    pub const Bishop = 3;
    pub const Rook = 4;
    pub const Queen = 5;
    pub const King = 6;

    pub const White = 8; // 0b1000
    pub const Black = 16; // 0b10000
};

// 10101
// 00111
//

const Board = struct {
    squares: [64]u8,

    fn init() Board {
        var board: [64]u8 = .{Piece.Empty} ** 64;

        board[0] = Piece.White | Piece.Knight;
        board[63] = Piece.Black | Piece.Queen;
        board[7] = Piece.Black | Piece.Knight;

        return Board{ .squares = board };
    }

    fn print(self: *Board) void {
        // for (self.squares) |a| {
        //     std.debug.print("{d}", .{a});
        // }

        for (0..8) |file| {
            for (0..8) |rank| {
                std.debug.print(" {d} ", .{self.squares[file * 8 + rank]});
            }
            std.debug.print("\n", .{});
        }
    }

    // bitwise witchcraft
    fn get_piece(piece: u8) u8 {
        return piece & 0b111; 
    }

    fn get_color(piece: u8) u8 {
        return piece & 0b11000;
    }
};
pub fn main() !void {
    var board = Board.init();
    Board.print(&board);

    const random_piece = board.squares[63];
    std.debug.print("{d}\n", .{Board.get_color(random_piece)});
    std.debug.print("{d}", .{Board.get_piece(random_piece)});
}
