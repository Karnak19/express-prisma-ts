cd /usr/src/app
npx prisma migrate up --experimental
npx prisma generate
npm run build
