const std = @import("std");

pub fn main() !void {
    for (1..5) |val| {
        std.debug.print("{d}\n", .{val});
    }
}
