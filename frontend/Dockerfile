
FROM node:10

RUN git clone https://github.com/bjones519/Deployment9.git

WORKDIR Deployment9/frontend

COPY package.json .

RUN npm install --save-dev @babel/plugin-proposal-private-property-in-object

RUN npm install

EXPOSE 3000

CMD [ "npm", "start" ]
