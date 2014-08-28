FROM node:0.10

ADD package.json /code/
WORKDIR /code
RUN npm install
ADD . /code

CMD ["./node_modules/.bin/coffee", "./server.coffee"]
