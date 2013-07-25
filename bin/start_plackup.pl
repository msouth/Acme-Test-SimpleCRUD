#my $command = "plackup --pid run/$user.pid --server Starman --workers 1 --env $user --port $port --daemonize bin/app.psgi";
#my $pid_file = "run/$user.pid";
use File::Slurp;
my $pid_file = "run/app.pid";
if (-e $pid_file) {
    my ($pid) =  read_file( $pid_file) ;
    chomp $pid;
    my $success = kill 'TERM', $pid;
    if ($success) {
        print "I killed existing $pid from $pid_file\n";
    }
    else {
        print "failed to kill $pid from $pid_file\n";
        if (-e "/proc/$pid") {
            print "\t...but it seems to exists in /proc...I think I'll bail and let you sort this out\n";
            exit 1;
        } else {
            print "\t...it's not there in /proc.  I'm going to go on and let plackup clean up/replace this one\n";
        }
    }

}

my $command = "plackup --pid $pid_file --server Starman --env development --workers 1 --daemonize bin/app.psgi";
#print "\n\nFAILED\n\n  CHeck this output for why:". qx{ nohup $command };
print "I'm about to qx{ $command }...which should daemonize and give you your prompt back if everything goes well.  I'll print the output of the qx run as well\n";
print qx{$command};

