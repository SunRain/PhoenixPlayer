import QtQuick 2.0

QtObject {
    id: object
    default property alias data: object.__childrenFix
    property list<QtObject> __childrenFix: [QtObject {}]
}
