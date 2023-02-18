# syntax=docker/dockerfile:1
FROM node:current as build-front
WORKDIR /app
ENV NODE_ENV=production
COPY ./package.json /app
COPY ./package-lock.json /app

RUN npm ci
COPY ./ /app
RUN npm run build
# FROM node:current as deploy
# WORKDIR /app
# COPY --from=build-front /app/package.json /app/build ./
FROM python:latest as build-back
WORKDIR /app
COPY --from=build-front /app/build ./
COPY requirements.txt ./
RUN pip install -r requirements.txt
COPY . .
EXPOSE 5000:5000
CMD ["python", "backend/main.py"]
