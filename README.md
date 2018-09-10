# Cedille
Cedille is an interactive theorem-prover and dependently typed
programming language, based on extrinsic (aka Curry-style) type theory.
This makes it rather different from type theories like Coq and Agda,
which are intrinsic (aka Church-style).  In Cedille, terms are nothing
more than annotated versions of terms of pure untyped lambda calculus.  
In contrast, in Coq or Agda, the various typing annotations one writes
are intrinsic parts of terms, and can be erased, if at all, only as an
optimization under certain conditions, not in virtue of the definition
of the type theory.

Cedille's type theory allows one to derive inductive datatypes,
together with their induction principles.  These derivations are done
via lambda-encodings, including not just the familiar Church encoding
(with its well-known limitation to inefficient accessors), but also
more efficient Parigot and Mendler encodings.  The planned 1.1 version
of Cedille will support datatype declarations and pattern-matching
recursion, via elaboration to certain of these encodings.  (This feature
did not quite make it into the 1.0 release.)

Cedille is used from an emacs mode, which communicates with the
backend tool.  The emacs mode supports convenient navigation of
the source text following the structure of its syntax tree.  Typing
and context information is available for all subexpressions as
one navigates, as well as information related to type inference.  Cedille
implements a novel form of local type inference called spine-local type
inference.  At the moment this is restricted to solving for first-order
type variables, but in the coming 2018-2019 academic year we plan
to add support for inferring values for term variables as well as
dependent and higher-order type variables.

## Releases
The Cedille compiler is currently maintained at
[github.com/cedille/cedille](https://github.com/cedille/cedille),
and you can download current and past releases on the
[github release page](https://github.com/cedille/cedille/releases).

The version number of each Cedille release follows the
[semantic versioning standard](https://semver.org/),
so that the first number conveys the major version (generally, an
introduction of backwards incompatible changes triggers a change in
this number), the second number conveys the minor version
(introduction of significant but backwards compatible changes), and
the third number conveys the patch level (mainly for bug fixes).

## Installation
To install a pre-built binary, see the
[github release page](https://github.com/cedille/cedille/releases).

Alternatively, to build Cedille yourself, please consult
the [building guide](./BUILD.md)

After installing Cedille,
make sure to add
`(require 'cedille-mode)`
to your `.emacs` file.
When you open a Cedille source file
(e.g. `lib/bool.ced`), Emacs
will load "Cedille" mode.
Now you can type `M-s`
to enter "Cedille
Structured Editing Mode"
(or, "SE-mode").
See the
["Tooling"](https://cedille.github.io/docs/tooling.html#tooling)
section of the documentation
for more information.

## Documentation
The view the documentation for using
the programming language please visit
[this page](https://cedille.github.io/docs/).
This information is also available as a `.info` file at
[docs/info/cedille-info-main.info](https://github.com/cedille/cedille.github.io/blob/master/info/cedille-info-main.info).
You can also always access the documentation for
your installed version of Cedille directly from within Emacs:
while in Cedille mode, enter Cedille
navigation mode by pressing `M-s` and then press `h`.
This will bring up the info file within Emacs.

To see the documentation of the development version of
Cedille, please visit
[this page](https://cedille.github.io/cedille/html/).

Consult
[this document](https://github.com/cedille/cedille.github.io/blob/master/semantics.pdf)
to learn more about
the underlying theory that powers Cedille.
