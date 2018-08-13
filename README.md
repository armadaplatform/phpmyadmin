# phpmyadmin

`phpmyadmin` service contains standalone [phpMyAdmin](http://www.phpmyadmin.net) interface that can be easily
configured to access any MySQL server.


# Building and running the service.

    armada build phpmyadmin
    armada run phpmyadmin

# Configuring list of servers

To configure custom list of MySQL servers, you can copy modified [config/servers.php](config/servers.php) file to
separate repository with configs.

If you use `phpmyadmin-config` repository and configure `courier` to deploy it on host with `phpmyadmin`, it will be
automatically detected.

But you can also place the `servers.php` file anywhere on host, and add flag `--configs [path_to_dir_with_servers.php]` to
`armada run`.

# Databases behind SSH tunnels

Additionally, if your MySQL servers can be accessed only via SSH, you can create `ssh.json` file with SSH tunnel
definitions and put it in the same place as `servers.php` (described above).

The format of the `ssh.json` file is following:
```
[
    {
        "destination_host": "master.db.example.com",
        "destination_port": 3306,
        "local_port": 13306,
        "proxy_host": "ssh-proxy.example.com",
        "proxy_user": "tunnel",
        "proxy_port": 2200,
        "key": "tunnel@ssh-proxy.example.com.key"
    },
    ...
]

```
The file `tunnel@ssh-proxy.example.com.key` with private key for creating SSH tunnel should also be put in the same
place as files `servers.php` and `ssh.json`.

Now, in `servers.php` you may use `localhost:13306` address to point to the above database. 
