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
    db_table => 'widget',
    prefix => '/widget',
    foreign_keys => {
        buddy_widget_id => {
            table => 'widget',
            key_column => 'id',
            label_column => 'name',
        },
    },
);

simple_crud (
    db_table => 'person',
    prefix => '/person',
    foreign_keys => {
       favorite_widget_id => {
            table => 'widget',
            key_column => 'id',
            label_column => 'name',
        },
    },
);

simple_crud (
    db_table => 'widget_inventor',
    prefix => '/inventor',
    foreign_keys => {
        widget_id => {
            table => 'widget',
            key_column => 'id',
            label_column => 'name',
        },
        inventor_id => {
            table => 'person',
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
    database->do('CREATE TABLE IF NOT EXISTS widget  (id integer primary key autoincrement, name varchar(63), description varchar(255), buddy_widget_id int)');
    database->do('CREATE TABLE IF NOT EXISTS simple_thing  (id integer primary key autoincrement, name varchar(63), description varchar(255))');
    database->do('CREATE TABLE IF NOT EXISTS person  (id integer primary key autoincrement, name varchar(63), favorite_widget_id int)');
    database->do('CREATE TABLE IF NOT EXISTS widget_inventor  (id integer primary key autoincrement, inventor_id int, widget_id int)');
}


init_db();

true;
