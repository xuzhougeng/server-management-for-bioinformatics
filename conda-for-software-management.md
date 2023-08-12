# 使用conda管理你的软件环境

> 阅读本文需要有基础的Linux知识，必须要学习用vim编辑文本。

Conda的发展历史可以追溯到2012年，当时在美国德克萨斯州的一个名为Continuum Analytics的初创公司开始开发这个项目。这个公司后来更名为Anaconda，Inc.，并且开发了一个名为Anaconda的Python发行版，其中包含了conda。从那时起，conda就成为了Anaconda发行版的一个重要组成部分。

最初conda可能只是用来管理Python相关的环境，但是随着开源社区的加入，例如R，Ruby，Lua，Scala，Java，JavaScript，C/C++，FORTRAN等语言的开发者们也开始使用conda来管理他们的开发环境和软件包，使得conda已经发展成为一个非常强大和灵活的工具，它不仅可以用于管理Python环境和软件包，还可以用于安装和管理各种其他语言的软件包，甚至可以用于构建和分发自己的软件包。

虽然，conda的跨平台特性使得它能够在Windows，macOS和Linux等多种操作系统上运行，但考虑到大部分的生信上游项目都是在Linux环境中完成，因此后续主要以Linux为主体介绍conda的使用。

## 包管理器是选择mamba还是conda

Conda和Mamba都是包管理器，用于安装和管理软件包及其依赖关系。这两个工具在功能上非常相似，但在性能和实现上有一些区别。

1. 性能：Mamba在性能上优于Conda。Mamba使用C++和libsolv库进行依赖项解析，这使得它在处理复杂的依赖关系时比Conda更快。
1. 实现：Conda是用Python实现的，而Mamba是用C++实现的。这意味着Mamba在处理大型软件包和复杂的依赖关系时可能会比Conda更高效。
1. 成熟度：Conda是一个更成熟的项目，有更大的用户基础和更多的支持。Mamba相对较新，可能还没有Conda那么稳定。
1. 兼容性：Mamba完全兼容Conda的软件包，这意味着你可以在Mamba中安装任何Conda软件包。

由于我们生物信息学很多软件都有非常复杂的依赖关系，而一个分析流程则需要多个生信软件协作完成，我曾花了一个晚上时间都没能完成一个流程工具的配置，而同样的工作，mamba只需要不到一分钟，因此我强烈推荐使用mamba

由于mamba和conda的功能完全相同，因此在下文中，我们只会在安装软件时用到mamba，其他情况下会沿用conda。

## 什么是Channel

Channels是Conda软件包的发行途径。当你告诉conda去安装一个软件包时，它会在你配置的channels中查找这个软件包。

> 打个比方，Channel就是不同的电视频道，例如CCTV-1是综合频道，CCTV-2是财经频道，CCTV-3是综艺频道，如果你想看综艺相关的内容，而不是财经内容，你应该切换到CCTV-3上。

