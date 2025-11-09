const rl = @import("raylib");

pub fn main() anyerror!void {
    const screenWidth = 1000;
    const screenHeight = 600;

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

        const squareSize: i32 = 60;
        const startX: i32 = 200;
        const startY: i32 = 30;
        var squareCol: u1 = 0;

        const colBlack = rl.Color.init(183, 192, 216, 255);
        const colWhite = rl.Color.init(233, 237, 249, 255);

        rl.drawText("Chess", 450, 0, 50, rl.Color.init(53, 55, 77, 255));
        rl.drawText("Fen String: rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1", 100, 60, 20, rl.Color.init(123, 97, 254, 255));

        for (1..9) |i| {
            squareCol = @as(u1, @intCast(i % 2));
            for (1..9) |j| {
                //  print(f"({start+i*step},{start+j*step",end=" ")
                if (squareCol == 0) {
                    rl.drawRectangle(startX + @as(i32, @intCast(i)) * squareSize, startY + @as(i32, @intCast(j)) * squareSize, squareSize, squareSize, colWhite);
                    squareCol = 1;
                } else {
                    rl.drawRectangle(startX + @as(i32, @intCast(i)) * squareSize, startY + @as(i32, @intCast(j)) * squareSize, squareSize, squareSize, colBlack);
                    squareCol = 0;
                }
            }
        }
    }
}
