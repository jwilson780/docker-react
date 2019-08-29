#Build Phase
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

#Run phase
FROM nginx
#from previous step, copy app/build, then dest is the nginx static serve folder
COPY --from=builder /app/build /usr/share/nginx/html
#dont need run since the default command will start it


