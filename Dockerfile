# syntax=docker/dockerfile:1
FROM node:current as build-front
WORKDIR /app
COPY . .
ENV NODE_ENV=production
RUN yarn install
RUN yarn run build
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
