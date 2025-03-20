# 使用 Node.js 作為基礎鏡像
FROM node:18-alpine

# 設置工作目錄
WORKDIR /app

# 安裝 git 和基本工具（用於主題安裝和部分外掛）
RUN apk add --no-cache git openssh-client bash

# 全局安裝 Hexo CLI
RUN npm install -g hexo-cli

# 複製 package.json 和 package-lock.json（如果有）
COPY package*.json ./

# 安裝依賴
RUN npm install

# 複製博客源碼
COPY . .

# 為外部訪問暴露端口
EXPOSE 4000

# 設置容器啟動時的命令：生成並啟動服務器
CMD ["sh", "-c", "hexo clean && hexo generate && hexo server -s -p 4000 --ip=0.0.0.0"]