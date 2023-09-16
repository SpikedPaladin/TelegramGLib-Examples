project_deps = [
    dependency('telegram-glib-1.0')
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
