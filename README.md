# ni
Media sorter/tagger (very alpha - I've used it for a while but am just now packaging it up for others to maybe use which is incomplete)


Installation:

put the ni folder somewhere and put that folder into your path


$ ls ~/opt/ni
common  ni  ni-cmd  ni-cmds  ni-use

$ PATH="${PATH}:~/opt/ni"


Then install feh ( The image viewer )

I'm on xubuntu right now so for me that's

  $ sudo apt-get install feh

and install mpv ( for viewing vidya )

  $ sudo apt-get install mpv
 
I think that's all you NEED, but if you want to create markdown description files to be converted to html when you type 

  $ ni-cmd reingest 

You'll want to do:

  $ sudo apt-get install pandoc
 
Installed.



In my time, I've written a bunch of bash scripts to help me sort my porn stash mainly and also mp3 files and videos.

Basically I end up with a bunch of downloaded crap and want to eliminate duplicates and tag it fast.

Also I don't want some program that keeps a lot of embarassing 'evidence' on my machine iffya know what I mean..

I don't want my porn stash showing up while looking at the family photos etc.  

So before using ni you have to specify the context

eg:  

  $ source ni-use notporn
  
By default the NI_IMAGE_DIR is unset and is assumed to be $HOME

notporn would be a directory underneath the $HOME directory.

This cd's you into the $HOME/notporn directory

To sort your porn you'd do something like:

  $ source ni-use .porn
  
This would cd you into your hidden .pron directory.


The stuff you see in the ~/opt/ni/ni-cmd is commands that I used to have in my path polluting my namespace of commands. 
junky scripts ( and still are though I've been cleaning them up a bit for this ).  Now these shouldn't be called except via
ni-cmd.  You can run the stuff in ~/opt/ni directly ( except ni-use which needs to be sourced - see above )

The stuff in ni-cmd still has usage statements unedited from when they used to be called directly but now they need 
you to prefix them with ni-cmd Eg: p

 $ source use notporn # only needs to be done once until you close your terminal or switch to another context
 $ ni-cmd reingest
 
This will totally fuck up your notporn collection!
ck-293042304320932.jpg
Haha!  Start with a small collection of stuff you don't care about...

If you have files eg notporn/pic-of-my-dog.jpg then it will be renamed to something like ck-293042304320932.jpg where that's the 
checksum of the file ( no duplicates - if the context already has a file with that checksum you don't get 2 copies )

The file itself is stored in notporn/All with the same name.

In your current directory you get ck-293042304320932.jpg but it is a symlink to notporn/All/ck-293042304320932.jpg

you also get a notporn/.meta directory with a directory named pic-of-my-dog.jpg inside.

It has one symlink named  ck-293042304320932.jpg pointing back to notporn/All/ck-293042304320932.jpg

You can retrieve the original filename by doing 
 notporn/All/ck-293042304320932.jpg
  $ ni-cmd get-name 


 
