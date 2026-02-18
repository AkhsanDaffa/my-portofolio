# Stage 1: Build static site
# FROM klakegg/hugo:ext-alpine AS builder
FROM hugomods/hugo:base AS builder
WORKDIR /src
COPY . .

RUN hugo --minify

# Stage 2: Server with Nginx Alpine
FROM nginx:alpine

RUN rm -rf /usr/share/nginx/html/*

COPY --from=builder /src/public /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]