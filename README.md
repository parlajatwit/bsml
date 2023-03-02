# bsml 
bsml is a simple blog engine. given templates and some markdown files, bsml will set up a personal blog.  
the goal is to allow users to focus on writing without having to worry about web development. of course, one can make their templates fancy, but at the core bsml is designed with simplicity first.
## usage
create a folder for specific topics in ``./articles``  
create a md file in ``./articles/<category>``  
edit the variables in .bsmlrc as you see fit
add an article title, author, date, and template file as follows
```
Article Name
Author
yyyy-mm-dd
<template file path>
link
```
if the author or date are unknown, write the respective value as $UNKNOWN (default: ``?``)   
if you don't want the article to appear in the category links, leave the 5th line empty  
after that, write the content of your article. markdown is supported and will be translated to html tags.  
to generate all articles, run ``$ ./create.sh``
the articles will be available in ``./build/<category>/<article>.html``
## todo
- [x] generate links to other articles
- [x] generate every article at once
- [ ] rss feed
## template files
any valid html will work for a template file.  
write ``$VARIABLE`` wherever you want the following information to be inserted, substituting "VARIABLE"  
variables are stored in .bsmlrc  
you can define more variables there as well
- ``$TITLE`` article title
- ``$AUTHOR`` author name
- ``$DATE`` date
- ``$CONTENT`` article content
- ``$FOOTER`` links to other articles
- ``$CATEGORY`` article category name
- ``$UNKNOWN`` character/string for missing values
- ``$HOME_PAGE`` path to whatever page, can be inserted in templates to link back
