
use v5.18;
#use Test::More tests => 4;

use Test::More tests => 4;

require_ok( 'MemoryGame' );

my $rule = '1';
my $decks = '1';

my $game = MemoryGame->new( rule => $rule, decks => $decks);  ##

ok(MemoryGame->new( rule => $rule, decks => $decks), 'Got a new Game');

is($game->num_players, 2, "Two players");
is($game->decks, 1, "Default number of Decks");

##Lets start the game