默认情况下，conda会使用名为defaults的channel，这个channel包含了大量的常用软件包。然而，有时候你可能需要安装一些在defaults channel中没有的软件包，或者你需要安装的软件包的某个特定版本在defaults channel中没有，这时你就需要添加其他的channel。关于channel管理，会在[mamba的使用方法](#mamba的使用方法)中介绍。

在所有channel中，有两个channel我们最为关注

- [conda-forge](https://conda-forge.org/): 这是一个由社区驱动的channel，包含了许多defaults channel中没有的软件包
- [bioconda](https://bioconda.github.io/): 这是一个专门针对生物信息学软件的conda包管理器频道


## mamba安装

mamba有两种安装方式，一种是直接安装内置mamba的mambaforge，

```
curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-$(uname)-$(uname -m).sh"
bash Mambaforge-$(uname)-$(uname -m).sh
```

如果受限于环境问题，无法通过github安装mambaforge，则可以考虑使用从清华镜像源获取miniconda的安装包，然后安装mamba

```bash
curl -L -O https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/Miniconda3-py38_4.12.0-Linux-x86_64.sh
bash Miniconda3-py38_4.12.0-Linux-x86_64.sh
```

安装结束后，需要关闭终端，重启，确保环境生效。

接着，参考[镜像配置](#镜像配置)配置下清华的镜像，再去运行如下命令

```bash
conda install -y -n base --override-channels -c conda-forge mamba 'python_abi=*=*cp*'
```

最后，查看下mamba的版本

```bash
mamaba --version

# 输出信息如下
mamba 1.4.9
conda 23.7.2
```

请保证mamba版本要大于或等于我的版本，即1.4.9，否则可能会遇到mamba无法正常安装软件的情况（TODO: 增加一个报错图）。

## channel的镜像站点配置

我们以清华镜像源为例，使用 `vim ~/.condarc` 编辑conda的配置文件，增加如下内容

```yaml
channels:
  - defaults
default_channels:
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main
custom_channels:
  conda-forge: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  bioconda: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
```

在上述配置文件中，我们设置了channels为default，其中default实际的channel罗列在default_channels下。后续如果没有用`-c`指定额外的channel时，只会在"https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main"中搜索或下载。

此外，我还在custom_channels中加上了两个自定义的channel，这意外着后续使用`-c conda-forge`就会额外搜索 "https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud" 里的内容。如果你希望默认也能搜索bioconda和conda-forge，可以使用如下配置

```yaml
channels:
  - defaults
default_channels:
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/bioconda
```

但是，我不建议这样子做，这会导致每次检索都会花很多时间，还有可能导致依赖关系无法正确的解析，使得安装的软件存在问题。

此外，如果需要配置其他镜像，请查看 [Anaconda 镜像使用帮助](https://mirrors.tuna.tsinghua.edu.cn/help/anaconda/)

除了清华的镜像站外，还有其他[联合站点](https://mirrors.cernet.edu.cn/site)，当你觉得自己从清华镜像下载速度不够时，可以考虑切换

## mamba的简明使用方法

使用mamba安装软件非常简单，只需要掌握几个常用的子命令和参数即可。

首先，我们需要确保能检索到所需要的软件, 使用的是`search`子命令

```
mamba search -c conda-forge "python=3.10"
# 如下是部分输出信息
Loading channels:
# Name                       Version           Build  Channel             
python                        3.10.0      h12debd9_0  anaconda/pkgs/main  
python                        3.10.0      h12debd9_1  anaconda/pkgs/main  
python                        3.10.0      h12debd9_2  anaconda/pkgs/main  
...
python                       3.10.12      h7a1cb2a_0  anaconda/pkgs/main  
python                       3.10.12      h955ad1f_0  anaconda/pkgs/main  
python                       3.10.12 hd12c33a_0_cpython  conda-forge
```

在上述代码中，我们使用`-c conda-forge`指定了额外的搜索channel，因此在搜索结果中会显示conda-forge来源的python。同时我们使用`"python=3.10"`的形式限制了搜索版本，因此我们得到了3.10的所有子版本的python。
当然我们可以举一反三，使用`"python>=3.10"`, `"python<=3.10"` 来搜索大于等于3.10版本的python和小于等于3.10的python。值得注意的是，这里的双引号，即`"`是不能省略的，否则shell会将其视作重定向符号。

注：`-c`是`--channel`的简写形式，两者相同，都用来指定channel。

假设，你不需要从anaconda的默认频道中检索，你可以设置参数 `--override-channels`，来覆盖原来设置的channel，那么结果只会显示conda-forge相关的内容。关于覆盖channel的重要性，会在安装部分提及。

```bash
mamba search --override-channels -c conda-forge  python=3.10

# 如下是输出部分
# Name                       Version           Build  Channel             
python                        3.10.0 h543edf9_1_cpython  conda-forge         
python                        3.10.0 h543edf9_2_cpython  conda-forge
...
python                       3.10.11 he550d4f_0_cpython  conda-forge         
python                       3.10.12 hd12c33a_0_cpython  conda-forge
```

当你搜索到软件之后，我们就可以用`install`子命令来安装，例如下面的命令就是最早用来安装mamba的命令。

```bash
conda install -y -n base --override-channels -c conda-forge mamba 'python_abi=*=*cp*'
```

> 需要注意，这里的案例虽然介绍的是conda，但实际上可以替换成mamba。只不过这个案例介绍的是mamba的安装，所以要用conda演示。

上述命令中 `-y/--yes` 表示直接安装不需要确认。 `-n/--name`表示指定要安装软件对应的环境是base。`--override-channels`和`-c`的作用跟`search`子命令中一样，不在这里赘述。
但是需要强调的是 `--override-channels`在这里非常关键，

当我们删除`--override-channels`，会有如下的输出信息

```text
conda install -n base  -c conda-forge mamba 'python_abi=*=*cp*'

# 输出信息如下
    package                    |            build
    ---------------------------|-----------------
    _libgcc_mutex-0.1          |      conda_forge           3 KB  conda-forge
    _openmp_mutex-4.5          |       2_kmp_llvm           6 KB  conda-forge
    bzip2-1.0.8                |       h7f98852_4         484 KB  conda-forge
    c-ares-1.19.1              |       hd590300_0         111 KB  conda-forge
    ca-certificates-2023.7.22  |       hbcca054_0         146 KB  conda-forge
    certifi-2023.7.22          |     pyhd8ed1ab_0         150 KB  conda-forge
    icu-70.1                   |       h27087fc_0        13.5 MB  conda-forge
    keyutils-1.6.1             |       h166bdaf_0         115 KB  conda-forge
    krb5-1.20.1                |       hf9c8cef_0         1.3 MB  conda-forge
    libarchive-3.5.2           |       hb890918_3         1.6 MB  conda-forge
    libcurl-8.1.1              |       h91b91d3_2         395 KB  defaults
    libedit-3.1.20191231       |       he28a2e2_2         121 KB  conda-forge
    libev-4.33                 |       h516909a_1         104 KB  conda-forge
    libgcc-ng-13.1.0           |       he5830b7_0         758 KB  conda-forge
    libiconv-1.17              |       h166bdaf_0         1.4 MB  conda-forge
    libnghttp2-1.52.0          |       ha637b67_1         671 KB  defaults
    libsolv-0.7.24             |       hfc55251_1         456 KB  conda-forge
    libssh2-1.10.0             |       h37d81fd_2         292 KB  defaults
    libstdcxx-ng-13.1.0        |       hfd8a6a1_0         3.7 MB  conda-forge
    libxml2-2.9.14             |       h22db469_4         771 KB  conda-forge
    libzlib-1.2.13             |       hd590300_5          60 KB  conda-forge
    llvm-openmp-16.0.6         |       h4dfa4b3_0        39.9 MB  conda-forge
    lz4-c-1.9.4                |       hcb278e6_0         140 KB  conda-forge
    lzo-2.10                   |    h516909a_1000         314 KB  conda-forge
    mamba-0.15.3               |   py38h2aa5da1_0         742 KB  conda-forge
    openssl-1.1.1v             |       hd590300_0         1.9 MB  conda-forge
    python_abi-3.8             |           2_cp38           4 KB  conda-forge
    reproc-14.2.4              |       h0b41bf4_0          30 KB  conda-forge
    reproc-cpp-14.2.4          |       hcb278e6_0          21 KB  conda-forge
    zlib-1.2.13                |       hd590300_5          91 KB  conda-forge
    zstd-1.5.2                 |       hfc55251_7         421 KB  conda-forge
    ------------------------------------------------------------
                                           Total:        69.5 MB

```

我们会发现输出的日志信息中有一条“mamba-0.15.3”，表明mamba的版本是0.15.3。之所以会出现这个情况，是因为部分库用到了defaults的旧版。

当加上`--override-channels`，就可以发现libcurl从8.1.提升为8.2.1，而libssh2从1.10.0提升为1.11.0

```text
The following packages will be downloaded:

    package                    |            build
    ---------------------------|-----------------
    _libgcc_mutex-0.1          |      conda_forge           3 KB  conda-forge
    _openmp_mutex-4.5          |       2_kmp_llvm           6 KB  conda-forge
    boltons-23.0.0             |     pyhd8ed1ab_0         296 KB  conda-forge
    bzip2-1.0.8                |       h7f98852_4         484 KB  conda-forge
    c-ares-1.19.1              |       hd590300_0         111 KB  conda-forge
    ca-certificates-2023.7.22  |       hbcca054_0         146 KB  conda-forge
    certifi-2023.7.22          |     pyhd8ed1ab_0         150 KB  conda-forge
    conda-23.7.2               |   py38h578d9bd_0         994 KB  conda-forge
    cryptography-41.0.2        |   py38hcdda232_0         1.8 MB  conda-forge
    fmt-9.1.0                  |       h924138e_0         185 KB  conda-forge
    icu-72.1                   |       hcb278e6_0        11.4 MB  conda-forge
    jsonpatch-1.32             |     pyhd8ed1ab_0          14 KB  conda-forge
    jsonpointer-2.0            |             py_0           9 KB  conda-forge
    keyutils-1.6.1             |       h166bdaf_0         115 KB  conda-forge
    krb5-1.21.1                |       h659d440_0         1.3 MB  conda-forge
    ld_impl_linux-64-2.40      |       h41732ed_0         688 KB  conda-forge
    libarchive-3.6.2           |       h039dbb9_1         824 KB  conda-forge
    libcurl-8.2.1              |       hca28451_0         364 KB  conda-forge
    libedit-3.1.20191231       |       he28a2e2_2         121 KB  conda-forge
    libev-4.33                 |       h516909a_1         104 KB  conda-forge
    libffi-3.4.2               |       h7f98852_5          57 KB  conda-forge
    libgcc-ng-13.1.0           |       he5830b7_0         758 KB  conda-forge
    libiconv-1.17              |       h166bdaf_0         1.4 MB  conda-forge
    libmamba-1.4.9             |       h658169a_0         1.5 MB  conda-forge
    libmambapy-1.4.9           |   py38he0d8f90_0         280 KB  conda-forge
    libnghttp2-1.52.0          |       h61bc06f_0         608 KB  conda-forge
    libnsl-2.0.0               |       h7f98852_0          31 KB  conda-forge
    libsolv-0.7.24             |       hfc55251_1         456 KB  conda-forge
    libsqlite-3.42.0           |       h2797004_0         809 KB  conda-forge
    libssh2-1.11.0             |       h0841786_0         265 KB  conda-forge
    libstdcxx-ng-13.1.0        |       hfd8a6a1_0         3.7 MB  conda-forge
    libuuid-2.38.1             |       h0b41bf4_0          33 KB  conda-forge
    libxml2-2.11.4             |       h0d562d8_0         688 KB  conda-forge
    libzlib-1.2.13             |       hd590300_5          60 KB  conda-forge
    llvm-openmp-16.0.6         |       h4dfa4b3_0        39.9 MB  conda-forge
    lz4-c-1.9.4                |       hcb278e6_0         140 KB  conda-forge
    lzo-2.10                   |    h516909a_1000         314 KB  conda-forge
    mamba-1.4.9                |   py38haad2881_0          50 KB  conda-forge
    ncurses-6.4                |       hcb278e6_0         860 KB  conda-forge
    openssl-3.1.2              |       hd590300_0         2.5 MB  conda-forge
    packaging-23.1             |     pyhd8ed1ab_0          45 KB  conda-forge
    pluggy-1.2.0               |     pyhd8ed1ab_0          21 KB  conda-forge
    pybind11-abi-4             |       hd8ed1ab_3          10 KB  conda-forge
    pyopenssl-23.2.0           |     pyhd8ed1ab_1         126 KB  conda-forge
    python-3.8.17              |he550d4f_0_cpython        23.4 MB  conda-forge
    python_abi-3.8             |           3_cp38           6 KB  conda-forge
    readline-8.2               |       h8228510_1         275 KB  conda-forge
    reproc-14.2.4              |       h0b41bf4_0          30 KB  conda-forge
    reproc-cpp-14.2.4          |       hcb278e6_0          21 KB  conda-forge
    ruamel.yaml-0.17.32        |   py38h01eb140_0         195 KB  conda-forge
    ruamel.yaml.clib-0.2.7     |   py38h1de0b5d_1         143 KB  conda-forge
    tk-8.6.12                  |       h27826a3_0         3.3 MB  conda-forge
    toolz-0.12.0               |     pyhd8ed1ab_0          48 KB  conda-forge
    xz-5.2.6                   |       h166bdaf_0         409 KB  conda-forge
    yaml-cpp-0.7.0             |       h27087fc_2         215 KB  conda-forge
    zlib-1.2.13                |       hd590300_5          91 KB  conda-forge
    zstd-1.5.2                 |       hfc55251_7         421 KB  conda-forge
    ------------------------------------------------------------
                                           Total:       102.1 MB

```

如果不想要用`--override-channels`，还有一种方法修改配置文件，删除默认搜索channel

```yaml
channels:
  - conda-forge
default_channels:
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main
custom_channels:
  conda-forge: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  bioconda: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
show_channel_urls: true
```


在学会安装软件后，另一个操作就是卸载软件，这就相对比较简单，只需要调用子命令`remove`

```bash
conda remove -n base mamba
```

上述命令表示从base环境中卸载mamba这个工具。当然，如果你原本就处于base环境下，是可以省去`-n base`。

最后介绍一个子简单的子命令`list`, 也就是列出当前环境下的所有安装的软件

```bash
conda list

# 输出信息
# Name                    Version                   Build  Channel
_libgcc_mutex             0.1                 conda_forge    conda-forge
_openmp_mutex             4.5                  2_kmp_llvm    conda-forge
boltons                   23.0.0             pyhd8ed1ab_0    conda-forge
brotlipy                  0.7.0           py38h27cfd23_1003    https://repo.anaconda.com/pkgs/main
bzip2                     1.0.8                h7f98852_4    conda-forge
...
```

这里小结一下这一节学到的子命令

- 搜索软件: `conda search`
- 安装软件: `mamba install`
- 卸载软件: `conda remove`
- 罗列已装软件: `conda list`

### 环境管理

为什么要学习环境管理？一方面是因为在base环境下安装软件，可能会改变一些依赖，导致conda/mamba无法正常使用。另一方面是因为一些分析软件对软件版本有特定的要求，显然不可能在一个环境下共存。

conda可以轻松管理复杂流程软件，是需要掌握`create`子命令即可，举个例子

```bash
mamba create -n rna-seq -c bioconda -c conda-forge --override-channels sra-tools pysradb fastqc fastp star=2.7.9 samtools deeptools   
```

该命令就通过mamba创建了一个环境，名为`rna-seq`, 在创建环境的同时，安装了多个软件，如sra-tools, pysradb等。

运行之后，会有如下信息

```
Looking for: ['sra-tools', 'pysradb', 'fastqc', 'fastp', 'star=2.7.9', 'samtools', 'deeptools']

bioconda/linux-64 (check zst)                       Checked  0.1s
bioconda/noarch (check zst)                         Checked  0.0s
conda-forge/linux-64 (check zst)                    Checked  0.0s
conda-forge/noarch (check zst)                     Checked  0.0s
bioconda/linux-64                                    5.6MB @   6.3MB/s  1.3s
bioconda/noarch                                      5.0MB @   5.5MB/s  1.5s
conda-forge/noarch                                  14.7MB @   6.3MB/s  2.3s
conda-forge/linux-64                                36.6MB @   7.0MB/s  9.0s
Transaction

  Prefix: /home/xzg/miniconda3/envs/rna-seq

  Updating specs:

   - sra-tools
   - pysradb
   - fastqc
   - fastp
   - star=2.7.9
   - samtools
   - deeptools


  Package                           Version  Build                Channel           Size
──────────────────────────────────────────────────────────────────────────────────────────
  Install:
──────────────────────────────────────────────────────────────────────────────────────────

  + star                             2.7.9a  h9ee0642_0           bioconda           4MB
  + font-ttf-dejavu-sans-mono          2.37  hab24e00_0           conda-forge      397kB
  + font-ttf-ubuntu                    0.83  hab24e00_0           conda-forge        2MB
  ...
  + sra-tools                         3.0.6  h9f5acd7_0           bioconda          78MB
  + deeptools                         3.5.2  pyhdfd78af_1         bioconda         161kB

  Summary:

  Install: 179 packages

  Total download: 477MB

──────────────────────────────────────────────────────────────────────────────────────────


font-ttf-inconsolata                                96.5kB @ 541.1kB/s  0.2s
font-ttf-dejavu-sans-mono                          397.4kB @   1.7MB/s  0.2s
...
libtiff                                            418.2kB @  42.3kB/s  0.1s
libcups                                              4.5MB @ 410.1kB/s  1.7s
openjdk                                            168.8MB @  14.3MB/s  5.6s
font-ttf-source-code-pro                           700.8kB @  55.3kB/s 12.7s

Downloading and Extracting Packages

Preparing transaction: done
Verifying transaction: done
Executing transaction: done

To activate this environment, use

     $ mamba activate rna-seq

To deactivate an active environment, use

     $ mamba deactivate

```

上述信息可以分为如下几个步骤

1. 在不同channel中检索软件
1. 解析依赖关系，确定需要下载的软件
1. 执行下载和安装
1. 完成后输出相关提示信息

创建环境之后，我们可以用`activate`子命令启动对应的环境。

```bash
conda activate rna-seq
```

这里之所以使用conda，而不是mamba，是因为如果你的mamba如果是通过conda安装，就会如下的提示信息，但conda是通用的，就不会有这个信息。

```bash
Run 'mamba init' to be able to run mamba activate/deactivate
and start a new shell session. Or use conda to activate/deactivate.
```

启动环境之后，就可以调用其中的工具，例如

```bash
STAR --verison
# 输出信息如下
2.7.9a
```

这里补充一个`mamba install`命令的另外一个用途，那就是更改软件的安装版本，以这里安装的STAR为例，如果需要更新成2.7.10b版本，且Build为h9ee0642_0，命令可以写作

```bash
mamba install -c bioconda -c conda-forge STAR=2.7.10b=h9ee0642_0

STAR --version
# 输出信息如下
2.7.10b
```

再补充一个知识点，conda的`acitvate`在不同版本conda中变化很大，例如你想要在shell脚本中使用`conda activate 环境名`的方式启用环境，在一些版本中是可行的，在某一些版本会提示找不到`activate`。
因此一种更好的方法是通过`run`子命令，例如

```bash
conda run -n rna-seq STAR --version
```

启动环境后，如果需要退出当前环境，只需要运行`conda deactivate`即可。

如果你需要**删除**某个指定环境，这里有两种方式

一种是使用`remove`子命令，通过使用`--all`表明删除指定环境下的所有内容，效果就是删除指定环境了。


```bash
conda remove -n rna-seq --all
```

一种是用`env`子命令下的`remove`命令，使用`--name`指定待删除的环境即可。

```bash
conda env remove --name rna-seq
```

环境管理中另外一个使用的命令是`conda env export`, 它可以导出指定环境的软件版本信息

```bash
conda env export --name rna-seq --file rna-seq.yaml
```

上述参数中`--name`用于指定待导出的环境是"rna-seq"，保存的文件是"rna-seq.yaml"。

该命令的优势是，可以让你的分析环境可以被其他人导入，用于保证可重复性。我们可以使用`mamba env create`从刚才导出的文件中，创建一个完全一样分析环境。注意，这里用的不是`conda create`。

```
mamba env create -f rna-seq.yaml -n rna-seq2
```

上述命令就会从rna-seq.yaml读取软件信息，然后创建一个名为"rna-seq2"的环境。


小结一下这一节的子命令

- 创建环境: `mamba create`
- 启动: `conda activate`
- 推出: `codna deactivate`
- 运行某个环境中的软件: `conda run`
- 删除环境: `conda remove` 指定参数 `--all` 或 `conda env remove --name`
- 导出环境`conda env export`
- 导入环境`mamba env create`



## 其他

强烈建议不要自启动base环境，这会导致一些工具出现编译问题，设置方法如下

```
conda config --set auto_activate_base false
```

建议显示channel的url，方便了解安装软件的来源

```
conda config --set show_channel_urls yes
```



参考资料
1. [Conda or Mamba for production?](https://labs.epi2me.io/conda-or-mamba-for-production/)
1. [Conda vs Mamba confusion: what should be used when building custom docker images?](https://stackoverflow.com/questions/72552858/conda-vs-mamba-confusion-what-should-be-used-when-building-custom-docker-imag)
1. [Mamba documentation](https://mamba.readthedocs.io/en/latest/)