FROM node:20-alpine as build

WORKDIR /app
COPY package*.json ./
RUN npm install --force
COPY . .
#RUN npm run build
EXPOSE 5173
CMD ["npm", "run", "dev"]

