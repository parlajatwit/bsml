# bsml 
bsml is a simple blog engine. given a template and some markdown files, bsml will set up a personal blog.  
the goal is to allow users to focus on writing without having to worry about web development. of course, one can make their template fancy, but at the core bsml is designed with simplicity first.
## usage
create an md file in ``./articles``  
add an article title, author, and date as follows
```
Article Name
Author
Date (yyyy-mm-dd)
```
after that, write the content of your article. markdown is supported and will be translated to html tags.  
to generate an article, run ``$ ./create.sh <path to md file>``
the article will be available in ``./build/<article>.html``
## todo
- [ ] generate links to other articles
- [x] generate every article at once
- [ ] rss feed
## license
GPL3, will add to github later
