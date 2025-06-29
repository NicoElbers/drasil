pub fn build(b: *Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    updateHtmlDataZonStep(b, target, optimize) orelse return;
    updateHtmlDataStep(b, target, optimize);

    const drasil_mod = b.addModule("drasil", .{
        .root_source_file = b.path("src/root.zig"),
        .optimize = optimize,
        .target = target,
    });

    const filters = b.option([]const []const u8, "test-filter", "Skip tests that do not match any filter") orelse &.{};
    const drasil_tests = b.addTest(.{
        .root_module = drasil_mod,
        .filters = filters,
    });
    const run_drasil_tests = b.addRunArtifact(drasil_tests);

    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_drasil_tests.step);
}

fn updateHtmlDataStep(b: *Build, target: Target, optimize: Optimize) void {
    const step = b.step("html_data", "Update the automatically generated HtmlNode.zig");

    const mod = b.createModule(.{
        .root_source_file = b.path("tools/gen_html_data.zig"),
        .optimize = optimize,
        .target = target,
    });

    const exe = b.addExecutable(.{
        .name = "generate_html_data",
        .root_module = mod,
    });

    const run = b.addRunArtifact(exe);

    // assert(args.len == 5); // {self} {elements zon} {attributes zon} {html_data file} {Tree file}
    run.addFileArg(b.path("tools/html_elements.zon"));
    run.addFileArg(b.path("tools/html_attributes.zon"));
    run.addFileArg(b.path("src/html_data.zig"));
    run.addFileArg(b.path("src/Tree.zig"));

    step.dependOn(&run.step);
}

fn updateHtmlDataZonStep(b: *Build, target: Target, optimize: Optimize) ?void {
    const step = b.step("html_zon", "Update the automatically generated HtmlNode.zig");

    const compat_data = b.lazyDependency("browser-compat-data", .{}) orelse return null;

    const mod = b.createModule(.{
        .root_source_file = b.path("tools/gen_html_data_zon.zig"),
        .optimize = optimize,
        .target = target,
    });

    const exe = b.addExecutable(.{
        .name = "generate_html_data_zon",
        .root_module = mod,
    });

    const run = b.addRunArtifact(exe);

    // assert(args.len == 4); // {self} {html_dir} {elements zon} {attributes zon}
    run.addDirectoryArg(compat_data.path("html"));
    run.addFileArg(b.path("tools/html_elements.zon"));
    run.addFileArg(b.path("tools/html_attributes.zon"));

    step.dependOn(&run.step);
}

const std = @import("std");

const Build = std.Build;
const Target = Build.ResolvedTarget;
const Optimize = std.builtin.Mode;
