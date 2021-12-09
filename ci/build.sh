#!/bin/sh
set -xe

#Login to registry
echo ${{ secrets.REGISTRY_PASSWORD }} | docker login ghcr.io -u ${{ secrets.REGISTRY_USERNAME }} --password-stdin
if [ ${GITHUB_REF_NAME} = "main" ]
then
    echo 'This is main branch'
    cp ./src/robots/robots-aura.txt ./src/robots.txt
    cp ./src/robots/sitemap-aura.xml ./src/sitemap.xml
fi
#Build and push image
docker build -t ${CONTAINER_RELEASE_IMAGE} -f Dockerfile .
docker push ${CONTAINER_RELEASE_IMAGE}
