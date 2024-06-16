const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

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

    if (b.lazyDependency("aro", .{
        .target = target,
        .optimize = optimize,
    })) |dep| {
        lib.root_module.addImport("aro", dep.module("aro"));
    }

    lib.root_module.addImport("mecha", mecha_mod);

    b.installArtifact(lib);
}
