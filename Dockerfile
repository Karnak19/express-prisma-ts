FROM node:14.15

WORKDIR /usr/src/app

ARG PORT=${PORT}

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build
RUN npm run migrate
RUN npm run generate

ENV NODE_ENV=production

EXPOSE ${PORT}

CMD [ "npm", "start" ]