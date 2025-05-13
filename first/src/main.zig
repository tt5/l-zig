const std = @import("std");
pub const foo = @import("foo.zig");

fn fibonacci(n: u16) u16 {
    if (n == 0 or n == 1) return n;
    return fibonacci(n-1) + fibonacci(n-2);
}


pub fn main() !void {

    const allocator = std.heap.page_allocator;
    const ArrayList = std.ArrayList;
    var list = ArrayList(u8).init(allocator);
    defer list.deinit();
    try list.append('A');
    try list.appendSlice("bc");
    std.debug.print("{s}\n", .{list.items});

    const bytes_written = try list.writer().write(
            "hello"
        );
    std.debug.print("{d} {any}\n", .{bytes_written, list.items});

    const stdout = std.io.getStdOut();
    try stdout.writer().print(
        "stdout\n", .{}
        );

    const Place = struct { lat: f32, long: f32 };

    const parsed = try std.json.parseFromSlice(
        Place,
        allocator,
        \\{ "lat": 40.6, "long": -74.4}
        , .{}
    );
    defer parsed.deinit();
    const place = parsed.value;
    std.debug.print("place: {d}\n", .{place.lat});
    try std.json.stringify(place, .{}, list.writer());
    std.debug.print("{s}\n", .{list.items});


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

    var data = [_]u8{ 1, 2, 3};
    for (&data) |*v| {
        v.* +=1;
    }
    std.debug.print("data: {} {} {}\n", .{data[0], data[1], data[2]});

    const binary: u8 = 0b00000001;
    std.debug.print("{}\n", .{binary});

}

const expect = std.testing.expect;

test "it works" {
    try expect(true);
}
