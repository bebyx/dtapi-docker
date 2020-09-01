# Script to Deploy Docker Containers

Create custom docker network:

`docker network create --subnet=172.18.0.0/16 dt_net` 

Run `run.sh` with Jenkins user name as the first argument (e.g. `./run.sh admin`).

Enter Jenkins password for the prompt.

Wait.

Open http://localhost.

That's it.
