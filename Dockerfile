FROM node:12 as build

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install --production

COPY . ./
RUN npm run build

FROM nginx:1.17-alpine
COPY --from=build /usr/src/app/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/

EXPOSE 80
CMD ["nginx","-g","daemon off;"]