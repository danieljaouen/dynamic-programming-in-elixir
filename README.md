# Dynamic Programming In Elixir

A simple dynamic programming example in Elixir.

## Install the dependencies
```shell
$ mix deps.get
```

## Run the tests

```shell
$ mix test
```

## LFE version
[Here.](https://github.com/danieljaouen/dynamic-programming-in-lfe)

Note: The Elixir version is currently more performant due to parallel processing.

Edit: Maybe not. Looks like ParalleStream adds a significant overhead. Check
your results with `:timer.tc(fn -> lowest_cose_path(...) end)` first and
perhaps modify your version of the code to not use ParallelStream.

## License

Apache License, Version 2.0

Copyright © 2024, Daniel Jaouen <dcj24@cornell.edu>.
