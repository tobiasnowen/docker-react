FROM node:18-alpine as buildPhase
WORKDIR app
RUN chown -R node:node /app
USER node
COPY --chown=node:node package*.json .
RUN npm install
COPY --chown=node:node . .
RUN npm run build

FROM nginx:1.26.0 as runPhase
COPY --from=buildPhase /app/build /usr/share/nginx/html
