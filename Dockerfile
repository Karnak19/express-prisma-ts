FROM node:12 as builder
WORKDIR /usr/src/app
ARG PORT=${PORT}
ENV PORT=${PORT}
ARG DATABASE_URL=${DATABASE_URL}
ENV DATABASE_URL=${DATABASE_URL}
COPY . /usr/src/app
RUN npm install
RUN npm run build
RUN npm run migrate
RUN npm run generate


FROM node:14.15
WORKDIR /usr/src/app
ARG PORT=${PORT}
ENV PORT=${PORT}
ARG DATABASE_URL=${DATABASE_URL}
ENV DATABASE_URL=${DATABASE_URL}
RUN npm install --production
COPY --from=builder /usr/src/app/build .
ENV NODE_ENV=production
EXPOSE ${PORT}
CMD [ "npm", "start" ]