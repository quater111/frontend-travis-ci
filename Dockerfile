#Build Phase. Bezeichnung der Phase wird durch >> as builder << festgelegt
FROM node:alpine as builder

WORKDIR '/app'

COPY package.json ./
RUN npm install

COPY ./ ./

RUN npm run build

#Run Phase. Ein zweites FROM statement sagt automatisch aus, das vorherige Phase beendet ist
FROM nginx
#Expose macht lokal automatisch garnichts. Webserver erkennt es und gibt port im Container frei!
EXPOSE 80
#Copy something from another phase -> copy folder /app/build = (verzeichnis in Container) to /usr/share/nginx/html = (nginx documentation folder nginx to serve) 
COPY --from=builder /app/build /usr/share/nginx/html