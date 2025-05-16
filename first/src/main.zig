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

    const allocator2 = std.heap.page_allocator;
    const Point = struct { x: i32, y: i32 };

    //var map = std.StringHashMap(enum { cool, uncool }).init(
    var map = std.AutoHashMap(u32, Point).init(
        allocator2,
    );
    defer map.deinit();

    try map.put(1525, .{ .x = 1, .y = -4 });
    try map.put(1550, .{ .x = 2, .y = -3 });
    const old = try map.fetchPut(1550, .{ .x = 3, .y = -3 });

    var sum = Point{ .x = 0, .y = 0 };
    var iterator = map.iterator();

    while (iterator.next()) |entry| {
        sum.x += entry.value_ptr.x;
        sum.y += entry.value_ptr.y;
    }

    std.debug.print("hashmap: {any} {any} old: {any}\n", .{sum.x, sum.y, old});

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

    var data = [_]u8{ 3, 1, 2};
    std.mem.sort(u8, &data, {}, std.sort.asc(u8));
    for (&data) |*v| {
        v.* +=1;
    }
    std.debug.print("data: {} {} {}\n", .{data[0], data[1], data[2]});

    const binary: u8 = 0b00000001;
    std.debug.print("{}\n", .{binary});

    const text = "one, two";
    var iter = std.mem.tokenizeSequence(u8, text, ", ");
    
    std.debug.print("iter: {?s} {?s} {?s}\n",
        .{
            iter.next(),
            iter.next(),
            iter.next()
        });

}

const expect = std.testing.expect;

test "it works" {
    try expect(true);
}
