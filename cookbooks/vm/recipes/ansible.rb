
# install required dependencies
package ['python-pip', 'libssl-dev', 'libffi-dev']

# install ansible
install_pip_package 'ansible', '2.7.10'

# install testinfra with the spec formatter, and molecule
install_pip_package 'ansible-lint', '4.1.0'
install_pip_package 'testinfra', '1.19.0'
install_pip_package 'pytest-spec', '1.1.0'
install_pip_package 'molecule', '2.20.1'
install_pip_package 'python-vagrant', '0.5.15'
