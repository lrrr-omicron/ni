# ni
Media sorter/tagger (very alpha - I've used it for a while but am just now packaging it up for others to maybe use which is incomplete)


Installation:

put the ni folder somewhere and put that folder into your path

> $ ls ~/opt/ni
> common  ni  ni-cmd  ni-cmds  ni-use

> $ PATH="${PATH}:~/opt/ni"


Then install feh ( The image viewer )

I'm on xubuntu right now so for me that's

> $ sudo apt-get install feh

and install mpv ( for viewing vidya )

> $ sudo apt-get install mpv
 
I think that's all you NEED, but if you want to create markdown description files to be converted to html when you type 

> $ ni-cmd reingest 

You'll want to do:

> $ sudo apt-get install pandoc
 
Installed.



In my time, I've written a bunch of bash scripts to help me sort my porn stash mainly and also mp3 files and videos.

Basically I end up with a bunch of downloaded crap and want to eliminate duplicates and tag it fast.

Also I don't want some program that keeps a lot of embarassing 'evidence' on my machine iffya know what I mean..

I don't want my porn stash showing up while looking at the family photos etc.  

So before using ni you have to specify the context

eg:

> $ source ni-use notporn
  
By default the NI_IMAGE_DIR is unset and is assumed to be $HOME

notporn would be a directory underneath the $HOME directory.

This cd's you into the $HOME/notporn directory

To sort your porn you'd do something like:

> $ source ni-use .porn
  
This would cd you into your hidden .pron directory.


The stuff you see in the ~/opt/ni/ni-cmd is commands that I used to have in my path polluting my namespace of commands. 
junky scripts ( and still are though I've been cleaning them up a bit for this ).  Now these shouldn't be called except via
ni-cmd.  You can run the stuff in ~/opt/ni directly ( except ni-use which needs to be sourced - see above )

The stuff in ni-cmd still has usage statements unedited from when they used to be called directly but now they need 
you to prefix them with ni-cmd Eg: p

> $ source use notporn # only needs to be done once until you close your terminal or switch to another context
> $ ni-cmd reingest
 
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
 
> $ ni-cmd get-name ck-293042304320932.jpg
> 3374855 - pic-of-my-dog.jpg

You can do eg:
  
> $ ls | while read f
> do
>   echo "$f - "`ni-cmd get-name $f`
> done
  
to print out all the original names.  
  
here are some commands 
 
> $ ls ~/opt/ni/ni-cmds
> delete-all  inf     nee       rename      tag
> get-name    ingest  reingest  rename-raw  untag

most of these you won't use.  nee is private, use ~/opt/ni/ni instead
 
> $ ni-cmd inf ck-293042304320932.jpg
  
> UNIQUE_FILENAME: ck-293042304320932.jpg
> FILENAME: 3374855 - pic-of-my-dog.jpg

> TAGS:
> ----------------------------
> /home/anon/notporn

Since this file has not been tagged, it just prints the path to the context here.  But if we tag it we can see something good.

> $ ni-cmd tag -d ck-293042304320932.jpg ani do 
  

> Matched multiple tags:
> ----------------------
> 1 - cute/dogs
> 2 - tasty/donuts
> Enter number of tag you meant: 1
> <spewtum outlining what was done>
> Tagging ck-293042304320932.jpg as cute/dogs
> Tagging ck-293042304320932.jpg as cute/animals
> Removing symlink: ck-293042304320932.jpg 
  
  
In fact we didn't need to ingest the file we could have just tagged the original file and it would have been autoatically ingested first.
  
Tags are just directories in your context and the tag command searches for the best match for what you passed. You can tag multiple files with multiple tags.  -d deletes the file from the current directory.  You can have an incoming 'tag' where you save your pics and then go through and tag them.
  
You can specify files with -f or tags with -t or YOU CAN RANDOMLY MIX TAGS AND FILENAMES WITHOUT MENTIONING WHICH IS WHICH and the tag command will figure out which is which.
  
These commands have been useful in sorting pic collections, but it has required having a viewer open and copying the filenames of the file I'm looking at and pasting it into a terminal window to do the tagging.  Pretty fast but not really satisfactory for many photos.
  
But that's where the ni command comes in.
  
> $ source ni-use pic-collection
> $ cd incoming-downloads
> $ ni
    
ni will list the current directory, get the next filename, open the appropriate viewer, run the ni-cmd tag -d command for you prompting you for the tags for the pic/vid/etc you are viewing and then kill the viewer for you.
  
then just say(type) 'ni' again and you can tag the next pic.
