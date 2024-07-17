# t9rminal

Terminal interaction, from the numpad

Inspired by the classic T9 predictive text engine

> For when I eventually fit a pi zero in a Nokia 3310

```sh
> cat file_
> 22803453
```

## Supported Buttons
- 0-9, #, *
- d-pad
- select

On a PC, the arrow keys and enter stand in for the d-pad.

## Features

### Current
- Find possible commands on `$PATH` for given input

### Future
- Handle both computer numpads and phone keypads (different layouts)
- Flag handling by parsing program help
- Implement Multi-tap for arbitrary text input
- Read shell history for better heuristics

## Why `lua`?

`lua` is small, fast, light, and embeddable.

