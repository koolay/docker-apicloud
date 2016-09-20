APICloud
--------

## RUN

```
docker run --name apicloud -p 1337:1337 \
    -e NODE_ENV=prod \
    -v /home/app/webapp/node_modules \
    -v <project_root>:/home/app/webapp daocloud.io/koolay/apicloud:latest
```

## ENV

- `NODE_ENV` : development, prod

