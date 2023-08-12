# server-management-for-bioinformatics

尽管，我们都希望能够直接上手分析数据，而不是纠结在环境配置上。但实际上，如果你们课题组就你一个做分析的，那么十有八九，你可能要负责服务器的管理。

为了避免大家走我的老路，少踩坑，所以搞了这样一个repo，记录一些我的心得经验。

读前须知：

- 操作系统必须是Linux，发行版可以是Ubuntu或者是CentOS
- 使用shell环境是bash
- 代码在CentOS7以上，Ubuntu 16.04以上均可运行。并未在更低版本中测试

如果你是一个完全的Linux新手，那先请阅读

[给初学者最少的Linux入门知识](./minimum-linux-knowledge-for-beginners.md)

如果你位于一个无人管理的服务器中，无论是否拥有管理员权限，都必须阅读如下内容：

- [使用conda配置服务器软件](./conda-for-software-management.md)
- [使用spack配置服务器软件](./spack-for-software-management.md)

conda和spack都可以在无管理员的权限的情况下使用，当然管理员也能使用这两个工具。于我而言，我会在一些集群环境下使用spack配置环境，在一些单机环境中，或者作为普通用户，使用conda配置环境。

如果你申请到一台新的服务器，里面装的比较新的CentOS或者Ubuntu系统，同时，你还拥有root权限，可以按需阅读如下内容：

- [CentOS服务器软件配置](./software-management-in-centos.md)
- [Ubuntu服务器软件配置](./software-management-in-ubuntu.md)

当然，一个人的力量是有限，如果有更好的建议，欢迎提[Issue](https://github.com/xuzhougeng/server-management-for-bioinformatics/issues)