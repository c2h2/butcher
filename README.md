butcher 屠夫中文分词
====================

屠夫喜欢切肉，这个屠夫采用Ruby从左向右最大化匹配来分词。可自学新词，来训练字典。


Butcher "meat good, vegetable sucks!"


=== Installation && Initialization ===

    apt-get install mongodb nodejs
    git clone git://github.com/c2h2/butcher.git && cd butcher
    ./getdict.sh 
    cd www
    bundle
    rake db:seed
    
 
