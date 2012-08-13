What
==
**passwordy** generates passwords without a password database. This is
mostly just a Ruby transcription of https://gist.github.com/3334991, a method for generating passwords
without a password database.

Installation
==
    $ gem install passwordy

Usage
==
    $ passwordy google.com
    45c36071988fcd6e115afffb519feb19

Backing up
==
`passwordy` generates a salt file on first run and places it in
`~/.salt`. You should back this file up. An easy way to handle
that is to symlink it to `~/Dropbox` (if you use Dropbox).

How's it work?
==

> The password generator takes hex sha512-hashes of your salt file, your master password and the resource name you wish to generate a password for (e.g. a domain name), concatenates them one per line, hashes the result and takes the first 32 characters of the result's hex value. The resulting value is dependant on each of the three variables and no one of the variables can be computed from it (these are properties of cryptographic hashes as sha-512 is one).

The salt is generated from your shell's environment info and a UUID
generated from Ruby's `securerandom` library.

Check out https://gist.github.com/3334991 for a detailed explanation.

License (MIT)
==
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
