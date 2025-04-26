const std = @import("std");
pub const foo = @import("foo.zig");

fn fibonacci(n: u16) u16 {
    if (n == 0 or n == 1) return n;
    return fibonacci(n-1) + fibonacci(n-2);
}


pub fn main() !void {

    defer std.debug.print("{}\n", .{fibonacci(10)});
    std.debug.print("hello2 {s}\n", .{foo.bar});

    const Numbers = struct { one: i8, two: i8 };
    const myNumbers = Numbers {
        .one = 1,
        .two = 2,
    };
    std.debug.print("{}\n", .{myNumbers.one});

    const array = [_]u8{ 'a', 'b', 'c' };
    const slice = array[0..2];

    for (array, 0..) |e, i| {
        std.debug.print("{} {c}\n", .{i,e});
    }

    for (slice) |v| {
        std.debug.print("slice elem: {c}\n", .{v});
    }

    const binary: u8 = 0b00000001;
    std.debug.print("{}\n", .{binary});

}

const expect = std.testing.expect;

test "it works" {
    try expect(true);
}
