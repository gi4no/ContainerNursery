FROM node:17-alpine as builder

WORKDIR /usr/src/app
COPY . .

RUN npm ci

RUN npm run build


FROM node:20-alpine

WORKDIR /usr/src/app
COPY package.json .
COPY --from=builder /usr/src/app/build .

RUN npm install --only=production

EXPOSE 80
CMD ["node", "index.js"]