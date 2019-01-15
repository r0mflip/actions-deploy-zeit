FROM node:10.15.0-alpine as build
WORKDIR /usr/app
ENV NODE_ENV production
COPY . .
RUN npm install --only=production
RUN mv node_modules prod_modules
RUN npm install
RUN npm run build

FROM node:10.15.0-alpine
WORKDIR /usr/app
ENV NODE_ENV production
COPY --from=build /usr/app/prod_modules ./node_modules
COPY --from=build /usr/app/dist ./dist
COPY --from=build /usr/app/package.json ./package.json
EXPOSE 3107
CMD npm start -- -p 3107 -d dist
