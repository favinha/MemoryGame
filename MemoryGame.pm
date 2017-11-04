package MemoryGame;

use Data::Dumper;
use Moose;
use v5.18;
use List::Util qw(shuffle);
use DDP;

#Lets use a module to create and shuffle the deck
use MemoryGame::Deck;
use MemoryGame::Player;
use MemoryGame::Table;

# The number of players that will play the game
has 'num_players' => (
  is      => 'rw',
  isa     => 'Int',
  default => '2'
);

has 'decks' => (
  is       => 'ro',
  isa      => 'Int',
  required => 1
);

has 'table' => (
  is   => 'rw',
);

sub start {
  my ($self) = @_;
  # Create the deck for a game of match.
	my @decks;
	my $Table = MemoryGame::Table->new;
	foreach my $Deck (1 .. $self->decks) {
		$Deck = MemoryGame::Deck->new;
		$Table->add_deck($Deck);
	}
	$Table->shuffle_cards;
  #Create the players
  foreach my $i (1 .. $self->num_players) {
    my $player = MemoryGame::Player->new(name => "Player $i");
    $Table->add_player($player);
  }
  $self->table($Table);
	$self->_PlayGame;
	$self->_ShowResults;
}

sub _PlayGame {
  my ($self) = @_;
  say "Lets Play cards!";
  #While all have cards
  my $Table = $self->table;
  #Lets get the first player radonmly
  my @player_order = shuffle @{$Table->players};
  #While we have cards
  while ($Table->has_cards) {
    my $player = shift @player_order;
    say "Its's ", $player->name, " 's turn";
    my $card1 = $Table->pick_from_stack;
    my $card2 = $Table->pick_from_stack;
    say "Picked up card ", $card1->draw, " and card ", $card2->draw;
    my $match = $self->_check_cards($card1, $card2);
    if ($match) {
    	say "Its a match!!";
    	$player->add_cards([$card1, $card2]);
    }
    else {
      #Let put it back on the table
      $Table->put_on_stack([$card1, $card2]);
    }
    push @player_order, $player;
  }
  say "Game over!";
}

sub _ShowResults {
  my ($self) = @_;
  my $Table = $self->table;
	my $winner;
  foreach my $player (@{$Table->players}) {
    say  $player->name, " has ", scalar @{$player->hand};
		if (!defined $winner->{total} or $winner->{total} < scalar @{$player->hand}) {
			$winner->{tie} = 0;
			$winner->{total} = scalar @{$player->hand};
			$winner->{player} = $player->name;
		}
		elsif($winner->{total} == @{$player->hand}) {
			$winner->{tie} = 1;
		}
  }
	if ($winner->{tie}) {
		say "Its a tie!!";
	}
	else {
		say " ==== The winner is ", $winner->{player};
	}
  say "The table has ", scalar @{$Table->cards};
}


sub _check_cards {
	my ($self, $card1, $card2) = @_;
	#say "Playing card ", $card->draw,
	if ($card1->Color eq $card2->Color and $card1->CardValue eq $card2->CardValue) {
		return 1;
	}
  return 0;
}



1;
