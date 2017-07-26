# Z3 tactic tutorial

This repository contains files used for a tutorial on
[Z3](https://github.com/Z3Prover/z3) tactics given the [SRGgroup](https://srg.doc.ic.ac.uk/)
at [Imperial College London](https://www.imperial.ac.uk) on Thursday July 27th 2017.

**SLIDE URL:** TODO

## Examples

The examples can be found in the [examples](examples/) directory.

They were run using Z3 at commit fd3727ad004eafd7361fbaa2a8d302df8e8757a8 .


## A few useful commands

### Get list of tactics (with parameters) and probes

```
./z3 -smt2 <(echo "(help-tactic)") | less
```

### Get Z3 help

```
./z3 -smt2 <(echo "(help)") | less
```
