const rl = @import("raylib");
const board = @import("./board.zig");
const std = @import("std");

fn loadPieceTextures() ![12]rl.Texture {
    const pawn_black = try rl.loadImage("src/resources/pawn_black.png");
    const knight_black = try rl.loadImage("src/resources/knight_black.png");
    const bishop_black = try rl.loadImage("src/resources/bishop_black.png");

    const rook_black = try rl.loadImage("src/resources/rook_black.png");
    const queen_black = try rl.loadImage("src/resources/queen_black.png");
    const king_black = try rl.loadImage("src/resources/king_black.png");

    const pawn_white = try rl.loadImage("src/resources/pawn_white.png");
    const bishop_white = try rl.loadImage("src/resources/bishop_white.png");
    const knight_white = try rl.loadImage("src/resources/knight_white.png");
    const rook_white = try rl.loadImage("src/resources/rook_white.png");
    const queen_white = try rl.loadImage("src/resources/queen_white.png");
    const king_white = try rl.loadImage("src/resources/king_white.png");


    // pub const Pawn = 1;
    // pub const Knight = 2;
    // pub const Bishop = 3;
    // pub const Rook = 4;
    // pub const Queen = 5;
    // pub const King = 6;
    return .{
        try rl.loadTextureFromImage(pawn_white),
        try rl.loadTextureFromImage(knight_white),
        try rl.loadTextureFromImage(bishop_white),
        try rl.loadTextureFromImage(rook_white),
        try rl.loadTextureFromImage(queen_white),
        try rl.loadTextureFromImage(king_white),

        try rl.loadTextureFromImage(pawn_black),
        try rl.loadTextureFromImage(knight_black),
        try rl.loadTextureFromImage(bishop_black),
        try rl.loadTextureFromImage(rook_black),
        try rl.loadTextureFromImage(queen_black),
        try rl.loadTextureFromImage(king_black),
    };
}

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

    // Sprites

    // const bishop_black = rl.loadImage("./resources/bishop_black.png") catch |err| {};
    // const knight_black = rl.loadImage("./resources/knight_black.png") catch |err| {};
    // const rook_black = rl.loadImage("./resources/rook_black.png") catch |err| {};
    // const queen_black = rl.loadImage("./resources/queen_black.png") catch |err| {};
    // const king_black = rl.loadImage("./resources/king_black.png") catch |err| {};

    // const pawn_white = rl.loadImage("./resources/pawn_white.png") catch |err| {};
    // const bishop_white = rl.loadImage("./resources/bishop_white.png") catch |err| {};
    // const knight_white = rl.loadImage("./resources/knight_white.png") catch |err| {};
    // const rook_white = rl.loadImage("./resources/rook_white.png") catch |err| {};
    // const queen_white = rl.loadImage("./resources/queen_white.png") catch |err| {};
    // const king_white = rl.loadImage("./resources/king_white.png") catch |err| {};

    rl.initWindow(screenWidth, screenHeight, "Chess Coding Adventure");
    defer rl.closeWindow();

    const textures = try loadPieceTextures();

    defer for (textures) |texture| {
        rl.unloadTexture(texture);
    };

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

                //  print(f"({start+i*step},{start+j*step",end=" ")
                if (squareCol == 0) {
                    rl.drawRectangle(infered_X, infered_Y, squareSize, squareSize, colWhite);
                    squareCol = 1;
                } else {
                    rl.drawRectangle(infered_X, infered_Y, squareSize, squareSize, colBlack);
                    squareCol = 0;
                }

                // std.debug.print("{d}", .{game_board.squares[infered_index]});
                // const aa = game_board.squares[infered_index];
                // const chess_piece = rl.textFormat("%d", .{aa});

                // rl.drawText(chess_piece, infered_center_X, infered_center_Y, 20, .black);

                // const frameWidth = @as(f32, @floatCast(pawn_black.width/6));
                // const frameHeight =  @as(f32, @floatCast(pawn_black.height));

                // const sourceRec = rl.Rectangle.init(infered_center_X, infered_center_Y, frameWidth, frameHeight);
                // pawn_black_texture.

                const center = rl.Vector2.init(@as(f32, @floatFromInt(infered_center_X - 18)), @as(f32, @floatFromInt(infered_center_Y - 20)));
                const square_bit_number = game_board.squares[j * 8 + i];
                const infered_color = board.Board.get_color(square_bit_number);
                const infered_piece = board.Board.get_piece(square_bit_number);

                if (square_bit_number != 0) {
                    const texture = if (infered_color == 8) textures[infered_piece - 1] else textures[infered_piece + 5];

                    rl.drawTextureEx(texture, center, 0, 0.25, .white);
                }
            }
        }
    }
}
