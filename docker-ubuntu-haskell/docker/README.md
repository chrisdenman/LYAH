# Haskell on Docker 

## Linux

### 1. Edit the [Dockerfile](ubuntu-haskell/Dockerfile)
Insert your SSH public-key where indicated.
         
### 2. Build Image
```shell
docker build -q -t ubuntu-haskell - < ubuntu-haskell/Dockerfile
```

### 3. Run Container
```shell
docker run -p2222:22 -v ./ubuntu-haskell/volume:/home/haskell/host_volume -d --name ubuntu-haskell ubuntu-haskell 
```

### 3. SSH Into Container
```shell
ssh haskell@127.0.0.1 -p 2222 
```

### 4. Start GHC in interactive mode by typing:
```shell
ghci
```

#### Notes
1. Working Docker and SSH installation required.
2. Anything saved into the guest's `~/host_volume` directory will be persisted on the host machine [here](ubuntu-haskell/volume).
