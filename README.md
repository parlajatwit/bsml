# bsml 
bsml is a simple blog engine. given a template and some markdown files, bsml will set up a personal blog.  
the goal is to allow users to focus on writing without having to worry about web development. of course, one can make their template fancy, but at the core bsml is designed with simplicity first.
## usage
create a folder for specific topics in ``./articles``  
create a md file in ``./articles/<your folder>``  
add an article title, author, and date as follows
```
Article Name
Author
Date (yyyy-mm-dd)
```
after that, write the content of your article. markdown is supported and will be translated to html tags.  
to generate all articles, run ``$ ./create.sh``
the articles will be available in ``./build/<your folder>/<article>.html``
## todo
- [x] generate links to other articles
- [x] generate every article at once
- [ ] tag system
- [ ] rss feed
## license
GPL3, will add to github later
