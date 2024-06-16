const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const clap_mod = b.dependency("clap", .{
        .target = target,
        .optimize = optimize,
    }).module("clap");

    const mecha_mod = b.dependency("mecha", .{
        .target = target,
        .optimize = optimize,
    }).module("mecha");

    const lib = b.addStaticLibrary(.{
        .name = "zig-20313-repro",
        .root_source_file = b.path("src/root.zig"),
        .target = target,
        .optimize = optimize,
    });

    lib.root_module.addImport("clap", clap_mod);
    lib.root_module.addImport("mecha", mecha_mod);

    b.installArtifact(lib);
}
