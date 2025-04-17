const std = @import("std");
pub const foo = @import("foo.zig");

fn fibonacci(n: u16) u16 {
    if (n == 0 or n == 1) return n;
    return fibonacci(n-1) + fibonacci(n-2);
}


pub fn main() !void {
    std.debug.print("hello2 {s}\n", .{foo.bar});

    const a = [_]u8{ 'a', 'b' };
    std.debug.print("len: {}\n", .{a.len});

    for (a, 0..) |e, i| {
        std.debug.print("{} {c}\n", .{i,e});
    }

    std.debug.print("{}", .{fibonacci(10)});
}

const expect = std.testing.expect;

test "it works" {
    try expect(true);
}


