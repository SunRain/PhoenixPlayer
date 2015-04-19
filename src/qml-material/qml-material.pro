TEMPLATE = subdirs

#OTHER_FILES += \
#        qml-material/modules/Material/qmldir \
#        qml-material/modules/Material/*.qml \
#        qml-material/modules/Material/awesome.js \
#        qml-material/modules/Material/icons \
#        qml-material/modules/Material/fonts \
#        qml-material/modules/Material/ListItems \
#        qml-material/modules/Material/Transitions \
#        qml-material/styles/material/qmldir \
#        qml-material/styles/material/*.qml \
#        qml-extras/modules/Material/Extras


# Default rules for deployment.
include(../../deployment.pri)

material.files = \
        qml-material/modules/Material/qmldir \
        qml-material/modules/Material/*.qml \
        qml-material/modules/Material/awesome.js \
        qml-material/modules/Material/icons \
        qml-material/modules/Material/fonts \
        qml-material/modules/Material/ListItems \
        qml-material/modules/Material/Transitions \
        qml-extras/modules/Material/Extras
material.path = $${OUT_PWD}/../../PhoenixPlayer/Material
OTHER_FILES += $${material.files}
INSTALLS += material


styles.files = \
        qml-material/styles/material/qmldir \
        qml-material/styles/material/*.qml

styles.path = $${OUT_PWD}/../../PhoenixPlayer/Material/Styles
OTHER_FILES += $${styles.files}
INSTALLS += styles
