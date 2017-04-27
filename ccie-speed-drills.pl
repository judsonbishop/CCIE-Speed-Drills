#!/usr/bin/perl
use warnings;
use DateTime;
use List::Util 'shuffle';
my $directory = '.';
my @questions;
my @answers;
my @repeats;
my @shuffled;
my $i = 0;
my $start;
my $end;
my $elapsed;
my $random;
my $count;

opendir(DIR, ".");
     @questions = grep(/question/, readdir(DIR));
closedir(DIR);

opendir(DIR, ".");
     @answers = grep(/answer/, readdir(DIR));
closedir(DIR);

# Set up the question counters and question order.
$count = $#questions;
@shuffled = (0..$#questions);
@shuffled = shuffle @shuffled;    

print "$count\n";
print "@shuffled\n";

sub clear_screen {
    print "\033[2J";    #clear the screen
    print "\033[0;0H";  #jump to 0,0
}


while ($count >= 0 ){
    $count -=1;
    #$random = int(rand($arraysize));
    

    clear_screen();    
    print $questions[$shuffled[$count]],"\n\n";
    open FILE, $questions[$shuffled[$count]] or die "Could not open $questions[$shuffled[$count]].";
    while(<FILE>) {
        print $_;
    }
    close FILE;
        
        print "\nType the word done and press enter when you are done.\n";
    
        $start = DateTime->now();
        while (<>) {
            last if /^done$/;
        }
        $end = DateTime->now();
        $elapsed = $end - $start;

        print "=============================================\n";
        open FILE, $answers[$shuffled[$count]] or die "Could not open $answers[$shuffled[$count]]";
        print $answers[$shuffled[$count]],"\n\n";
        while(<FILE>) { print $_;
        }
        close FILE;
        print "In ".$elapsed->in_units('seconds')." seconds\n";

        print "\nType the word done and press enter when you are done.\n";
        while (<>) {
            last if /^done$/;
        }
 
        clear_screen();    
}
    
