# server-management-for-bioinformatics

尽管，我们都希望能够直接上手分析数据，而不是纠结在环境配置上。但实际上，如果你们课题组就你一个做分析的，那么十有八九，你可能要负责服务器的管理。

为了避免大家走我的老路，少踩坑，所以搞了这样一个repo，记录一些我的心得经验。

如果你是一个完全的Linux新手，那先请阅读

[给初学者最少的Linux入门知识](./minimum-linux-knowledge-for-beginners.md)


如果你位于一个无人管理的服务器中，且你没有管理员权限，那么请阅读

[使用conda配置服务器软件](./conda-for-software-managment.md)

如果你接管了一个历史久远的服务器，例如ubuntu 16.04, CentOS7，虽然你不能随意升级系统，但是你有一个管理员权限，那么请阅读

[使用spack配置服务器软件](./spack-for-software-management.md)

如果你申请到一台新的服务器，里面装的比较新的CentOS或者Ubuntu系统，可以按需阅读如下内容

- [CentOS服务器软件配置](./software-management-in-centos.md)
- [Ubuntu服务器软件配置](./software-management-in-ubuntu.md)

当然，一个人的力量是有限，如果有更好的建议，欢迎提[Issue](https://github.com/xuzhougeng/server-management-for-bioinformatics/issues)