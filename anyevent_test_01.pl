#! /usr/bin/env perl

use strict;
use warnings;

use AnyEvent;
use AnyEvent::Socket;

my $cv = AnyEvent->condvar;

my $guard; $guard = tcp_connect 'localhost', 80, sub {
  my ($fh) = @_;

  undef $guard;

  my $w; $w = AnyEvent->io(
    fh => $fh,
    poll => 'w',
    cb => sub {
      undef $w;
      my $buf = "GET / HTTP 1.0\r\n\r\n";
      my $length = syswrite($fh, $buf, length($buf));

      if ($length != length($fh)) {
        warn "failed to write";
        $cv->send;
      }

      my $r; $r = AnyEvent->io(
        fh => $fh,
        poll => 'r',
        cb => sub {
          my $length = sysread($fh, my $buf, 8192);
          if ($length > 0) {
            print $buf. "\n";

          } else {
            undef $r;
            $cv->send;
          }
        }
      );
    }
  );
}
