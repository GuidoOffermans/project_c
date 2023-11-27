const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    var exe_options = std.build.ExecutableOptions{
        .name = "hello_world",
        .target = target,
        .optimize = optimize,
    };
    var exe = b.addExecutable(exe_options);

    exe.addCSourceFile(.{ .file = .{ .path = "src/main.cpp" }, .flags = &.{ "-std=c++20", "-I", "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin", "-I", "/usr/local/include" } });
    exe.linkSystemLibrary("c++");
    exe.linkSystemLibrary("raylib");

    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
