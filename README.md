This repo is a fork of mruby that is configured to work with the Arduino Due.

The branch to use is `arduino_due`, and is currently set the default branch. The
branch was forked from the mruby v1.3.0 (stable branch) release from July 2017.

`build_config_ArduinoDue.rb` has been updated to work with Arduino IDE v1.8.3
and been configured for more aggressive memory savings.

Gembox file for that build file has been created: `mrbgems/arduino_due.gembox`.

`include/mruby/boxing_no.h` and `src/symbol.c` have been modified for memory
savings using instructions from http://d.hatena.ne.jp/kyab/20130203.

It is best demonstrated on the Arduino Due with this example sketch:
https://github.com/xunker/mruby_arduino_due_example

It is intended to be used with https://github.com/xunker/mruby_arduino_library,
but may still work with https://github.com/kyab/mruby-arduino (untested).

---

[![Build Status][build-status-img]][travis-ci]

## What is mruby

mruby is the lightweight implementation of the Ruby language complying to (part
of) the [ISO standard][ISO-standard]. Its syntax is Ruby 1.9 compatible.

mruby can be linked and embedded within your application.  We provide the
interpreter program "mruby" and the interactive mruby shell "mirb" as examples.
You can also compile Ruby programs into compiled byte code using the mruby
compiler "mrbc".  All those tools reside in the "bin" directory.  "mrbc" is
also able to generate compiled byte code in a C source file, see the "mrbtest"
program under the "test" directory for an example.

This achievement was sponsored by the Regional Innovation Creation R&D Programs
of the Ministry of Economy, Trade and Industry of Japan.

## How to get mruby

The stable version 1.3.0 of mruby can be downloaded via the following URL: [https://github.com/mruby/mruby/archive/1.3.0.zip](https://github.com/mruby/mruby/archive/1.3.0.zip)

The latest development version of mruby can be downloaded via the following URL: [https://github.com/mruby/mruby/zipball/master](https://github.com/mruby/mruby/zipball/master)

The trunk of the mruby source tree can be checked out with the
following command:

    $ git clone https://github.com/mruby/mruby.git

You can also install and compile mruby using [ruby-install](https://github.com/postmodern/ruby-install), [ruby-build](https://github.com/rbenv/ruby-build) or [rvm](https://github.com/rvm/rvm).

## mruby home-page

The URL of the mruby home-page is: [http://www.mruby.org](http://www.mruby.org).

## Mailing list

We don't have a mailing list, but you can use [GitHub issues](https://github.com/mruby/mruby).

## How to compile and install (mruby and gems)

See the [doc/guides/compile.md](doc/guides/compile.md) file.

## Running Tests

To run the tests, execute the following from the project's root directory.

    $ make test

Or

    $ ruby ./minirake test

## How to customize mruby (mrbgems)

mruby contains a package manager called *mrbgems*. To create extensions
in C and/or Ruby you should create a *GEM*. For a documentation of how to
use mrbgems consult the file [doc/guides/mrbgems.md](doc/guides/mrbgems.md). For example code of
how to use mrbgems look into the folder *examples/mrbgems/*.

## License

mruby is released under the [MIT License](MITL).

## Note for License

mruby has chosen a MIT License due to its permissive license allowing
developers to target various environments such as embedded systems.
However, the license requires the display of the copyright notice and license
information in manuals for instance. Doing so for big projects can be
complicated or troublesome.  This is why mruby has decided to display "mruby
developers" as the copyright name to make it simple conventionally.
In the future, mruby might ask you to distribute your new code
(that you will commit,) under the MIT License as a member of
"mruby developers" but contributors will keep their copyright.
(We did not intend for contributors to transfer or waive their copyrights,
Actual copyright holder name (contributors) will be listed in the AUTHORS
file.)

Please ask us if you want to distribute your code under another license.

## How to Contribute

See the [contribution guidelines][contribution-guidelines], and then send a pull
request to <http://github.com/mruby/mruby>.  We consider you have granted
non-exclusive right to your contributed code under MIT license.  If you want to
be named as one of mruby developers, please include an update to the AUTHORS
file in your pull request.

[ISO-standard]: http://www.iso.org/iso/iso_catalogue/catalogue_tc/catalogue_detail.htm?csnumber=59579
[build-status-img]: https://travis-ci.org/mruby/mruby.svg?branch=master
[contribution-guidelines]: CONTRIBUTING.md
[travis-ci]: https://travis-ci.org/mruby/mruby
