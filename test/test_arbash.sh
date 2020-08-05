#!/usr/bin/env sh

PATH="$(cd "$(dirname $0)/.." && pwd)/src:$PATH"

testUsage() {
    assertFalse arbash
    assertContains "$(arbash || true)" Usage
}

testHelp() {
    assertContains "$(arbash --help)" Usage
}

testList() {
    assertContains "$(arbash list --help)" Usage
}

testInfo() {
    assertContains "$(arbash info --help)" Usage
}

testEdit() {
    assertContains "$(arbash edit --help)" Usage
}

testFire() {
    assertContains "$(arbash fire --help)" Usage
}

testPath() {
    assertContains "$(arbash path --help)" Usage
}

. shunit2
