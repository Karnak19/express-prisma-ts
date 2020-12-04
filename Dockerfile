FROM node:14 as builder
WORKDIR /usr/src/app
COPY . .
RUN npm install
RUN npm run build


FROM node:14.15
WORKDIR /usr/src/app
ARG PORT=${PORT}
ENV PORT=${PORT}
ARG DATABASE_URL=${DATABASE_URL}
ENV DATABASE_URL=${DATABASE_URL}
ENV NODE_ENV=production
COPY --from=builder /usr/src/app/package*.json ./
COPY --from=builder /usr/src/app/build ./build
COPY --from=builder /usr/src/app/prisma ./prisma
RUN npm install -g @prisma/cli
RUN npm install --production
RUN npx prisma generate
EXPOSE ${PORT}
CMD [ "npm", "start" ]

# FROM node:14 as builder
# WORKDIR /usr/src/app
# COPY . .
# RUN npm install
# RUN npm run build


# FROM node:14.15
# WORKDIR /usr/src/app
# ARG PORT=${PORT}
# ENV PORT=${PORT}
# ARG DATABASE_URL=${DATABASE_URL}
# ENV DATABASE_URL=${DATABASE_URL}
# RUN npm install --production
# COPY --from=builder /usr/src/app/build ./build
# ENV NODE_ENV=production
# EXPOSE ${PORT}

# RUN chmod +x /usr/src/app/run.sh

# CMD [ "run.sh" ]