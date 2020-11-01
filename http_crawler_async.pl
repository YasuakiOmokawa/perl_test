#!/usr/bin/env perl

use strict;
use AnyEvent;
use AnyEvent::Handle;
use AnyEvent::HTTP;

main() unless caller();

sub main {
  my $cv = AnyEvent->condvar;

  my $handle = AnyEvent::Handle->new(
    fh => \*STDIN,
    on_eof => sub {$cv->end},
    on_error => sub {$cv->end},
  );

  # 最後の待ちを有効にするため１回beginを呼んでおく
  $cv->begin();

  my $w;
  my $read_stdin; $read_stdin = sub {
    $handle->push_read(line => sub {
      my ($handle, $url) = @_;
      chomp $url;
      if ($url) {

        # このURLを処理してる間は$cvの条件を満たさないようにフラグを立てておく
        $cv->begin();

        # AnyEvent::HTTPを使ってリクエストを送る
        http_get $url, sub {
          my ($body, $headers) = @_;
          print " + $headers->{URL} -> " . "$headers->{Status}, $headers->{Reason}\n";

          # URLを取得したのでフラグを落とす
          $cv->end();
        };
      }
      # 1行読んだので、もう１行読むために$read_stdinをイベントキューに
      # 入れてもらう
      $w = AnyEvent->timer(after => 0, cb => $read_stdin);
    });
  };

  $w = AnyEvent->timer(after => 0, cb => $read_stdin);

  # $cv->end()がbegin()の回数分呼ばれるまで待つ
  $cv->recv();
}