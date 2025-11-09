const rl = @import("raylib");
const board = @import("./board.zig");
const std = @import("std");

pub fn main() anyerror!void {
    // Screen
    const screenWidth = 1000;
    const screenHeight = 600;

    // Board design
    const squareSize: i32 = 60;
    const startX: i32 = 200;
    const startY: i32 = 100;
    var squareCol: u1 = 0;
    const colBlack = rl.Color.init(183, 192, 216, 255);
    const colWhite = rl.Color.init(233, 237, 249, 255);

    // Game state
    const game_board = board.Board.init();

    rl.initWindow(screenWidth, screenHeight, "Chess Coding Adventure");
    defer rl.closeWindow();

    rl.setTargetFPS(60);

    // Main game loop
    while (!rl.windowShouldClose()) {
        // Update

        // Draw
        //----------------------------------------------------------------------------------
        rl.beginDrawing();
        defer rl.endDrawing();

        rl.clearBackground(.white);

        // void DrawRectangle(int posX, int posY, int width, int height, Color color);

        rl.drawText("Chess", 450, 0, 50, rl.Color.init(53, 55, 77, 255));
        rl.drawText("Fen String: rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1", 100, 60, 20, rl.Color.init(123, 97, 254, 255));

        for (0..8) |i| {
            squareCol = @as(u1, @intCast(i % 2));
            for (0..8) |j| {
                const infered_X = startX + @as(i32, @intCast(i)) * squareSize;
                const infered_Y = startY + @as(i32, @intCast(j)) * squareSize;

                const infered_center_X = infered_X + squareSize / 2;
                const infered_center_Y = infered_Y + squareSize / 2;

                const infered_index = i * 8 + j;

                //  print(f"({start+i*step},{start+j*step",end=" ")
                if (squareCol == 0) {
                    rl.drawRectangle(infered_X, infered_Y, squareSize, squareSize, colWhite);
                    squareCol = 1;
                } else {
                    rl.drawRectangle(infered_X, infered_Y, squareSize, squareSize, colBlack);
                    squareCol = 0;
                }

                // std.debug.print("{d}", .{game_board.squares[infered_index]});
                const aa = game_board.squares[infered_index];
                const chess_piece = rl.textFormat("%d", .{aa});

                rl.drawText(chess_piece, infered_center_X, infered_center_Y, 20, .black);
            }
        }
    }
}
