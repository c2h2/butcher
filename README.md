butcher 屠夫中文分词
====================

屠夫喜欢切肉，这个屠夫采用Ruby从左向右最大化匹配来分词。可自学新词，来训练字典。

Chop Chinese lines to create individual segment, and manage words library from web ui.

Butcher "meat good, vegetable sucks!"

Installation && Initialization
==============================

    apt-get install mongodb nodejs
    git clone git://github.com/c2h2/butcher.git && cd butcher
    bundle install
    bundle exec rake db:seed
    bundle exec rails s
    # Visit http://localhost:3000/


    ./start_sinatra.sh
    # Visit http://localhost:4567/

Versions, I use
===============
* ruby 2.0.0
* rails 4.0.0
# sinatra 1.4.3


System dependencies
===================
* Mongo database 2.2
* Rails 4.0.0
