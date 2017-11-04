use v5.18;
#use Test::More tests => 4;

use Test::More tests => 3;

require_ok( 'MemoryGame::Player' );

ok( my $player = MemoryGame::Player->new(name => "DeepBlue"), "Set a player");

is($player->name, 'DeepBlue', 'The name is correct');
