project('kobla-base', 'cpp', default_options: ['cpp_std=c++14', 'warning_level=3'])

# Add ncnet as a dependency that meson can find
ncnet_dep = declare_dependency(link_args : '-lncnet')

subdir('server')
subdir('client')
