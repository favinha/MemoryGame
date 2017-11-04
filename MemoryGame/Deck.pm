package MemoryGame::Deck;

use Moose;

use MemoryGame::Card;
use List::Util qw(shuffle);


#The array with all the cards in the deck
has cards => (
  is  => 'rw',
);

#Lets build the deck
sub BUILD {
    my ($self) = @_;
    my $Colors = [qw(Red, Blue, Green, Yellow)];
    # (Parts of) this hash will need to be reset in lots of games.
    my @Deck;
    my $Values = {
    'Square'   => 1,
    'Circle'   => 2,
    'Triangle' => 3,
    'Oval'     => 4
    };
    foreach my $color (sort @$Colors) {
        foreach my $key (sort keys %$Values) {
            #say "Creating a card *$color*, value *$key* with a cardvalue ", $Values->{$key};
            push @Deck, MemoryGame::Card->new(Color => $color, Value=>$key, CardValue => $Values->{$key});
        }
    }
    $self->cards(\@Deck);
}


sub shuffle_cards {
    my ($self) = @_;
    my $deck = $self->cards;
    my @Deck = shuffle @$deck;
    $self->cards(\@Deck);
}



1;
