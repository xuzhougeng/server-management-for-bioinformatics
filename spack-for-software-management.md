# 使用spack管理你的软件环境

Spack这块工具是我在解决[R语言的一个依赖报错][【无用的知识增加了】如何安装一个R包]时所找到的一个强大包管理工具。

Spack支持多个平台和环境上的软件的多个版本和配置，特别适用于大型超级计算中心，它是一种非破坏性的工具，可在同一系统上同时存在多个配置，用户可以使用简单的规范语法来指定版本和配置选项。

## spack安装

为了方便演示，我们默认在**家目录**下操作，如果不确定当前目录是否为家目录，可以用`cd ~`切换回家目录。

spack的安装非常简便，只需要通过git从GitHub上克隆到本地。

```bash
git clone -c feature.manyFiles=true https://github.com/spack/spack.git
```

之后需要将如下两句添加到你的`.bashrc`文件中，可以用`vim ~/.bashrc`进行编辑

```bash
export PATH=$PATH:$HOME/spack/bin
. $HOME/spack/share/spack/setup-env.sh
```

第一行用于添加spack的执行路径，第二行用于添加shell支持。

检查下版本，确认下安装是否成功。

```bash
spack --version
# 输出信息如下
0.21.0.dev0 (49f3681a12ab21de468635e7c50e1b34d1d8ebcc)
```

## 使用spack安装软件

首先，我们需要确定spacke能够安装哪些软件。通过`list`子命令，可以发现，spack目前支持7321个软件的管理（截止到2023-08-08），同时每个软件都包含多个版本。

```bash
spack list --count
# 输出信息
7321 
```

如果想要查找软件，可以直接在`list`后面跟软件名，例如python

```bash
spack list python

py-antlr4-python3-runtime    py-mmtf-python             py-python-dotenv          py-python-ldap           py-python-oauth2       py-python3-xlib
py-avro-python3              py-mysql-connector-python  py-python-editor          py-python-levenshtein    py-python-picard       py-pythonqwt
py-biopython                 py-openslide-python        py-python-engineio        py-python-libsbml        py-python-ptrace       py-pythonsollya
py-bx-python                 py-psij-python             py-python-fmask           py-python-logstash       py-python-rapidjson    py-scientificpython
py-dnspython                 py-python-benedict         py-python-fsutil          py-python-louvain        py-python-slugify      py-spython
py-gitpython                 py-python-bioformats       py-python-gitlab          py-python-lsp-jsonrpc    py-python-socketio     py-systemd-python
py-google-api-python-client  py-python-box              py-python-hostlist        py-python-lsp-server     py-python-sotools      py-types-python-dateutil
py-ipython                   py-python-certifi-win32    py-python-igraph          py-python-lzo            py-python-subunit      py-wxpython
py-ipython-cluster-helper    py-python-constraint       py-python-javabridge      py-python-magic          py-python-swiftclient  python
py-ipython-genutils          py-python-crfsuite         py-python-jenkins         py-python-mapnik         py-python-utils        r-findpython
py-kb-python                 py-python-daemon           py-python-jose            py-python-markdown-math  py-python-xlib         xtensor-python
py-meson-python              py-python-dateutil         py-python-json-logger     py-python-memcached      py-python-xmp-toolkit
py-mkdocstrings-python       py-python-docs-theme       py-python-keystoneclient  py-python-multipart      py-python3-openid
==> 76 packages
```

这会查找所有名字包含python的软件

因为每个软件都包括多个版本，如果想要了解，指定的软件包含哪些版本，可以用`info`子命令

