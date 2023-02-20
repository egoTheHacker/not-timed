# syntax=docker/dockerfile:1
FROM node:current as build-front
WORKDIR /app/frontend
COPY frontend/package.json ./
COPY frontend/yarn.lock ./
RUN yarn install
ENV NODE_ENV=production

COPY ./frontend/ ./
RUN yarn run build


FROM python:latest as build-back
WORKDIR /app
ENV PYTHONPATH "${PYTHONPATH}:/app"

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY ./backend ./backend
COPY --from=build-front /app/frontend/build ./frontend/build
CMD python backend/main.py

EXPOSE 5000

