#!/usr/bin/env node
"use strict";

/*
 * MCSP 0.8 bootstrap closure evaluator.
 * JSON is only a transport representation at this stage.
 * Exit 0 = structural bootstrap closure PASS.
 * Exit 1 = FAIL.
 */

const fs = require("node:fs");
const path = require("node:path");

const input = process.argv[2] || path.join(__dirname, "foundation-0.8.json");
let model;

try {
  model = JSON.parse(fs.readFileSync(input, "utf8"));
} catch (error) {
  console.error("FAIL_INPUT:", error.message);
  process.exit(1);
}

const foundation = new Set(model.foundation || []);
const definitions = model.definitions || {};
const derived = model.derived || {};
const allDefined = new Set([...Object.keys(definitions), ...Object.keys(derived)]);
const known = new Set([...foundation, ...allDefined]);

const failures = [];
const external = new Set();

for (const name of foundation) {
  if (!Object.hasOwn(definitions, name)) failures.push(`FOUNDATION_UNDEFINED:${name}`);
}

for (const [name, deps] of Object.entries({...definitions, ...derived})) {
  if (!Array.isArray(deps)) {
    failures.push(`DEPENDENCIES_NOT_ARRAY:${name}`);
    continue;
  }
  for (const dep of deps) if (!known.has(dep)) external.add(dep);
}

if (external.size) failures.push(`EXTERNAL_DEPENDENCIES:${[...external].sort().join(",")}`);

const visited = new Set();
const active = new Set();
const cycles = [];

function walk(name, trail = []) {
  if (active.has(name)) {
    const i = trail.indexOf(name);
    cycles.push([...trail.slice(i), name]);
    return;
  }
  if (visited.has(name)) return;
  active.add(name);
  const deps = definitions[name] || derived[name] || [];
  for (const dep of deps) walk(dep, [...trail, name]);
  active.delete(name);
  visited.add(name);
}

for (const name of foundation) walk(name);

if (model.closure?.require_all_foundation_reachable) {
  for (const name of foundation) {
    if (!visited.has(name)) failures.push(`FOUNDATION_UNREACHED:${name}`);
  }
}

const report = {
  format: model.format,
  foundation_count: foundation.size,
  defined_count: allDefined.size,
  visited_count: visited.size,
  external_dependencies: [...external].sort(),
  explicit_cycle_count: cycles.length,
  result: failures.length ? "FAIL" : "PASS",
  failures
};

process.stdout.write(JSON.stringify(report, null, 2) + "\n");
process.exit(failures.length ? 1 : 0);