```bash
spack info python

Package:   python

Description:
    The Python programming language.

Homepage: https://www.python.org/

Preferred version:  
    3.10.12    https://www.python.org/ftp/python/3.10.12/Python-3.10.12.tgz

Safe versions:  
    3.11.4     https://www.python.org/ftp/python/3.11.4/Python-3.11.4.tgz
    3.11.3     https://www.python.org/ftp/python/3.11.3/Python-3.11.3.tgz
    3.11.2     https://www.python.org/ftp/python/3.11.2/Python-3.11.2.tgz
    ...

Deprecated versions:  
    3.7.17     https://www.python.org/ftp/python/3.7.17/Python-3.7.17.tgz
    ...

Variants:
    Name [Default]            When                              Allowed values    Description
    ======================    ==============================    ==============    ================================================================

    build_system [generic]    --                                generic           Build systems supported by the package
    bz2 [on]                  --                                on, off           Build bz2 module
    crypt [on]                [@:3.12 arch=cray-None-None,      on, off           Build crypt module
                              @:3.12 arch=darwin-None-None,                       
                              @:3.12 arch=linux-None-None]                        
    ctypes [on]               --                                on, off           Build ctypes module
    dbm [on]                  --                                on, off           Build dbm module
    debug [off]               --                                on, off           debug build with extra checks (this is high overhead)
    libxml2 [on]              --                                on, off           Use a gettext library build with libxml2
    lzma [on]                 --                                on, off           Build lzma module
    nis [off]                 --                                on, off           Build nis module
    optimizations [off]       --                                on, off           Enable expensive build-time optimizations, if available
    ...

Build Dependencies:
    bzip2  expat  gdbm  gettext  libffi  libnsl  libxcrypt  ncurses  openssl  pkgconfig  readline  sqlite  tcl  tix  tk  uuid  xz  zlib

Link Dependencies:
    bzip2  expat  gdbm  gettext  libffi  libnsl  libxcrypt  ncurses  openssl  readline  sqlite  tcl  tix  tk  uuid  xz  zlib

Run Dependencies:
    None
```

在输出信息中，首先有三种版本，Prefered version表示默认会安装的版本， Safe version是可以安装的版本，而Deprecated version则是不建议安装的版本。其次是Variants，是后续安装时一些其他选项，用于配置软件安装时的编译行为。最后是依赖关系，Build Dependencies是该软件编译时的依赖环境，而Link Dependencies则是其链接阶段的依赖，最后Run Dependencies则是运行时的依赖。

最简单的安装方式，就是直接写软件名

```bash
spack install python

# 安装过程中的日志
==> Installing libiconv-1.17-5wgw2frncbu4uuaswrjwlqviw3ofnvpx [1/26]
==> No binary for libiconv-1.17-5wgw2frncbu4uuaswrjwlqviw3ofnvpx found: installing from source
==> Fetching https://mirror.spack.io/_source-cache/archive/8f/8f74213b56238c85a50a5329f77e06198771e70dd9a739779f4c02f65d971313.tar.gz
==> No patches needed for libiconv
==> libiconv: Executing phase: 'autoreconf'
==> libiconv: Executing phase: 'configure'
==> libiconv: Executing phase: 'build'
==> libiconv: Executing phase: 'install'
==> libiconv: Successfully installed libiconv-1.17-5wgw2frncbu4uuaswrjwlqviw3ofnvpx
  Stage: 2.65s.  Autoreconf: 0.00s.  Configure: 13.63s.  Build: 9.53s.  Install: 0.72s.  Post-install: 0.07s.  Total: 26.90s
[+] /home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/libiconv-1.17-5wgw2frncbu4uuaswrjwlqviw3ofnvpx
...
==> Installing python-3.10.12-eqs4hdifw22lhurxlyflu7sefyp23gik [26/26]
==> No binary for python-3.10.12-eqs4hdifw22lhurxlyflu7sefyp23gik found: installing from source
==> Fetching https://mirror.spack.io/_source-cache/archive/a4/a43cd383f3999a6f4a7db2062b2fc9594fefa73e175b3aedafa295a51a7bb65c.tgz
==> Applied patch /home/xzg/spack/var/spack/repos/builtin/packages/python/python-3.7.4+-distutils-C++.patch
==> Applied patch /home/xzg/spack/var/spack/repos/builtin/packages/python/python-3.7.4+-distutils-C++-testsuite.patch
==> Applied patch /home/xzg/spack/var/spack/repos/builtin/packages/python/tkinter-3.10.patch
==> Ran patch() for python
==> python: Executing phase: 'configure'
==> python: Executing phase: 'build'
==> python: Executing phase: 'install'
==> python: Successfully installed python-3.10.12-eqs4hdifw22lhurxlyflu7sefyp23gik
  Stage: 9.08s.  Configure: 42.09s.  Build: 23.81s.  Install: 15.57s.  Post-install: 2.09s.  Total: 1m 33.01s
[+] /home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/python-3.10.12-eqs4hdifw22lhurxlyflu7sefyp23gik
```

