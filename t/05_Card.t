use v5.18;
#use Test::More tests => 4;

use Test::More tests => 4;

require_ok( 'MemoryGame::Card' );

ok(my $card = MemoryGame::Card->new(Color => 'Red', Value=>'Square', CardValue => '1'), "Set a card");

is($card->Value, 'Square', 'The value is correct');
is($card->Color, 'Red', 'The colour is correct');
