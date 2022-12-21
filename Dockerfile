#从本地的镜像仓库里拉取ngxin的docker镜像 
FROM nginx 
#修改ngxin的docker镜像的首页内容
RUN echo 'Hello World' > /usr/share/nginx/html/index.html 
