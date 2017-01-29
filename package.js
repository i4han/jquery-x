
Package.describe({
    summary: 'jquery-x: Extend jQuery library for Meteor.',
    "version": "0.0.11",
    git: 'https://github.com/i4han/jquery-x.git',
    documentation: 'README.md'
});

Package.on_use( function (api) {
    api.use('coffeescript@1.2.6');
    api.use('jquery@1.11.10');
    api.use('isaac:underscore2@0.5.40');
    api.add_files( 'jquery-x.js',      'client');
    api.add_files( 'jquery-x2.coffee', 'client');
});
