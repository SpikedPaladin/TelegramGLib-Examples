project_deps = [
    dependency('telegram-glib-0.3')
]

project_sources = [
    'main.vala',
]

executable('inline-bot',
    project_sources,
    vala_args: '--target-glib=2.58',
    dependencies: project_deps,
    install: true,
)
