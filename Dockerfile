FROM node:14.15

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

RUN npm run migrate


ENV NODE_ENV=production

EXPOSE 5000

CMD [ "npm", "start" ]