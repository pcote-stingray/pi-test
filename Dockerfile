# base-image for node on any machine using a template variable,
# see more about dockerfile templates here: http://docs.resin.io/deployment/docker-templates/
# and about resin base images here: http://docs.resin.io/runtime/resin-base-images/
# Note the node:slim image doesn't have node-gyp
FROM resin/rpi-raspbian

# use apt-get if you need to install dependencies,
# for instance if you need ALSA sound utils, just uncomment the lines below.
RUN apt-get update && apt-get install -yq \
    omxplayer rplay-client && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Defines our working directory in container
#WORKDIR /usr/src/app

# This install npm dependencies on the resin.io build server,
# making sure to clean up the artifacts it creates in order to reduce the image size.
#RUN JOBS=MAX npm install --production --unsafe-perm && npm cache clean && rm -rf /tmp/*

# This will copy all files in our root to the working  directory in the container
COPY . ./

# Enable systemd init system in container
#ENV INITSYSTEM on

# server.js will run when container starts up on the device
CMD ["omxplayer", "./files/lemon.ts"]