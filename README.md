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
