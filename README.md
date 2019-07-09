# Docker on rails

These are the commands I used while setting these up with Docker only. 

**Explore with rails alone**

- mkdir new_dr && cd $_
- touch {Dockerfile,Gemfile,Gemfile.lock}
- docker image build -t new_dr .
- docker image inspect new_dr
- docker image build -t new_dr:1.0 .
- docker image rm new_dr:1.0
- docker image tag new_dr muhairwe/new_dr:latest
- docker image push muhairwe/new_dr:latest
- docker container exec -it new_dr sh
- docker container run --rm -it --name new_dr -v ${PWD}:/app new_dr rails new . -T --database=postgresql -f
- docker container run -it -p 3000:3000 --rm -v ${PWD}:/app --name new_dr new_dr


**Explore with postgres**

- docker pull postgres:9.6-alpine
- docker container run -itd --rm --name postgres postgres:9.6-alpine

**Create network**

- docker network create --driver bridge mynetwork
- docker container run -itd -p 3000:3000 --rm -v ${PWD}:/app --name new_dr --net mynetwork new_dr
- docker container run -itd --rm --name postgres --net mynetwork postgres:9.6-alpine
- docker network inspect mynetwork

**Connecting them and running the app**

- docker container run -itd --rm --name postgres --net mynetwork -p 5432:5432 -v ${PWD}/tmp/db:/var/lib/postgres/data postgres:9.6-alpine
- docker container stop new_dr
- docker container run -itd -p 3000:3000 --rm -v ${PWD}:/app --name new_dr --net mynetwork new_dr
- docker exec new_dr rails db:create
- docker exec new_dr rails g controller pages index
- docker exec new_dr rspec

**Pointers..**
- use *docker container run ...* when the container is not running and you would like to execute a command in it.
- use *docker container exec ...* when you are running a command in an already running docker container.
- always rebuild the image when you change the Gemfile or the Dockerfile
