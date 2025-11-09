const std = @import("std");

const Piece = struct {
    pub const Empty = 0;
    pub const Pawn = 1;
    pub const Knight = 2;
    pub const Bishop = 3;
    pub const Rook = 4;
    pub const Queen = 5;
    pub const King = 6;

    pub const White = 8; // 0b01000
    pub const Black = 16; // 0b10000
};

// To decompose apply & 00111 mask
// 10101
// 00111
// 00101

pub const Board = struct {
    squares: [64]u8,

    pub fn init() Board {
        var board: [64]u8 = .{Piece.Empty} ** 64;

        // Black back rank
        board[0] = Piece.Black | Piece.Rook;
        board[1] = Piece.Black | Piece.Knight;
        board[2] = Piece.Black | Piece.Bishop;
        board[3] = Piece.Black | Piece.Queen;
        board[4] = Piece.Black | Piece.King;
        board[5] = Piece.Black | Piece.Bishop;
        board[6] = Piece.Black | Piece.Knight;
        board[7] = Piece.Black | Piece.Rook;

        // Black pawns
        for (0..8) |i| {
            board[8 + i] = Piece.Black | Piece.Pawn;
        }

        // White pawns
        for (0..8) |i| {
            board[48 + i] = Piece.White | Piece.Pawn;
        }

        // White back rank
        board[56] = Piece.White | Piece.Rook;
        board[57] = Piece.White | Piece.Knight;
        board[58] = Piece.White | Piece.Bishop;
        board[59] = Piece.White | Piece.Queen;
        board[60] = Piece.White | Piece.King;
        board[61] = Piece.White | Piece.Bishop;
        board[62] = Piece.White | Piece.Knight;
        board[63] = Piece.White | Piece.Rook;

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
    pub fn get_piece(piece: u8) u8 {
        return piece & 0b111;
    }

    pub fn get_color(piece: u8) u8 {
        return piece & 0b11000;
    }
};
// pub fn main() !void {
//     var board = Board.init();
//     Board.print(&board);

//     const random_piece = board.squares[63];
//     std.debug.print("{d}\n", .{Board.get_color(random_piece)});
//     std.debug.print("{d}", .{Board.get_piece(random_piece)});
// }
