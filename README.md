# 实验一：使用github workflow去编译你的linux kernel
# 好处
* 编译快15min搞定
* 不占硬盘，直接微调、下载、安装、测试、完事。
# 使用:
1. fork
2. 在`action secrets` (https://github.com/你自己的账号/CQU-linux-kernel-exp1/settings/secrets/actions/new) 里面添加secrets如下
   
| secrets name | secrets |
| ------------ | ------- |
| ID           | ******* |
| NAME         | ******* |
3. 运行`build.yml`这个`workflow`
4. 然后在`artifict`里面下载编译好的内核，用deb就行了，对于module部分还不知道咋编译成deb，所以modules部分我们用[ubuntu编译好的](https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.4/linux-modules-5.4.0-050400-generic_5.4.0-050400.201911242031_amd64.deb)，不影响，下载 `amd64` 的 `modules` 就可以了。
5. 然后解压下载的deb内核，dpkg安装所有。然后测试的时候系统调用号是`335`注意改一下。

# DEBUG
1. 如果需要自定义系统内核版本，请修改`build.yml`里面的env部分，注意每个版本的其他文件的路径。还有就是我是直接把自己写的部分tee加入到末尾的，没有考虑`#ifdef`之类的
2. 确定系统调用号符合预期，系统调用号生成是根据replace.sh里面遍历`KERNEL_SYSCALL_TBL_PATH`每一行找到可用的号，确定这个号是正确的，workflow日志里面会打印这个号，在`generate file`部分搜索`SYSCALL_NUM found`就可以找到。
3. 其他就没什么出错了吧应该
