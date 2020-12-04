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
RUN npm install --production
RUN npx prisma generate
EXPOSE ${PORT}
CMD [ "npm", "start" ]



# FROM node:12 AS builder

# # Create app directory
# WORKDIR /app

# # A wildcard is used to ensure both package.json AND package-lock.json are copied
# COPY package*.json ./
# COPY prisma ./prisma/

# # Install app dependencies
# RUN npm install
# # Generate prisma client, leave out if generating in `postinstall` script
# RUN npx prisma generate

# COPY . .

# RUN npm run build



# FROM node:12

# COPY --from=builder usr/src/app/node_modules/@prisma/client ./node_modules/@prisma/client
# COPY --from=builder usr/src/app/package*.json ./
# COPY --from=builder usr/src/app/build ./build

# EXPOSE 3000
# CMD [ "npm", "start" ]