#!/usr/bin/env perl
use SQL::Beautify;
print SQL::Beautify->new(query => <STDIN>, spaces => 2, break => "\r\n", uc_keywords => 1)->beautify;
