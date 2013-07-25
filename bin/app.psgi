#!/usr/bin/env perl
use Dancer;
use Acme::Test::SimpleCRUD;
 
use Plack::Builder;
use Plack::Response;
 
my $app = sub {
    my $env     = shift;
    my $request = Dancer::Request->new(env=>$env);
    print STDERR Dumper( %INC ); use Data::Dumper;
    Dancer->dance($request);
};
 
builder {
    #enable "Auth::Basic", authenticator => sub {
    #    #    my ( $username, $password ) = @_;
    #        #    return $username eq 'admin' && $password eq 's3cr3t';
    #            #;
    mount "/plack" => $app;
};