这过程中，spack会先去寻找依赖软件是否在**本地上**有已编译的二进制版本，如果没有则会下载源码进行编译。

如果你需要安装特定版本的python，可以通过`软件@版本`的方式来指定，例如我需要安装3.11.4

```bash
spack install python@3.11.4

# 运行日志
[+] /home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/bzip2-1.0.8-bchfo3dqe3tfdmtdvr52fqi6vakzz5hp
[+] /home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/libmd-1.0.4-albqon4d65o77vjenuguc66iamgvn2um
[+] /home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/ncurses-6.4-bc5po6uikufvmh44fbinpyqhj2wmtvzk
[+] /home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/libiconv-1.17-5wgw2frncbu4uuaswrjwlqviw3ofnvpx
[+] /home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/xz-5.4.1-jmrvfgumstx5gp7vpemeite6ntlsq7s6
[+] /home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/zlib-1.2.13-sd72qapisgzmqijn3owcjufhobdg7njv
[+] /home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/zstd-1.5.5-omzlhsgb3avmtgmjuvv2lcgqxm4br7fl
[+] /home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/libffi-3.4.4-7d2ox2p4gm3umf4xni3ubdfhgtpqr5ns
[+] /home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/libxcrypt-4.4.35-uugqbd2rpwi3q6u5udpumwpmdkxa4bt2
[+] /home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/pkgconf-1.9.5-y564voy5yuf63jx4dhqo55qxhxpmfpej
[+] /home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/libbsd-0.11.7-jwlkwfx6pu3vsyauqhgzqb2scfoskpvf
[+] /home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/readline-8.2-xpshz7nykc5tvodyv3pqiz44lswui623
[+] /home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/pigz-2.7-jhij4f7k5uovxswidjjabbri7neqvjq4
[+] /home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/openssl-3.1.2-4h5hjrftmha3f2ytzkeqco2zhxdvkolk
[+] /home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/util-linux-uuid-2.38.1-7fxigyj7rhvus25pllnryfjz3w3snxvs
[+] /home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/libxml2-2.10.3-yg7le5kyq5hb42zdlekmerpqub273sng
[+] /home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/expat-2.5.0-kox5ijiifrsp52oaxdavkt6nm5rskgy3
[+] /home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/sqlite-3.42.0-e7rzu2ibwu6vfjg7cszwy5bxspdnq5hw
[+] /home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/gdbm-1.23-gkfsa7qank6dz4mb3wcb4euvs7dwgszz
[+] /home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/tar-1.34-ttuucyay6kamoyrjiavh7k3d4hgpwgqn
[+] /home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/gettext-0.21.1-ji4k5od3gvbihryt66f6jq7uyzcbmmto
==> Installing python-3.11.4-hdbmuy4wunsoxuuwi4gwfu5phr3lkcti [22/22]
==> No binary for python-3.11.4-hdbmuy4wunsoxuuwi4gwfu5phr3lkcti found: installing from source
==> Fetching https://mirror.spack.io/_source-cache/archive/85/85c37a265e5c9dd9f75b35f954e31fbfc10383162417285e30ad25cc073a0d63.tgz
==> Applied patch /home/xzg/spack/var/spack/repos/builtin/packages/python/python-3.7.4+-distutils-C++-testsuite.patch
==> Applied patch /home/xzg/spack/var/spack/repos/builtin/packages/python/python-3.11-distutils-C++.patch
==> Applied patch /home/xzg/spack/var/spack/repos/builtin/packages/python/tkinter-3.11.patch
==> Ran patch() for python
==> python: Executing phase: 'configure'
==> python: Executing phase: 'build'
==> python: Executing phase: 'install'
==> python: Successfully installed python-3.11.4-hdbmuy4wunsoxuuwi4gwfu5phr3lkcti
  Stage: 9.29s.  Configure: 48.86s.  Build: 26.52s.  Install: 14.13s.  Post-install: 2.29s.  Total: 1m 41.34s
[+] /home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/python-3.11.4-hdbmuy4wunsoxuuwi4gwfu5phr3lkcti
```

此时会相对快很多，因为依赖已经被编译过，所以只需要编译安装Python即可。

除了默认编译选项外，spack还可以按照需求根据设置编译参数，例如在Vairants中debug是关闭状态(off)，可以用`+debug`开启

