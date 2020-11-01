#!/usr/bin/env perl

use strict;
use LWP::UserAgent;

main() unless caller();

sub main {
  my $ua = LWP::UserAgent->new();
  while (my $url = <STDIN>) {
    chomp $url;
    my $res = $ua->get($url);
    print " + $url -> ", $res->code, "\n";
  }
}