#!/usr/bin/perl -w

### Lets create a game
use v5.18;

use MemoryGame;

#Lets ask what the number of decks should be
say "How many decks do you want to use ? At least 2";
my $decks = <ARGV>;
chomp $decks;
die "It needs to be a number, not anything else" if $decks !~ /^\d+$/;
say "Using $decks decks of cards.";

my $game = MemoryGame->new(decks => $decks);  ##

$game->start();


1;
