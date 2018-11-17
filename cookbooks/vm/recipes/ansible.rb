
# install required dependencies
package ['python-pip', 'libssl-dev', 'libffi-dev']

# install ansible
install_pip_package 'ansible', '2.3.0.0'

# install testinfra with the spec formatter, and molecule
install_pip_package 'ansible-lint', '3.5.1'
install_pip_package 'testinfra', '1.17.0'
install_pip_package 'pytest-spec', '1.1.0'
install_pip_package 'molecule', '2.19.0'
install_pip_package 'python-vagrant', '0.5.15'
