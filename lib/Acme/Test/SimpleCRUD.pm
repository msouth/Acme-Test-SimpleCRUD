package Acme::Test::SimpleCRUD;
use Dancer ':syntax';

use Dancer::Plugin::SimpleCRUD;
use Dancer::Plugin::Database;

our $VERSION = '0.1';

#prefix '/foo';

get '/' => sub {
    template 'index';
};

get '/hello' => sub {
    'hi there';
};


simple_crud (
    db_table => 'widgets',
    prefix => '/widgets',
    foreign_keys => {
        buddy_widget_id => {
            table => 'widgets',
            key_column => 'id',
            label_column => 'name',
        },
    },
);

#prefix '/foo';

simple_crud (
    db_table => 'simple_thing',
    prefix => '/simple_thing',
);


sub init_db {
    database->do('CREATE TABLE IF NOT EXISTS widgets  (id integer primary key autoincrement, name varchar(63), description varchar(255), buddy_widget_id int after id)');
    database->do('CREATE TABLE IF NOT EXISTS simple_thing  (id integer primary key autoincrement, name varchar(63), description varchar(255))');
    print STDERR Dumper( \@INC ); use Data::Dumper;
    print STDERR Dumper( \%INC ); use Data::Dumper;
}


init_db();

true;
