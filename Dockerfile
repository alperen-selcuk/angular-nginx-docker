# Stage 1: Build
FROM node:18-alpine as build

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

# Stage 2: Run
FROM nginx:alpine

COPY --from=build /app/dist/angular-docker /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
