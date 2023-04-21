const Build = @import("std").Build;
const zlib = @import("zlib.zig");

pub fn build(b: *Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib = zlib.create(b, target, optimize);

    const zpipe = b.addExecutable(.{
        .name = "zpipe",
        .target = target,
        .optimize = optimize,
    });
    zpipe.addCSourceFile("src/zpipe.c", &[_][]const u8{"-std=c99"});
    zpipe.linkSystemLibrary("c");
    lib.link(zpipe, .{
        .import_name = "zlib",
    });
    b.installArtifact(zpipe);
    b.default_step.dependOn(&zpipe.step);

    const run_cmd = b.addRunArtifact(zpipe);
    const run_step = b.step("run", "Run program");
    run_step.dependOn(&run_cmd.step);

    const gun = b.addExecutable(.{
        .name = "gun",
        .target = target,
        .optimize = optimize,
    });
    gun.addCSourceFile("src/gun.c", &[_][]const u8{"-std=c99"});
    gun.linkSystemLibrary("c");
    lib.link(gun, .{
        .import_name = "zlib",
    });
    b.installArtifact(gun);
    b.default_step.dependOn(&gun.step);
}
