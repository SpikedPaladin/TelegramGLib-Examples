project_deps = [
    dependency('glib-2.0'),
    dependency('gobject-2.0'),
    dependency('telegram-glib-0.2')
]

project_sources = [
    'main.vala',
]

executable('echo-bot',
    project_sources,
    vala_args: '--target-glib=2.58',
    dependencies: project_deps,
    install: true,
)
