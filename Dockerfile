FROM node:alpine

RUN npm install hexo-theme-mengd \
    npm install hexo-generator-search hexo-wordcount \
    git clone https://github.com/Lete114/Hexo-Theme-MengD.git  ./themes/hexo-theme-mengd