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

    exampleStep(b, drasil_mod, target, optimize);

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

fn exampleStep(b: *Build, drasil: *Module, target: Target, optimize: Optimize) void {
    const wasm_target = b.resolveTargetQuery(.{
        .cpu_arch = .wasm32,
        .os_tag = .freestanding,
        .cpu_features_add = std.Target.wasm.featureSet(&.{ .bulk_memory, .atomics }),
    });

    const counter_mod = b.createModule(.{
        .root_source_file = b.path("example/counter/client.zig"),
        .target = wasm_target,
        .optimize = switch (optimize) {
            .Debug, .ReleaseSafe => optimize,
            .ReleaseFast, .ReleaseSmall => .ReleaseSmall,
        },
        .strip = true,
    });
    counter_mod.addImport("drasil", drasil);

    const counter_exe = b.addExecutable(.{
        .name = "example_counter",
        .root_module = counter_mod,
    });
    counter_exe.import_memory = true;
    counter_exe.rdynamic = true;
    counter_exe.entry = .disabled;

    const server_mod = b.createModule(.{
        .root_source_file = b.path("example/example_server.zig"),
        .target = target,
        .optimize = optimize,
    });

    const server_exe = b.addExecutable(.{
        .name = "example_server",
        .root_module = server_mod,
    });

    {
        const run_server = b.addRunArtifact(server_exe);
        run_server.addFileArg(counter_exe.getEmittedBin()); // wasm path
        run_server.addFileArg(b.path("example/index.html")); // html path
        run_server.addFileArg(b.path("js/init.js")); // js path

        const step = b.step("counter", "Hosts an example counter on localhost:8080");
        step.dependOn(&run_server.step);
    }
}

const std = @import("std");

const Build = std.Build;
const Module = Build.Module;
const Target = Build.ResolvedTarget;
const Optimize = std.builtin.Mode;
