
# install required dependencies
package ['python-pip', 'libssl-dev', 'libffi-dev']

# install ansible
install_pip_package 'ansible', '2.3.0.0'

# install testinfra with the spec formatter, and molecule
install_pip_package 'testinfra', '1.6.2'
install_pip_package 'pytest-spec', '1.1.0'
install_pip_package 'molecule', '2.0.0.0rc5'
