# pintos-dev-env-kaist
Dockerizing PintOS developement environment for KAIST CS330 course

## Usage

```sh
sudo docker pull hangpark/pintos-dev-env-kaist
sudo docker run -it -v {your-pintos-dir}:/pintos pintos-dev-env-kaist
```

To avoid permission issues, make `entrypoint.sh` in your pintos directory as below (Thanks to [yhpark](https://github.com/yhpark)):

```sh
#!/bin/bash
useradd -u <UID> <USER>
su <USER> --command /bin/bash
```
where `<UID>` can check from `id -u <USER>` and run the container with
```sh
sudo docker run -it -v {your-pintos-dir}:/pintos pintos-dev-env-kaist /pintos/entrypoint.sh
```
