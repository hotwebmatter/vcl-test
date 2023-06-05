# VCL Test

Lando environment for rapid local testing of Varnish with customizable VCL.

* [Varnish Lando Plugin](https://docs.lando.dev/varnish/)
* [Configuration](https://docs.lando.dev/varnish/config.html)
* [Source Code](https://github.com/lando/varnish)

## Quick Start

```
git clone git@github.com:hotwebmatter/vcl-test.git && \
cd vcl-test && \
lando start
```

Make a note of your Varnish URL and port, e.g.:

```
   ___                      __        __        __     __        ______
  / _ )___  ___  __ _  ___ / /  ___ _/ /_____ _/ /__ _/ /_____ _/ / / /
 / _  / _ \/ _ \/  ' \(_-</ _ \/ _ `/  '_/ _ `/ / _ `/  '_/ _ `/_/_/_/ 
/____/\___/\___/_/_/_/___/_//_/\_,_/_/\_\\_,_/_/\_,_/_/\_\\_,_(_|_|_)  
                                                                       

Your app is starting up... See scanning below for real time status
In the meantime, here are some vitals:

 NAME      vcl-test                           
 LOCATION  /Users/hotwebmatter/repos/vcl-test 
 SERVICES  appserver, database, varnish       
 URLS                                         
  ✔ APPSERVER URLS
    ✔ https://localhost:61373 [200]
    ✔ http://localhost:61374 [200]
    ✔ http://vcl-test.lndo.site/ [200]
    ✔ https://vcl-test.lndo.site/ [200]
  ✔ VARNISH URLS
    ✔ http://localhost:61376 [200]
```

Now, you can do things like this:

```
curl -X GET http://vcl-test.lndo.site/ # Plain HTML site without caching
curl -X GET http://localhost:61376/    # Load once to build cache
curl -I -X GET http://localhost:61376/ # View headers
```

Per [Stack Overflow](https://stackoverflow.com/a/20828533):

> The two headers to look for are _X-Varnish_ and _Age_. _X-Varnish_ will contain one or two numbers in it, the numbers themselves aren't important, but they refer to requests. If a request results in a miss, Varnish fetches the page from the backend and the X-Varnish header in the response contains one number for the current request:
> 
> ```
> X-Varnish: 107856168
> ```
>
> The next time the same page is requested, it may result in a hit. If it does, Varnish fetches the page from the cache, and also adds the number from the original request:
> 
> ```
> X-Varnish: 107856170 107856168
> ```
>
> The _Age_ header says how many seconds old the cached copy is. With a miss it will be 0, and with a hit it's > 0.

Try some more tests:

```
cp web/alternate.html web/index.html   # Change visible content of index
curl -X GET http://vcl-test.lndo.site/ # Plain HTML site should show new content
curl -X GET http://localhost:61376/    # Varnish should show cached content
```

Now you've got the hang of it!

You should be able to extend these techniques to test custom VCL logic after editing the VCL file, which can be found in `./lando/custom.vcl`.