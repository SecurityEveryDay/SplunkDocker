#!/bin/bash

apt install docker.io docker-compose -y
docker-compose up --build -d
