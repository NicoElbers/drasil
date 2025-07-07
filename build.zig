var check: *Step = undefined;

pub fn build(b: *Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    check = b.step("check", "Checks for all compile errors, without installing binaries");

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
    check.dependOn(&drasil_tests.step);

    const run_drasil_tests = b.addRunArtifact(drasil_tests);

    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_drasil_tests.step);
}

fn updateHtmlDataStep(b: *Build, target: Target, optimize: Optimize) void {
    const step = b.step("html_data", "Update the automatically generated HtmlNode.zig");

    const html_mod = b.createModule(.{
        .root_source_file = b.path("tools/gen_html_data.zig"),
        .optimize = optimize,
        .target = target,
    });

    const html_exe = b.addExecutable(.{
        .name = "generate_html_data",
        .root_module = html_mod,
    });
    check.dependOn(&html_exe.step);

    const html_run = b.addRunArtifact(html_exe);

    // assert(args.len == 4); // {self} {tools dir} {html_data file} {Tree file}
    html_run.addDirectoryArg(b.path("tools/"));
    html_run.addFileArg(b.path("src/html_data.zig"));
    html_run.addFileArg(b.path("src/Tree.zig"));

    step.dependOn(&html_run.step);

    const web_mod = b.createModule(.{
        .root_source_file = b.path("tools/gen_web_data.zig"),
        .optimize = optimize,
        .target = target,
    });

    const web_exe = b.addExecutable(.{
        .name = "generate_web_data",
        .root_module = web_mod,
    });
    check.dependOn(&web_exe.step);

    const web_run = b.addRunArtifact(web_exe);

    // assert(args.len == 3); // {self} {tools dir} {web dir}
    web_run.addDirectoryArg(b.path("tools/"));
    web_run.addDirectoryArg(b.path("src/web/"));

    step.dependOn(&web_run.step);
}

fn updateHtmlDataZonStep(b: *Build, target: Target, optimize: Optimize) ?void {
    const step = b.step("html_zon", "Update the zon files containing HTML data");

    const compat_data = b.lazyDependency("browser-compat-data", .{}) orelse return null;
    const html = b.lazyDependency("html", .{}) orelse return null;

    // Let python create the JSON
    const elements_json_gen = b.addSystemCommand(&.{"python"});
    // const json_gen = b.addSystemCommand(&.{"echo"});
    elements_json_gen.addFileArg(b.path("tools/parse_elements.py"));
    elements_json_gen.addFileArg(html.path("source"));
    elements_json_gen.addFileArg(b.path("tools/html_elements.json"));

    const attributes_json_gen = b.addSystemCommand(&.{"python"});
    // const json_gen = b.addSystemCommand(&.{"echo"});
    attributes_json_gen.addFileArg(b.path("tools/parse_attributes.py"));
    attributes_json_gen.addFileArg(html.path("source"));
    attributes_json_gen.addFileArg(b.path("tools/html_attributes.json"));

    const events_json_gen = b.addSystemCommand(&.{"python"});
    // const json_gen = b.addSystemCommand(&.{"echo"});
    events_json_gen.addFileArg(b.path("tools/parse_events.py"));
    events_json_gen.addFileArg(html.path("source"));
    events_json_gen.addFileArg(b.path("tools/html_events.json"));

    const mod = b.createModule(.{
        .root_source_file = b.path("tools/gen_html_data_zon.zig"),
        .optimize = optimize,
        .target = target,
    });

    const exe = b.addExecutable(.{
        .name = "generate_html_data_zon",
        .root_module = mod,
    });
    check.dependOn(&exe.step);

    const run = b.addRunArtifact(exe);
    run.step.dependOn(&events_json_gen.step); // Generate zon after JSON
    run.step.dependOn(&elements_json_gen.step); // Generate zon after JSON
    run.step.dependOn(&attributes_json_gen.step); // Generate zon after JSON

    // assert(args.len == 3); // {self} {html_dir} {tools dir}
    run.addDirectoryArg(compat_data.path("html"));
    run.addDirectoryArg(b.path("tools/"));

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

    check.dependOn(&counter_exe.step);

    const server_mod = b.createModule(.{
        .root_source_file = b.path("example/example_server.zig"),
        .target = target,
        .optimize = optimize,
    });

    const server_exe = b.addExecutable(.{
        .name = "example_server",
        .root_module = server_mod,
    });
    check.dependOn(&server_exe.step);

    {
        const run_server = b.addRunArtifact(server_exe);
        run_server.addFileArg(counter_exe.getEmittedBin()); // wasm path
        run_server.addFileArg(b.path("example/index.html")); // html path
        run_server.addFileArg(b.path("src/web/init.js")); // js path

        const step = b.step("counter", "Hosts an example counter on localhost:8080");
        step.dependOn(&run_server.step);
    }
}

const std = @import("std");

const Build = std.Build;
const Module = Build.Module;
const Step = Build.Step;
const Target = Build.ResolvedTarget;
const Optimize = std.builtin.Mode;
