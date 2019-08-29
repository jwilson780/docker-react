#Build Phase
FROM node:alpine as builder
WORKDIR '/app'
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

#Run phase
FROM nginx
#In most envs this is communication to devs to tell us what to do
#This will do nothing locally, but elastic beanstalk will look for this and expose it
EXPOSE 80
#from previous step, copy app/build, then dest is the nginx static serve folder
COPY --from=builder /app/build /usr/share/nginx/html
#dont need run since the default command will start it
