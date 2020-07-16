# arbash: After Rain BAmboo SHoots

**arbash** is a command line based text templates manager.

Unlike to similar templating tools, **arbash** does not provide any pre-defined template sets.

Instead, **arbash** presents a simple solution to create, edit and apply templates using common set of cli tools.

## Core concept

When creating a template, **arbash** creates a *diff* file out of your git commits.

Then **arbash** helps you to edit the diff file by launching `EDITOR`.
You are supposed to edit the diff file so that you can parametarize anything by replacing with environment variable like `$name` or so.

Finally **arbash** applys your templates by filling env vars with `envsubst` and running `patch` command.

## Installation

**arbash** is a nix native application.

Install nix package manger and run the following command:

```console
$ nix-env -i -f https://github.com/kayhide/arbash/archive/master.tar.gz
```

After successful installation the **arbash** command is available.

```console
$ arbash --version
0.1.0
```

## Usage

### Create a template

Since **arbash** works with `git`, you should be in a directory of git repository.

As a starting point, find a git commit *ref* with `git` command or whatever tool you want.
**arbash** creates a diff file by issuing `git diff ref~1 ref`.
So `ref` can be anything if it points a commit.

If you want to use a `HEAD` as a `ref`, you can ommit it.

After finding your starting point, create a template with the following command:

```console
$ arbash create my-first-template $ref 
```

This creates a template with the name of `my-first-template` and start an editor of `EDITOR`.

### Edit a template

As after creating, you can also start an editor as:

```console
$ arbash edit my-first-template
```

Edit the diff file as you like.
To parametarize some part of diff file, replace rigid texts with environment variables.

For example, assume that you are editing diff file of:

```diff
...
+stdenv.mkDerivation {
+  pname = "arbash";
+  version = "0.1.0";
...
```

To parametarize the package name and version, you can do it as:

```diff
+stdenv.mkDerivation {
+  pname = "${name}";
+  version = "${version}";
```

When finished to edit, just save it and close the editor.
Now the template is ready to use.

### Apply the template

To apply a template while filling the parameters, run the following command:

```console
$ name=new-thing version=0.1.0 arbash fire my-first-template
```

That is it.
Check the result with git command.


## Contributions

Feel free to open an issue or PR.
Thanks!
