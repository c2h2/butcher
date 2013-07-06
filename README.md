butcher 屠夫中文分词
====================

屠夫喜欢切肉，这个屠夫采用Ruby从左向右最大化匹配来分词。可自学新词，来训练字典。


Butcher "meat good, vegetable sucks!"


Installation && Initialization
==============================

    apt-get install mongodb nodejs
    git clone git://github.com/c2h2/butcher.git && cd butcher
    ./getdict.sh 
    cd www
    bundle
    rake db:seed
    
 
## README
Manage words library from web ui.

## Get started:
  cd www
  bundle
  bundle exec rake db:create
  bundle exec rails s
  # Visit http://localhost:3000/

## Ruby version

ruby 1.9.3


## System dependencies

* Mongo database 2.2
* rails 4.0.0.rc1

## Configuration
Nothing need to do.

## Database creation
    cd www; bundle exec rake db:create




Please feel free to use a different markup language if you do not plan to run
<tt>rake doc:app</tt>.
