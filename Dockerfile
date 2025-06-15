FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

RUN npm run build -- --configuration production

FROM nginx:stable-alpine

COPY --from=builder /app/dist/personal-site/browser /usr/share/nginx/html

COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80