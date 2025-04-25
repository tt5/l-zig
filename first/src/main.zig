const std = @import("std");
pub const foo = @import("foo.zig");

fn fibonacci(n: u16) u16 {
    if (n == 0 or n == 1) return n;
    return fibonacci(n-1) + fibonacci(n-2);
}


pub fn main() !void {

    defer std.debug.print("{}\n", .{fibonacci(10)});
    defer std.debug.print("{}\n", .{fibonacci(11)});
    std.debug.print("hello2 {s}\n", .{foo.bar});

    const array = [_]u8{ 'a', 'b', 'c' };
    const slice = array[0..2];

    for (array, 0..) |e, i| {
        std.debug.print("{} {c}\n", .{i,e});
    }

    for (slice) |v| {
        std.debug.print("slice elem: {c}\n", .{v});
    }

}

const expect = std.testing.expect;

test "it works" {
    try expect(true);
}
