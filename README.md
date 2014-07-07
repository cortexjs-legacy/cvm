# cvm [![NPM version](https://badge.fury.io/js/cvm.svg)](http://badge.fury.io/js/cvm)

Cortex Version Manager:

- Allow processes with different versions of cortex, which is useful for CI
- Install and uninstall specified version of cortex
- Switch to an installed version in miniseconds

## Install

```bash
$ npm install -g cvm
```

or

```bash
$ make install
```

### Installing and Activate A Specific Version of Cortex

```
$ cvm 5.5.0
```

### Usage

```
$ cvm --help

  cvm                       Output versions installed in interactive interface
  cvm <version>             Install and activate <version>
  cvm install <version>     Only install <version>
  cvm rm <version ...>      Remove the given version(s)
  cvm list, cvm ls          Output the versions of cortex available
```

## For Developers

Turn on `cvm` debug:

```bash
export CVM_DEBUG=1
```

Turn off:

```bash
export CVM_DEBUG=0
```

## License

(The MIT License)

Copyright (c) 2013 Kael Zhang <i@kael.me>, contributors

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

## Change Log

- **0.2.0**: Support multiple processes with different cortex versions
- **0.1.0**: Basic commands