```bash
spack install python@3.11.4+debug

# 运行日志
...
==> Installing python-3.11.4-t5suk36k5vtcgv6mbrdxc3gcsqecg2p4 [22/22]
==> No binary for python-3.11.4-t5suk36k5vtcgv6mbrdxc3gcsqecg2p4 found: installing from source
==> Using cached archive: /home/xzg/spack/var/spack/cache/_source-cache/archive/85/85c37a265e5c9dd9f75b35f954e31fbfc10383162417285e30ad25cc073a0d63.tgz
==> Applied patch /home/xzg/spack/var/spack/repos/builtin/packages/python/python-3.7.4+-distutils-C++-testsuite.patch
==> Applied patch /home/xzg/spack/var/spack/repos/builtin/packages/python/python-3.11-distutils-C++.patch
==> Applied patch /home/xzg/spack/var/spack/repos/builtin/packages/python/tkinter-3.11.patch
==> Ran patch() for python
==> python: Executing phase: 'configure'
==> python: Executing phase: 'build'
==> python: Executing phase: 'install'
==> python: Successfully installed python-3.11.4-hky2okjkxl5ujztoy6fjlvzxnol3hrzs
  Stage: 0.96s.  Configure: 46.57s.  Build: 23.85s.  Install: 20.80s.  Post-install: 2.45s.  Total: 1m 34.85s
[+] /home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/python-3.11.4-hky2okjkxl5ujztoy6fjlvzxnol3hrzs
```

用`~`关闭某些配置，例如默认crypt是开启状态（on），可以用`~bz2`关闭

```bash
spack install 'python@3.11.4~bz2'

# 运行日志
...
==> Installing python-3.11.4-iylt7ftqjiv3cdlfssv3mqwhgjd6mmuh [22/22]
==> No binary for python-3.11.4-iylt7ftqjiv3cdlfssv3mqwhgjd6mmuh found: installing from source
==> Using cached archive: /home/xzg/spack/var/spack/cache/_source-cache/archive/85/85c37a265e5c9dd9f75b35f954e31fbfc10383162417285e30ad25cc073a0d63.tgz
==> Applied patch /home/xzg/spack/var/spack/repos/builtin/packages/python/python-3.7.4+-distutils-C++-testsuite.patch
==> Applied patch /home/xzg/spack/var/spack/repos/builtin/packages/python/python-3.11-distutils-C++.patch
==> Applied patch /home/xzg/spack/var/spack/repos/builtin/packages/python/tkinter-3.11.patch
==> Ran patch() for python
==> python: Executing phase: 'configure'
==> python: Executing phase: 'build'
==> python: Executing phase: 'install'
==> python: Successfully installed python-3.11.4-iylt7ftqjiv3cdlfssv3mqwhgjd6mmuh
  Stage: 0.92s.  Configure: 41.85s.  Build: 23.76s.  Install: 13.91s.  Post-install: 2.33s.  Total: 1m 23.01s
[+] /home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/python-3.11.4-iylt7ftqjiv3cdlfssv3mqwhgjd6mmuh

```

当然如果你并不了解各个编译选项的意义，可以不需要配置Variant，直接默认来即可。

另外，需要注意的是并不是所有Vairantis的选项都是可以用，有些选项启动后，会出现循环依赖的报错。
 
```bash
$ spack install python@3.11.4+tkinter    

==> Error: concretization failed for the following reasons:

   1. Cyclic dependency detected between 'xcb-proto' and 'xcb-proto' (consider changing variants to avoid the cycle)
   2. Cyclic dependency detected between 'xcb-proto' and 'tk' (consider changing variants to avoid the cycle)
   3. Cyclic dependency detected between 'xcb-proto' and 'python' (consider changing variants to avoid the cycle)
   4. Cyclic dependency detected between 'xcb-proto' and 'libxcb' (consider changing variants to avoid the cycle)
   5. Cyclic dependency detected between 'xcb-proto' and 'libx11' (consider changing variants to avoid the cycle)
   ...
```

最后，我们可以用`spack find`查看当前所有已经安装的软件

