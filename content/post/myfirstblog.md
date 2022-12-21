---
title: "Myfirstblog"
date: 2022-12-18T14:37:59+08:00
---
# 江江的Linux操作系统课程学习
### 学习笔记
- 搜索查找类
###### 1、find
```
#find指令  将从指定目录向下递归的遍历其各个子目录，将满足条件的文件或者目录显示在终端
find [搜索范围] [选项]
#选项说明
#-name <查询方式>   按照指定的文件名查找模式查找文件
#-user <用户名>		查找属于指定用户名所有文件
#-size <文件大小>   按照指定的文件大小查找文件

#按文件名，根据名称查找/home目录下的hello.txt文件
find /home -name hello.txt
#按拥有者，查找/opt目录下，用户名称为root的文件
find /opt -user root
#查找整个linux系统下大于20M的文件（+n 大于    -n 小于    n 等于）
find / -size +20M
#查询根目录下，所有后缀为.txt的文件
find / -name *.txt
```  
###### 2、locate
```
#locate指令  可以快速定位文件路径。locate指令利用事先建立的系统中所有文件名称及路径的locate数据库实现快速定位给定的文件。locate指令无需遍历整个文件系统，查询速度较快。为了保证查询结果的准确度，管理员必须顶起更新locate时刻。
locate 搜索文件
#由于locate指令基于数据库进行查询，所以第一次运行前。必须使用updatedb指令创建locate数据库

#使用locate指令快速定位hello.txt文件所在目录
updatedb
locate hello.txt
```
###### 3、grep & 管道符号 |
```
#grep过滤查找
#管道符 "|" ,表示将前一个命令的处理结果，输出传递给后面的命令处理。

grep [选项] 查找内容 源文件

#选项
# -n		显示匹配行及行号
# -i		忽略字母大小写

#应用实例 ： 请在hello.txt文件中，查找 "yes" 所在行，并且显示行号
cat hello.txt | grep -ni yes
#cat hello.txt  将hello.txt的内容浏览出来
# | 是将cat浏览出来的内容交给后面的命令处理
#grep yes  是将 | 交过来的内容进行过滤查找

```
+ 压缩和解压缩类
###### 1、gzip & gunzip
```
#gzip用于压缩
#gunzip用于解压

gzip 文件				#压缩文件，只能将文件压缩为 *.gz 文件
gunzip 文件.gz		#解压缩文件命令

```
###### 2、zip & unzip
```
#zip用于压缩
#unzip用于解压
#在项目打包发布中很有用

zip [选项] xxx.zip 将要压缩的内容	#压缩文件和目录的命令
unzip [选项] xxx.zip				#解压缩文件

#zip常用选项：-r  递归压缩，即压缩目录
#unzip常用选项：-d <目录>   指定解压后文件的存放目录
```
###### 3、tar
```
#打包指令  最后打包后的文件是.tar.gz的文件

tar [选择] xxx.tar.gz 打包的内容	#打包目录，压缩后的文件格式是.tar.gz

#常用选项
#-c 	产生.tar打包文件
#-v 	显示详细信息
#-f		指定压缩后的文件名
#-z		打包同时压缩
#-x		解包.tar文件

#案例
#1、压缩多个文件，将/home/a1.txt和/home/a2.txt压缩成a.tar.gz
tar -zcvf /home/a.tar.gz /home/a1.txt /home/a2.txt
#2、将/home的文件夹压缩成myhome.tar.gz
tar -zcvf myhome.tar.gz /home/
#3、将a.tar.gz解压到当前目录下
tar -zxvf a.tar.gz
#4、将myhome.tar.gz解压到/opt目录下(指定的目录必须是存在的)
tar -zxvf myhome.tar.gz -C /opt/
```
### 大作业完成步骤  
1.使用git管理大作业相关的代码、配置文件等，要求有能反映大作业过程的git提交记录。
```
sudo yum -y install git#下载git
ssh-keygen -t rsa -C "邮箱"#生成ssh key
git init#初始化
git add 文件名#将我们需要提交的代码从工作区添加到暂存区
git commit -m "提交"#将暂存区里的改动给提交到本地的版本库
git push origin master#将本地版本库的分支推送到远程服务器对应的分支上
```
提交结果:  
![img](/images/12.png )
2.用socket 技术编写程序使用容器技术Docker，将socket客户端和服务端分别运行在不同的容器中
，实现socket客户端和服务端之间的信息传递。  
a)	在虚拟机下载安装好Docker后，我拉取了java镜像，查看ubuntu的所有镜像  
b)	基于java镜像我创建了容器s1和s2：
![img](/images/1创建容器.png )
c)	查看到容器s1的IP地址为172.17.0.2  
d)	之后创建.java文件，分别为SocketServer.java和SocketClient.java文件：  
```
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.ServerSocket;
import java.net.Socket;
 
public class SocketService {    //搭建服务器端
    public static void main(String[] args) throws IOException{
        SocketService socketService = new SocketService();
        //1、a)创建一个服务器端Socket，即SocketService
        socketService.oneServer();
    }
    public  void oneServer(){
        try{
            ServerSocket server=null;
            try{
                //下面是端口，端口可以和客户端代码里面的端口一样
                server=new ServerSocket(5209);
                //b)指定绑定的端口，并监听此端口。
                System.out.println("Service enable Success");
                //创建一个ServerSocket在端口5209监听客户请求
            }catch(Exception e) {
                System.out.println("No Listen："+e);
                //出错，打印出错信息
            }
            Socket socket=null;
            try{
                socket=server.accept();
                //2、调用accept()方法开始监听，等待客户端的连接
                //使用accept()阻塞等待客户请求，有客户
                //请求到来则产生一个Socket对象，并继续执行
            }catch(Exception e) {
                System.out.println("Error."+e);
                //出错，打印出错信息
            }
            //3、获取输入流，并读取客户端信息
            String line;
            BufferedReader in=new BufferedReader(new InputStreamReader(socket.getInputStream()));
            //由Socket对象得到输入流，并构造相应的BufferedReader对象
            PrintWriter writer=new PrintWriter(socket.getOutputStream());
            //由Socket对象得到输出流，并构造PrintWriter对象
            BufferedReader br=new BufferedReader(new InputStreamReader(System.in));
            //由系统标准输入设备构造BufferedReader对象
            System.out.println("Client:"+in.readLine());
            //在标准输出上打印从客户端读入的字符串
            line=br.readLine();
            //从标准输入读入一字符串
            //4、获取输出流，响应客户端的请求
            while(!line.equals("end")){
                //如果该字符串为 "bye"，则停止循环
                writer.println(line);
                //向客户端输出该字符串
                writer.flush();
                //刷新输出流，使Client马上收到该字符串
                System.out.println("Service:"+line);
                //在系统标准输出上打印读入的字符串
                System.out.println("Client:"+in.readLine());
                //从Client读入一字符串，并打印到标准输出上
                line=br.readLine();
                //从系统标准输入读入一字符串
            } //继续循环
 
            //5、关闭资源
            writer.close(); //关闭Socket输出流
            in.close(); //关闭Socket输入流
            socket.close(); //关闭Socket
            server.close(); //关闭ServerSocket
        }catch(Exception e) {//出错，打印出错信息
            System.out.println("Error."+e);
        }
    }
}
```
```
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.InetAddress;
import java.net.Socket;
import java.net.URL;
 
public class SocketClient {
 
    // 搭建客户端
    public static void main(String[] args) throws IOException {
        try {
            // 1、创建客户端Socket，指定服务器地址和端口
 
            //下面是你要传输到另一台电脑的IP地址和端口
            Socket socket = new Socket("172.17.0.2", 5209);
            System.out.println("Client enable Success");
            // 2、获取输出流，向服务器端发送信息
            // 向本机的52000端口发出客户请求
            BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
            // 由系统标准输入设备构造BufferedReader对象
            PrintWriter write = new PrintWriter(socket.getOutputStream());
            // 由Socket对象得到输出流，并构造PrintWriter对象
            //3、获取输入流，并读取服务器端的响应信息
            BufferedReader in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            // 由Socket对象得到输入流，并构造相应的BufferedReader对象
            String readline;
            readline = br.readLine(); // 从系统标准输入读入一字符串
            while (!readline.equals("end")) {
                // 若从标准输入读入的字符串为 "end"则停止循环
                write.println(readline);
                // 将从系统标准输入读入的字符串输出到Server
                write.flush();
                // 刷新输出流，使Server马上收到该字符串
                System.out.println("Client:" + readline);
                // 在系统标准输出上打印读入的字符串
                System.out.println("Service:" + in.readLine());
                // 从Server读入一字符串，并打印到标准输出上
                readline = br.readLine(); // 从系统标准输入读入一字符串
            } // 继续循环
            //4、关闭资源
            write.close(); // 关闭Socket输出流
            in.close(); // 关闭Socket输入流
            socket.close(); // 关闭Socket
        } catch (Exception e) {
            System.out.println("can not listen to:" + e);// 出错，打印出错信息
        }
    }
 
}
```
e)	把相应的文件分别复制到相应的容器里  
f)	分别进入容器，编译运行.java文件，连接成功后传输信息，成功实现了socket客户端和服务端之间的信息传递：  
![img](/images/2.1通信.png )
![img](/images/2通信.png )  
3.Hugo  
a)	下载安装并查看hugo版本    
b)	使用 Hugo 建立站点  
c)	下载主题  
![img](/images/3下载主题.png )  
d)	然后打开confit.toml文件，将主题加入，还有将baseURL修改为自己linux机的ip  
e)	创建名为myfirstblog的markdown文件，在markdown文件中写入内容，最后生成静态页面  
f)	展示博客包含的内容：Linux课程中的学习笔记、大作业完成步骤记录，可以访问我的网址来查看：https://jiangyyi.github.io/linuxassitment.io  
g)	安装nginx  
h)	查看nginx版本  
i)	测试下载nginx成功  
j)	配置nginx.conf, 修改nginx配置文件的用户为root，在http{}的模块内添加service配置，开启端口号为1314  
k)	将上面的内容配置到nginx.conf后，开放1314端口给博客使用,保存后重新加载nginx服务  
l)	本地访问，http://localhost:1314/,成功访问  
![img](/images/4nginx.png )
m)	浏览我的博客文章Myfirstblog  
![img](/images/5浏览.png )  
4、	部署上述静态网站，使其可以公网访问，我使用的是github pages，前面的步骤是使用ssh连接github,注意github需要创建个人访问令牌！
那么接下来：在github创建一个项目Linuxassitment  
a)	将本地博客生成静态文件并上传到github新建的项目下，执行hugo命令生成public文件  
![img](/images/6hugo.png )  
b)	把写好的mysite静态项目public文件推送到新建的项目中  
c)	查看项目在github pages下的网址  
![img](/images/7网址.png )
d)	浏览网址，成功部署静态网站：https://jiangyyi.github.io/linuxassitment.io  

