What
==
`passwordy` generates passwords without a password database. This is
(so far) entirely just a Ruby transcription of
https://gist.github.com/3334991, a pretty neat idea.

Installation
==
    $ gem install passwordy

Usage
==
    $ passwordy google.com
    9008781fb309e1114ed13875318e574e5a2c561a6b5c417470b77e431659bb9ec9b11864b3f75673b91c7f9b4895c3c1cb5b0438531a6f8222199da57cc4672e

Backing up
==
`passwordy` generates a salt file on first run and places it in
`~/.salt`. You should back this file up. An easy way to handle
that is to symlink it to `~/Dropbox` (if you use Dropbox).

Hows it work?
==
Check out https://gist.github.com/3334991 for a detailed explanation.
