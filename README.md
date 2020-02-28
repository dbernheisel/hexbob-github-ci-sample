# AlpineTest

Small Mix project that runs through Hex Bob's built Alpine images in GitHub CI

The main files of interest are:

* [./.github/workflows/ci.yml]
* [./mix.exs]

It also assumes you're using asdf to manage your local versions of Elixir during
development.

This CI sample performs these actions on all Elixir/OTP versions:

* Runs ExUnit tests
* Runs Mix Compile with warnings as errors
* Runs Dialyzer via Dialyxir

This CI sample performs these actions on the latest Elixir/OTP version:

* Runs Mix Format to check format
* Runs Credo in strict mode