```bash
spack find

# 输出信息如下 
-- linux-centos8-broadwell / gcc@8.5.0 --------------------------
berkeley-db@18.1.40                 expat@2.5.0     libffi@3.4.4      libxml2@2.10.3  pigz@2.7        python@3.11.4  tar@1.34                zstd@1.5.5
bzip2@1.0.8                         gdbm@1.23       libiconv@1.17     ncurses@6.4     pkgconf@1.9.5   python@3.11.4  util-linux-uuid@2.38.1
ca-certificates-mozilla@2023-05-30  gettext@0.21.1  libmd@1.0.4       openssl@3.1.2   python@3.10.12  readline@8.2   xz@5.4.1
diffutils@3.9                       libbsd@0.11.7   libxcrypt@4.4.35  perl@5.38.0     python@3.11.4   sqlite@3.42.0  zlib@1.2.13
==> 29 installed packages
```

从中可以观察到我们有多个python。

默认这些安装的软件并不会出现在我们当前的环境中，只有当我们使用`spack load`子命令去加载具体的软件才行。以python为例

```bash
spack load python
# 输出信息如下
==> Error: python matches multiple packages.
  Matching packages:
    eqs4hdi python@3.10.12%gcc@8.5.0 arch=linux-centos8-broadwell
    iylt7ft python@3.11.4%gcc@8.5.0 arch=linux-centos8-broadwell
    hdbmuy4 python@3.11.4%gcc@8.5.0 arch=linux-centos8-broadwell
    hky2okj python@3.11.4%gcc@8.5.0 arch=linux-centos8-broadwell
  Use a more specific spec (e.g., prepend '/' to the hash).

```

我们发现，由于我们存在多个python版本，spack会有一个报错信息，同时提供各个python版本的hash值，并给了一个解决方案。根据它的建议，我们对加载方式进行修改

```bash
# 加载3.10
spack load python/eqs4hdi
which python
# ~/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/python-3.10.12-eqs4hdifw22lhurxlyflu7sefyp23gik/bin/python

# 加载3.11
spack load python/hky2okj
which python
#~/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/python-3.11.4-hky2okjkxl5ujztoy6fjlvzxnol3hrzs/bin/python 
```

此时查看环境变量`PATH`，就会发现，load这一步实际上是加载了python和对应的依赖环境

```bash
echo $PATH | tr ':' '\n'
# 输出结果如下
/home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/python-3.11.4-hky2okjkxl5ujztoy6fjlvzxnol3hrzs/bin
/home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/util-linux-uuid-2.38.1-7fxigyj7rhvus25pllnryfjz3w3snxvs/bin
/home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/sqlite-3.42.0-e7rzu2ibwu6vfjg7cszwy5bxspdnq5hw/bin
/home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/openssl-3.1.2-4h5hjrftmha3f2ytzkeqco2zhxdvkolk/bin
/home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/perl-5.38.0-grizg7jxqfnp7behun7m5oe7rynzr6gq/bin
/home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/berkeley-db-18.1.40-4n45fegb6qdcgebfudvakjfkm4y46dod/bin
/home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/gettext-0.21.1-ji4k5od3gvbihryt66f6jq7uyzcbmmto/bin
/home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/tar-1.34-ttuucyay6kamoyrjiavh7k3d4hgpwgqn/bin
/home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/zstd-1.5.5-omzlhsgb3avmtgmjuvv2lcgqxm4br7fl/bin
/home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/pigz-2.7-jhij4f7k5uovxswidjjabbri7neqvjq4/bin
/home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/libxml2-2.10.3-yg7le5kyq5hb42zdlekmerpqub273sng/bin
/home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/xz-5.4.1-jmrvfgumstx5gp7vpemeite6ntlsq7s6/bin
/home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/gdbm-1.23-gkfsa7qank6dz4mb3wcb4euvs7dwgszz/bin
/home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/readline-8.2-xpshz7nykc5tvodyv3pqiz44lswui623/bin
/home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/ncurses-6.4-bc5po6uikufvmh44fbinpyqhj2wmtvzk/bin
/home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/pkgconf-1.9.5-y564voy5yuf63jx4dhqo55qxhxpmfpej/bin
/home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/expat-2.5.0-kox5ijiifrsp52oaxdavkt6nm5rskgy3/bin
/home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/bzip2-1.0.8-bchfo3dqe3tfdmtdvr52fqi6vakzz5hp/bin
/home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/diffutils-3.9-i5pzylrljecytovmpxyjlre6l4kojryr/bin
/home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/libiconv-1.17-5wgw2frncbu4uuaswrjwlqviw3ofnvpx/bin
/home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/python-3.10.12-eqs4hdifw22lhurxlyflu7sefyp23gik/bin
/home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/util-linux-uuid-2.38.1-7fxigyj7rhvus25pllnryfjz3w3snxvs/bin
/home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/sqlite-3.42.0-e7rzu2ibwu6vfjg7cszwy5bxspdnq5hw/bin
/home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/openssl-3.1.2-4h5hjrftmha3f2ytzkeqco2zhxdvkolk/bin
/home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/perl-5.38.0-grizg7jxqfnp7behun7m5oe7rynzr6gq/bin
/home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/berkeley-db-18.1.40-4n45fegb6qdcgebfudvakjfkm4y46dod/bin
/home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/gettext-0.21.1-ji4k5od3gvbihryt66f6jq7uyzcbmmto/bin
/home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/tar-1.34-ttuucyay6kamoyrjiavh7k3d4hgpwgqn/bin
/home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/zstd-1.5.5-omzlhsgb3avmtgmjuvv2lcgqxm4br7fl/bin
/home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/pigz-2.7-jhij4f7k5uovxswidjjabbri7neqvjq4/bin
/home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/libxml2-2.10.3-yg7le5kyq5hb42zdlekmerpqub273sng/bin
/home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/xz-5.4.1-jmrvfgumstx5gp7vpemeite6ntlsq7s6/bin
/home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/gdbm-1.23-gkfsa7qank6dz4mb3wcb4euvs7dwgszz/bin
/home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/readline-8.2-xpshz7nykc5tvodyv3pqiz44lswui623/bin
/home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/ncurses-6.4-bc5po6uikufvmh44fbinpyqhj2wmtvzk/bin
/home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/pkgconf-1.9.5-y564voy5yuf63jx4dhqo55qxhxpmfpej/bin
/home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/expat-2.5.0-kox5ijiifrsp52oaxdavkt6nm5rskgy3/bin
/home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/bzip2-1.0.8-bchfo3dqe3tfdmtdvr52fqi6vakzz5hp/bin
/home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/diffutils-3.9-i5pzylrljecytovmpxyjlre6l4kojryr/bin
/home/xzg/spack/opt/spack/linux-centos8-broadwell/gcc-8.5.0/libiconv-1.17-5wgw2frncbu4uuaswrjwlqviw3ofnvpx/bin
...
```

