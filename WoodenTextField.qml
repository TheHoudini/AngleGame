import QtQuick 2.4
import QtQuick.Layouts 1.1

WoodenTextFieldForm {
    id : form
    Layout.fillHeight: true
    property alias text : form.inputText
    property alias maxLength : form.maxLength
    property alias inputValidator : form.validator



}

