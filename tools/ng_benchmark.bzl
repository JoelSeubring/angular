# Copyright Google Inc. All Rights Reserved.
#
# Use of this source code is governed by an MIT-style license that can be
# found in the LICENSE file at https://angular.io/license
"""Bazel macro for running Angular benchmarks"""

load("@build_bazel_rules_nodejs//:defs.bzl", "nodejs_binary")

def ng_benchmark(name, bundle):
    """

    This macro creates two targets, one that is runnable and prints results and one that can be used for profiling via chrome://inspect.

    Args:
      name: name of the runnable rule to create
      bundle: label of the ng_rollup_bundle to run
    """

    nodejs_binary(
        name = name,
        data = [bundle],
        entry_point = bundle + ".min_debug.es2015.js",
        tags = ["local"],
    )

    nodejs_binary(
        name = name + "_profile",
        data = [bundle],
        entry_point = bundle + ".min_debug.es2015.js",
        args = ["--node_options=--no-turbo-inlining --node_options=--inspect-brk"],
        tags = ["local"],
    )