与load相对的操作就是unload

```bash
spack unload python/eqs4hdi
spack unload python/hky2okj
```

最后讲讲软件卸载，跟load一样，如果存在同个软件多个版本时，需要指定具体版本

```bash
spack uninstall python/hky2okj
# 输出信息如下
==> The following 1 packages will be uninstalled:

    -- linux-centos8-broadwell / gcc@8.5.0 --------------------------
    hky2okj python@3.11.4

==> Do you want to proceed? [y/N] y
==> Successfully uninstalled python@3.11.4%gcc@8.5.0+bz2+crypt+ctypes+dbm+debug+libxml2+lzma~nis~optimizations+pic+pyexpat+pythoncmd+readline+shared+sqlite3+ssl~tkinter+uuid+zlib build_system=generic patches=13fa8bf,b0615b2,f2fd060 arch=linux-centos8-broadwell/hky2okj
```

当然也可以卸载所有同名软件

```bash
pack uninstall --all python
# 输出信息如下
==> The following 3 packages will be uninstalled:

    -- linux-centos8-broadwell / gcc@8.5.0 --------------------------
    eqs4hdi python@3.10.12  iylt7ft python@3.11.4  hdbmuy4 python@3.11.4

==> Do you want to proceed? [y/N] y
==> Successfully uninstalled python@3.11.4%gcc@8.5.0+bz2+crypt+ctypes+dbm~debug+libxml2+lzma~nis~optimizations+pic+pyexpat+pythoncmd+readline+shared+sqlite3+ssl~tkinter+uuid+zlib build_system=generic patches=13fa8bf,b0615b2,f2fd060 arch=linux-centos8-broadwell/hdbmuy4
==> Successfully uninstalled python@3.11.4%gcc@8.5.0~bz2+crypt+ctypes+dbm~debug+libxml2+lzma~nis~optimizations+pic+pyexpat+pythoncmd+readline+shared+sqlite3+ssl~tkinter+uuid+zlib build_system=generic patches=13fa8bf,b0615b2,f2fd060 arch=linux-centos8-broadwell/iylt7ft
==> Successfully uninstalled python@3.10.12%gcc@8.5.0+bz2+crypt+ctypes+dbm~debug+libxml2+lzma~nis~optimizations+pic+pyexpat+pythoncmd+readline+shared+sqlite3+ssl~tkinter+uuid+zlib build_system=generic patches=0d98e93,7d40923,f2fd060 arch=linux-centos8-broadwell/eqs4hdi

```

