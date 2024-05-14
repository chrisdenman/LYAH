# Haskell on Docker 

## Linux
                                      
### 1. Insert your SSH public key into the following command and execute it 
```shell
docker build \
  --build-arg SSH_PUBLIC_KEY="<YOUR SSH PUBLIC KEY MATERIAL HERE>" \
  --build-arg MY_HOST_USERNAME=$(whoami) \
  -t ubuntu-haskell - < ubuntu-haskell/Dockerfile
```

### 2. Make a directory for your solutions and copy the exercise into it
```shell
mkdir -p ubuntu-haskell/learn-you-a-haskell-exercises/solutions/$(whoami) && \
  cp ubuntu-haskell/learn-you-a-haskell-exercises/exercises/*.hs ubuntu-haskell/learn-you-a-haskell-exercises/solutions/$(whoami)  
```

### 3. Start the container
```shell
docker run \
  -d -p2222:22 \
  -h docker-haskell \
  -v ./ubuntu-haskell/learn-you-a-haskell-exercises/solutions:/home/haskell/learn-you-a-haskell-exercises/solutions \
  --name ubuntu-haskell \
  ubuntu-haskell 
```

### 4. SSH into the container
```shell
ssh haskell@127.0.0.1 -p 2222 
```

### 5. Start GHC in interactive mode by typing:
```shell
ghci
```

#### Notes
1. Working Docker and SSH installation required.
