#!/usr/bin/perl

use strict;
use warnings;
use feature qw/say/;

&main;

sub main() {
    die "script expects line length and string to wrap\n" unless scalar @ARGV == 2;

    # expect length then string
    my ($k, $s) = ($ARGV[0], $ARGV[1]);
    my @return = string_to_array($s, $k);

    say "-- wrapped to " . (scalar @return) . " lines --";
    say '#'x$k; # to visually indicate the line length
    say join("\n", @return);
}

sub string_to_array($$) {
    my $string = shift;
    my $line_length = shift;
    my (@lines, @line);

    my $word;
    my @words = split(/\s+/, $string);

    do {
        $word = shift(@words);
        die "word '$word' exceeds the line length\n" if (length($word) > $line_length);

        push (@line, $word);

        if (length("@line") > $line_length) {
            pop(@line);
            push(@lines, "@line");
            @line = ($word);
        }

    } while (@words);

    push(@lines, "@line");

    return @lines;
}
