TEMPLATE = subdirs

deployment.files += qml-material/modules/Material/qmldir \
                    qml-material/modules/Material/*.qml \
                    qml-material/modules/Material/awesome.js \
                    qml-material/modules/Material/icons \
                    qml-material/modules/Material/fonts \
                    qml-material/modules/Material/ListItems \
                    qml-material/modules/Material/Transitions \
                    qml-extras/modules/Material/Extras

deployment.path = $${OUT_PWD}/Material
export(deployment.path)

INSTALLS += deployment

export(INSTALLS)

OTHER_FILES += $$deployment.files

