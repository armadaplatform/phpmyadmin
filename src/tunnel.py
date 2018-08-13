import hashlib
import os
import shutil
import sys
from subprocess import Popen

from armada import hermes


def main():
    configs = hermes.get_config('ssh.json')
    if not configs:
        return
    processes = []
    for config in configs:
        key_path = hermes.get_config_file_path(config['key'])
        key_dest_path = '/tmp/{}.key'.format(hashlib.md5(key_path.encode()).hexdigest())
        shutil.copy(key_path, key_dest_path)
        os.chmod(key_dest_path, 0o600)

        autossh = 'autossh'
        command_params = (
            autossh,
            '-M 0',
            '-N',
            '-C',
            '-o', 'ServerAliveInterval=60',
            '-o', 'ServerAliveCountMax=3',
            '-o', 'StrictHostKeyChecking=no',
            '-p {}'.format(config['proxy_port']),
            '-i', '{}'.format(key_dest_path),
            '{}@{}'.format(config['proxy_user'], config['proxy_host']),
            '-L 0.0.0.0:{}:{}:{}'.format(config['local_port'], config['destination_host'], config['destination_port']),
        )
        process = Popen(command_params)
        processes.append(process)
    for process in processes:
        process.wait()
    if processes:
        sys.exit(1)


if __name__ == '__main__':
    main()