`spack uninstall`并只会卸载给定的软件，软件安装时所用的依赖并不会被卸载。如果你需要清理这部分内容，就需要用的`spack gc`

```bash
spack gc
# 输出信息如下
==> The following 25 packages will be uninstalled:

    -- linux-centos8-broadwell / gcc@8.5.0 --------------------------
    4n45feg berkeley-db@18.1.40                 gkfsa7q gdbm@1.23       albqon4 libmd@1.0.4       grizg7j perl@5.38.0    ttuucya tar@1.34
    bchfo3d bzip2@1.0.8                         ji4k5od gettext@0.21.1  uugqbd2 libxcrypt@4.4.35  jhij4f7 pigz@2.7       7fxigyj util-linux-uuid@2.38.1
    igqmbsw ca-certificates-mozilla@2023-05-30  jwlkwfx libbsd@0.11.7   yg7le5k libxml2@2.10.3    y564voy pkgconf@1.9.5  jmrvfgu xz@5.4.1
    i5pzylr diffutils@3.9                       7d2ox2p libffi@3.4.4    bc5po6u ncurses@6.4       xpshz7n readline@8.2   sd72qap zlib@1.2.13
    kox5iji expat@2.5.0                         5wgw2fr libiconv@1.17   4h5hjrf openssl@3.1.2     e7rzu2i sqlite@3.42.0  omzlhsg zstd@1.5.5

==> Do you want to proceed? [y/N] 
```

需要注意的是，一旦清理后，那么本地预编译版本也同样被清理。例如，如果我卸载了所有的python，并卸载了依赖库，那么再次安装python时，就需要重新编译依赖库。

小结

- spack list: 获取当前可以安装的软件
- spack info: 获取指定软件的详细信息
- spack find: 获取当前已经安装的软件
- spack install: 安装软件
- spack uninstall： 卸载安装的软件
- spack gc: 清理不再使用的依赖
- spack load: 加载已安装的软件到当前的环境中
- spack unload: 从当前的环境中卸载加载的软件

## 利用spack管理环境

spack使用`env`子命令进行环境的管理，使用`-h`参数可以看到更详细的信息

```bash
$ spack env -h
usage: spack env [-h] SUBCOMMAND ...

manage virtual environments

positional arguments:
  SUBCOMMAND
    activate   set the current environment
    deactivate
               deactivate any active environment in the shell
    create     create a new environment
    remove (rm)
               remove an existing environment
    list (ls)  list available environments
    status (st)
               print whether there is an active environment
    loads      list modules for an installed environment '(see spack module loads)'
    view       manage a view associated with the environment
    update     update environments to the latest format
    revert     restore environments to their state before update
    depfile    generate a depfile from the concrete environment specs
```

假如，我们需要建立名为rna-seq环境，包含 sra-tools, fastqc, fastp, star和samtools 

第一步，创建环境

```bash
mkdir -p rna-seq
spack env create --with-view view --dir rna-seq

# 输出信息
==> Created environment in /home/xzg/rna-seq
==> You can activate this environment with:
==>   spack env activate /home/xzg/rna-seq
```

第二步，在环境中添加软件。

```bash
spack -e rna-seq add sra-tools fastqc fastp star samtools
```

其中`-e`指定了环境是rna-seq，`add`用于添加软件。注意`-e`必须在`add`之前，因为它不是`add`的参数

第三步，为环境安装软件

```bash
spack -e rna-seq install
```

这一步，它会根据你配置的软件，进行解析，然后逐一安装。由于都是编译工作，所以时间会非常久。

第四步，启动环境

```bash
spack env activate rna-seq
```

这一步会将rna-seq这个环境中的所有相关软件都加载到环境中。


参考资料

 
- [【无用的知识增加了】如何安装一个R包]: https://mp.weixin.qq.com/s/Cb5MEsThcXNDXCFrE3spsg