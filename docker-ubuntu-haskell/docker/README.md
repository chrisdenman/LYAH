# Haskell on Docker 

## Linux (presuming `ssh` and `docker` packages)

1. These commands assume the peer [`ubunti-haskell`](ubuntu-haskell) directory   
                                      
### 1. Create a Docker image for the Haskell environment 
```shell
docker build \
  --build-arg SSH_PUBLIC_KEY="<YOUR SSH PUBLIC KEY MATERIAL HERE>" \
  --build-arg MY_HOST_USERNAME=$(whoami) \
  -t ubuntu-haskell - < ubuntu-haskell/Dockerfile
```

### 2. Create a personalised solution directory 
```shell
hdir="ubuntu-haskell/learn-you-a-haskell-exercises" && sdir="${hdir}/solutions/$(whoami)" && [[ ! -e "${sdir}" ]] && mkdir -p "${sdir}" && cp "${hdir}"/exercises/*.hs "${sdir}"
```

### 3. Create the Docker container
```shell
docker create \
  -p 2222:22 \
  -h docker-haskell \
  -v ./ubuntu-haskell/learn-you-a-haskell-exercises/solutions:/home/haskell/learn-you-a-haskell-exercises/solutions \
  --name ubuntu-haskell \
  ubuntu-haskell 
```

### 4. Start the container
```shell
 docker container start ubuntu-haskell 
```

### 5. SSH into the container
```shell
ssh -q -o StrictHostKeyChecking=no -p 2222 haskell@127.0.0.1 
```
- The current directory will be set to your solution directory and changes to this directory will persist locally.  
- `ghci` will be invoked automatically upon logging-in.

### 6. Stop the container
```shell
docker container stop ubuntu-haskell
```
