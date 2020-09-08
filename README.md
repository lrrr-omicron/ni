# ni
Media sorter/tagger (very alpha - I've used it for a while but am just now packaging it up for others to maybe use which is incomplete)


### Installation:

put the ni folder somewhere and put that folder into your path

``` 
$ ls ~/opt/ni
common  ni  ni-cmd  ni-cmds  ni-use`
$ PATH="${PATH}:~/opt/ni"
```

Then install feh ( The image viewer )

I'm on xubuntu right now so for me that's

```
$ sudo apt-get install feh
```

and install mpv ( for viewing vidya )

```
$ sudo apt-get install mpv
```

I think that's all you NEED, but if you want to create markdown description files to be converted to html when you type 

```
$ ni-cmd reingest 
```

You'll want to do:

```
$ sudo apt-get install pandoc
 ```
 
Installed.


### Getting started: 

In my time, I've written a bunch of bash scripts to help me sort my porn stash mainly and also mp3 files and videos.

Basically I end up with a bunch of downloaded crap and want to eliminate duplicates and tag it fast.

Also I don't want some program that keeps a lot of embarassing 'evidence' on my machine iffya know what I mean..

I don't want my porn stash showing up while looking at the family photos etc.  

So before using ni you have to specify the context

eg:

``` 
$ source ni-use notporn
```

By default the NI_IMAGE_DIR is unset and is assumed to be $HOME

notporn would be a directory underneath the $HOME directory.

This cd's you into the $HOME/notporn directory

To sort your porn you'd do something like:

```
$ source ni-use .porn
```

This would cd you into your hidden .pron directory.


The stuff you see in the ~/opt/ni/ni-cmd is commands that I used to have in my path polluting my namespace of commands. 
junky scripts ( and still are though I've been cleaning them up a bit for this ).  Now these shouldn't be called except via
ni-cmd.  You can run the stuff in ~/opt/ni directly ( except ni-use which needs to be sourced - see above )

The stuff in ni-cmd still has usage statements unedited from when they used to be called directly but now they need 
you to prefix them with ni-cmd Eg: 

```
$ source use notporn # only needs to be done once until you
                     # close your terminal or switch to another context
$ ni-cmd reingest # This will totally f*ck up your notporn collection!
ck-293042304320932.jpg
```

Haha!  Start with a small collection of stuff you don't care about to see if you like what's being done ...

If you have files eg notporn/pic-of-my-dog.jpg then it will be renamed to something like ck-293042304320932.jpg where that's the 
checksum of the file ( no duplicates - if the context already has a file with that checksum you don't get 2 copies )

The file itself is stored in notporn/All with the same name.

In your current directory you get ck-293042304320932.jpg but it is a symlink to notporn/All/ck-293042304320932.jpg

You also get a notporn/.meta directory with a directory named pic-of-my-dog.jpg inside.

It has one symlink named  ck-293042304320932.jpg pointing back to notporn/All/ck-293042304320932.jpg


### File names

You can retrieve the original filename by doing 
 
```
$ ni-cmd get-name ck-293042304320932.jpg
3374855 - pic-of-my-dog.jpg
```

This looks for folders contabing
You can do eg:

```
$ ls | while read f
do
  echo "$f - "`ni-cmd get-name $f`
done
```

to print out all the original names.  

When a file is ingested the name it originally had is stored.  But we do not allow files to have more than one name.  So if you try to ingest the same file named with another name, then we don't store the second name the file was ingested with.  

This is because of three things:

1) We want files to have only one name.   
2) You can manually set the name to whatever you want using ni-cmd rename
3) We assume the name the file already has is better than whatever the original name of the file was - you may have manually set it.

Lots of times downloaded files are named things like 1.jpg.  That name shouldn't take precedence over a manually set name.  Also this data is pretty much junk.  It's a starting point if there's nothing else to stick in there for name, but not much good otherwise.  The advantages of storing it and allowing files to have more than one name seem to be less than the advantages of having one name per file, as that encourages manually setting descriptive names.    However filenames are functionally just a tag, though we ignore them during tagging so you can intelligently structure your tags to avoid disambiguation prompts, so they are not quite the same as tags.  Think of them as tags you can only see with ni-cmd get-name with the restriction that each file can only have one, though one name might refer to many different files. (eg: 1.jpg probably refers to 100 files )  


### ni-cmd commands

Here are some commands.  These used to be standalone.  Now they must be called prefixed with ni-cmd.  

```
$ ls ~/opt/ni/ni-cmds
delete-all  inf     nee       rename      tag
get-name    ingest  reingest  rename-raw  untag
```

Most of these you won't use.  nee is private - don't use - use ~/opt/ni/ni instead.  Put ~/opt/ni in your path not ~/opt/ni/ni-cmds so they don't pollute your path.  These rely on ni-cmd sourcing them for access to environment, so they shouldn't be called without ni-cmd anymore.  

If you want tag in your environment without having to type ni-cmd, make an alias to 'ni-cmd tag'.

Here is an example of the ni-cmd inf :

```
$ ni-cmd inf ck-293042304320932.jpg
  
UNIQUE_FILENAME: ck-293042304320932.jpg
FILENAME: 3374855 - pic-of-my-dog.jpg

TAGS:
----------------------------
/home/anon/notporn
```

Since this file has not been tagged, it just prints the path to the context here.  But if we tag it we can see something good.

```
$ ni-cmd tag -d ck-293042304320932.jpg ani do 

Matched multiple tags:
----------------------
1 - cute/dogs
2 - tasty/donuts
Enter number of tag you meant: 1
<spewtum omitted outlining what was done>
Tagging ck-293042304320932.jpg as cute/dogs
Tagging ck-293042304320932.jpg as cute/animals
Removing symlink: ck-293042304320932.jpg 
```
  
In fact we didn't need to ingest the file we could have just tagged the original file and it would have been autoatically ingested first.
  
Tags are just directories in your context and the tag command searches for the best match for what you passed. You can tag multiple files with multiple tags.  -d deletes the file from the current directory.  You can have an incoming 'tag' where you save your pics and then go through and tag them.
  
You can specify files with -f or tags with -t or YOU CAN RANDOMLY MIX TAGS AND FILENAMES WITHOUT MENTIONING WHICH IS WHICH and the tag command will figure out which is which.
  
These commands have been useful in sorting pic collections, but it has required having a viewer open and copying the filenames of the file I'm looking at and pasting it into a terminal window to do the tagging.  Pretty fast but not really satisfactory for many photos.

But that's where the ni command comes in.

# ni - the command

TL;DR:

```
$ source ni-use pic-collection
$ cd incoming-downloads
$ ni
```

When you have saved a lot of incoming files into say notporn/incoming-downloads

You need to set about tagging them.  Optionally, you can ingest all the files you saved into the incoming-downloads folder by doing:

```
$ source ni-use pic-collection # only need to do this once 
$ cd incoming-downloads
# next step is optional as it is automatically by ni
$ ni-cmd reingest  # this will eliminate duplicates,
                   # put the originals under pic-collection/All renamed with their checksums to ck-checksum.ext,
                   # store the original filename under pic-collection/.meta
                   # leave you with a symlink to pic-collection/All/ck-checksum.ext for each file in incoming-downloads
$ ni
```

ni will get the next filename or ck-checksum.ext symlink from the listing of the current directory, open the appropriate viewer, run the ni-cmd tag -d command for you prompting you for the tags for the pic/vid/etc you are viewing and then kill the viewer for you.
  
then just say(type) 'ni' again and you can tag the next pic.

ni is designed to be used in an incoming pic directory.  It deletes the pic from the current directory after ingesting it and tagging it.  By repeatedly running ni, you can tag each file in the directory, which will be empty when you are done.

### About tags:

Tags are directories under a context.  

So you might have 

```
~
$ source ni-use sexyladies
~/sexyladies
$ ls
bathingsuits
hentai
celebrities
```

The directories are tags.  You can change the name of the tag by renaming the directory.  That becomes the new tag name.

A file has a tag if there's a symlink in the respectve directory.

So if ck-238942984329843.jpg is a pic of a hottie in a bikini.. 

```
~/sexyladies
$ ls bathingsuits
ck-238942984329843.jpg
ck-898498443454354.jpg
ck-3489934934584345.jpg
oldtimey/
definition.md  # this is a file you can create that will be converted by ni-cmd reingest 
               # to definition.html if you have pandoc installed
definition.html # if you want to browse your collection with a web browser, 
                # you can see a page you create describing what the tag is

~/sexyladies
$ bathingsuits/oldtimey

ck-389432839844343534.webm  # maybe this is an old Popeye cartoon showing Olive-Oyl in a bathing suit HOT!



~/sexyladies
$ ni-cmd inf ck-389432839844343534.webm

UNIQUE_FILENAME: ck-389432839844343534.webm
FILENAME: Olive_Oyl in HOT-LEGS.webm

TAGS
-----------------------------------
/home/anon/sexyladies ck-389432839844343534.webm
bathingsuits/oldtimey
celebrities/oliveoyl

```

Here we see the webm has two tags: bathingsuits/oldtimey and celebrities/oliveoyl

Suppose we download a black-and-white photo from a bygone year:

```
~/sexyladies
$ # first let's make an incoming folder and have firefox save the photo there
$ mkdir incoming

~/sexyladies
$ cd incoming

~/sexyladies/incoming
$ curl -L https://tinyurl.com/y6dryb4z > 'Vintage Swimsuit.jpg' # don't do this it's copyrighted probably

~/sexyladies/incoming
$ ni
Enter tags for Vintage Swimsuit.jpg: oldt silly
exec ni-cmd tag -d Vintage Swimsuit.jpg oldt silly
THE_FILE = Vintage Swimsuit.jpg
ni-cmd tag -d Vintage Swimsuit.jpg oldt silly Vintage Swimsuit.jpg
~/opt/ni/ni-cmds/tag: line 200: source: 1 - No matches for tag silly try creating the tag (folder) somewhere in ~/sexyladies.
```

Oh yeah I would have to create a tag named silly..  Creating a tag is done by creating a directory

```

~/sexyladies/incoming
$ mkdir ~/sexyladies/silly


~/sexyladies/incoming
$ ni
Enter tags for Vintage Swimsuit.jpg: oldt funny
exec ni-cmd tag -d Vintage Swimsuit.jpg oldt funny
THE_FILE = Vintage Swimsuit.jpg
ni-cmd tag -d Vintage Swimsuit.jpg oldt funny
/home/anon/sexyladies/funny
mv "Vintage Swimsuit.jpg" "/home/anon/sexyladies/All/ck-4161738110437836.jpg"
ln -s "/home/anon/sexyladies/All/ck-4161738110437836.jpg" "./ck-4161738110437836.jpg"
/home/anon/sexyladies/.meta/FILENAMES/Vintage Swimsuit.jpg did not exist, creating it
Tagging ck-4161738110437836.jpg as bathingsuits/oldtimey
Tagging ck-4161738110437836.jpg as silly
Not removing actual file: /home/anon/sexyladies/All/ck-4161738110437836.jpg
Removing symlink: ck-4161738110437836.jpg
kill -INT 75531

~/sexyladies/incoming
$ ls
```

You can see it's gone.  But it's been ingested


You don't have to be in the directory containing the symlink you're querying to reference a 
ck-xxxxxxxx.ext name since the filenames are unique, they are looked up.

```
~/sexyladies/incoming
$ ni-cmd inf ck-4161738110437836.jpg

~/sexyladies/incoming
$ ni-cmd inf ck-4161738110437836.jpg
UNIQUE_FILENAME: ck-4161738110437836.jpg
FILENAME: Vintage Swimsuit.jpg

TAGS:
----------------------------
/home/anon/sexyladies/ ck-4161738110437836.jpg
bathingsuits/oldtimey
silly

```

You don't have to type the whole tag name when tagging.  ni finds the best match and  just uses it.  It only fails complaining about missing tag if you've typed a tagname that can't match an existing tag folder.

Because it assumes you mean an existing tag though, you have to create new tags manually by creating the folder in your context,
