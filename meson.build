project('com.github.brandonlujan.exchange', ['vala','c'],
    version: '1.1.0'
)

gnome = import('gnome')
i18n = import('i18n')

conf = configuration_data()
conf.set_quoted('GETTEXT_PACKAGE', meson.project_name())
configure_file(output: 'config.h', configuration: conf)
config_h_dir = include_directories('.')

c_args = [
    '-include', 'config.h',
]

executable(
    'com.github.brandonlujan.exchange',
    'src/application.vala',
    c_args: c_args,
    dependencies: [
        dependency('granite'),
        dependency('glib-2.0'),
        dependency('gobject-2.0'),
        dependency('gtk+-3.0'),
        dependency('libsoup-2.4'),
        dependency('json-glib-1.0'),
        dependency('gio-2.0')
    ],
    install : true
)

meson.add_install_script('meson/post_install.py')

subdir('data')
subdir('po')
