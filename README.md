# Road to Elm - Examples of Elm code

This repository contains working solutions to some problems
which we encountered while learning Elm.

## Setup and usage

If you have cloned this repository, you can use `elm reactor` command
to run any file having `.elm` extension.
Navigate to any directory and run `elm reactor` command.
Elm reactor will start a local server listing the `.elm` files in that directory.
Click on any file to see it in action.

Although `elm reactor` will download the necessary packages on its own
if not found locally,
it is good idea to install them explicitly
with the following command from the root directory.

```
elm package install
```

## Table of contents

* [Working with forms](working-with-forms)
* [HTTP requests](http-requests)
* [JSON encoding and decoding](json-encoding-and-decoding)
