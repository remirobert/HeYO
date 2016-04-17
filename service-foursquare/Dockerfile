FROM node:latest

ADD package.json package.json
RUN npm install
ADD . .

EXPOSE 8000:8002

CMD ["node","app.js"]
