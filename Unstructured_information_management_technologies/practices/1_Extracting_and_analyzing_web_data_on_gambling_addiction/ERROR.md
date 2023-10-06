ERROR in commad:
```
!cd mynewsproject && scrapy crawl example
```
ERROR
```
AttributeError: 'AsyncioSelectorReactor' object has no attribute '_handleSignals'
```
[SOL](https://stackoverflow.com/questions/77002835/im-learning-python-web-scraping-it-shows-attributeerror-when-i-scrapy-crawl-a)



As pointed out in my comment, the issue you are describing is already being tackled by scrapy here and has to do with one of its dependencies, twisted (a day ago, a new version was released, 23.8.0, which seems to cause the issue).

Another user fixed the issue by installing a previous version of twisted (see here).

Basically, he installed the following version of twisted, which fixed his issue.
```
pip install Twisted==22.10.0
```
Until the issue is fixed and a new version is released, I suggest using the previous version.


