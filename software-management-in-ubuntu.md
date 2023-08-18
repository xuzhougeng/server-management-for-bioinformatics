# ubuntu的系统管理


## R语言分析环境的配置

```
./configure --enable-R-shlib=yes --with-tcltk --with-x 
```




```r
> capabilities()
       jpeg         png        tiff       tcltk         X11        aqua 
      FALSE       FALSE       FALSE       FALSE       FALSE       FALSE 
   http/ftp     sockets      libxml        fifo      cledit       iconv 
       TRUE        TRUE       FALSE        TRUE        TRUE        TRUE 
        NLS       Rprof     profmem       cairo         ICU long.double 
       TRUE        TRUE       FALSE       FALSE        TRUE        TRUE 
    libcurl 
       TRUE 
```

## python分析环境的配置