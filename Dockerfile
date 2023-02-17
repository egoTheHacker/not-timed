# syntax=docker/dockerfile:1
FROM node:current as build-front
WORKDIR /app
COPY package.json yarn.lock ./
RUN yarn install
COPY . .
RUN yarn run build
FROM node:current as deploy
WORKDIR /app
COPY --from=build-front /app/package.json /app/build ./
FROM python:latest as build-back
WORKDIR /app
COPY --from=deploy /app/build ./
COPY requirements.txt /app/
RUN pip install -r requirements.txt
COPY . .
CMD ["python", "backend/main.py"]
EXPOSE 5000:5000
