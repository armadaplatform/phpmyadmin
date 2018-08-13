#!/usr/bin/env python3

import sys
from subprocess import check_call, CalledProcessError

from armada.hermes import get_config


def main():
    configs = get_config('ssh.json')
    if not configs:
        return
    exit_code = 0
    for config in configs:
        local_port = config['local_port']
        try:
            check_call(['nc', '-z', '127.0.0.1', str(local_port)])
        except CalledProcessError:
            sys.stderr.write('WARNING: Local port {} for SSH tunnel is not open!\n'.format(local_port))
            exit_code = 1
    sys.exit(exit_code)


if __name__ == '__main__':
    main()
