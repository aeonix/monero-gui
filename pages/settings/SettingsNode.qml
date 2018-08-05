import QtQuick 2.7
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.0
import "../../components" as MoneroComponents

Rectangle{
    color: "transparent"
    height: 1400
    Layout.fillWidth: true

    /* main layout */
    ColumnLayout {
        id: root
        anchors.margins: (isMobile)? 17 : 20
        anchors.topMargin: 0

        anchors.left: parent.left
        anchors.top: parent.top
        anchors.right: parent.right

        spacing: 0 * scaleRatio
        property int labelWidth: 120
        property int editWidth: 400
        property int lineEditFontSize: 14 * scaleRatio
        property int buttonWidth: 110

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 90
            color: "transparent"

            Rectangle {
                id: localNodeDivider
                Layout.fillWidth: true
                anchors.topMargin: 0 * scaleRatio
                anchors.left: parent.left
                anchors.right: parent.right
                height: 1
                color: MoneroComponents.Style.dividerColor
                opacity: MoneroComponents.Style.dividerOpacity
            }

            Rectangle {
                visible: !persistentSettings.useRemoteNode
                Layout.fillHeight: true
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                color: "white"
                width: 2
            }

            Rectangle {
                width: parent.width
                height: localNodeHeader.height + localNodeArea.contentHeight
                color: "transparent";
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter

                Rectangle {
                    id: localNodeIcon
                    color: "transparent"
                    height: 32
                    width: 32
                    anchors.left: parent.left
                    anchors.leftMargin: 16 * scaleRatio
                    anchors.verticalCenter: parent.verticalCenter

                    Image{
                        height: 27
                        width: 27
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        source: "../../images/settings_local.png"
                    }
                }

                Text {
                    id: localNodeHeader
                    anchors.left: localNodeIcon.right
                    anchors.leftMargin: 14 * scaleRatio
                    anchors.top: parent.top
                    color: "white"
                    font.bold: true
                    font.family: MoneroComponents.Style.fontRegular.name
                    font.pixelSize: 18 * scaleRatio
                    text: qsTr("Local node") + translationManager.emptyString
                }

                TextArea {
                    id: localNodeArea
                    anchors.top: localNodeHeader.bottom
                    anchors.topMargin: 2 * scaleRatio
                    anchors.left: localNodeIcon.right
                    anchors.leftMargin: 14 * scaleRatio
                    color: MoneroComponents.Style.dimmedFontColor
                    font.family: MoneroComponents.Style.fontRegular.name
                    font.pixelSize: 15 * scaleRatio
                    horizontalAlignment: TextInput.AlignLeft
                    selectByMouse: false
                    wrapMode: Text.WordWrap;
                    textMargin: 0
                    leftPadding: 0
                    topPadding: 0
                    text: qsTr("The blockchain is downloaded to your computer. Provides higher security and requires more local storage.") + translationManager.emptyString
                    width: parent.width - (localNodeIcon.width + localNodeIcon.anchors.leftMargin + anchors.leftMargin)

                    // @TODO: Legacy. Remove after Qt 5.8.
                    // https://stackoverflow.com/questions/41990013
                    MouseArea {
                        anchors.fill: parent
                        enabled: false
                    }
                }   
            }

            MouseArea {
                cursorShape: Qt.PointingHandCursor
                anchors.fill: parent
                onClicked: {
                    persistentSettings.useRemoteNode = false;
                    appWindow.disconnectRemoteNode();
                }
            }
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 90
            color: "transparent"

            Rectangle {
                id: remoteNodeDivider
                Layout.fillWidth: true
                anchors.topMargin: 0 * scaleRatio
                anchors.left: parent.left
                anchors.right: parent.right
                height: 1
                color: MoneroComponents.Style.dividerColor
                opacity: MoneroComponents.Style.dividerOpacity
            }

            Rectangle {
                visible: persistentSettings.useRemoteNode
                Layout.fillHeight: true
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                color: "white"
                width: 2
            }

            Rectangle {
                width: parent.width
                height: remoteNodeHeader.height + remoteNodeArea.contentHeight
                color: "transparent";
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter

                Rectangle {
                    id: remoteNodeIcon
                    color: "transparent"
                    height: 32
                    width: 32
                    anchors.left: parent.left
                    anchors.leftMargin: 16 * scaleRatio
                    anchors.verticalCenter: parent.verticalCenter

                    Image{
                        height: 27
                        width: 22
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        source: "../../images/settings_remote.png"
                    }
                }

                Text {
                    id: remoteNodeHeader
                    anchors.left: remoteNodeIcon.right
                    anchors.leftMargin: 14 * scaleRatio
                    anchors.top: parent.top
                    color: "white"
                    font.bold: true
                    font.family: MoneroComponents.Style.fontRegular.name
                    font.pixelSize: 18 * scaleRatio
                    text: qsTr("Remote node") + translationManager.emptyString
                }

                TextArea {
                    id: remoteNodeArea
                    anchors.top: remoteNodeHeader.bottom
                    anchors.topMargin: 2 * scaleRatio
                    anchors.left: remoteNodeIcon.right
                    anchors.leftMargin: 14 * scaleRatio
                    color: MoneroComponents.Style.dimmedFontColor
                    font.family: MoneroComponents.Style.fontRegular.name
                    font.pixelSize: 15 * scaleRatio
                    activeFocusOnPress: false
                    horizontalAlignment: TextInput.AlignLeft
                    selectByMouse: false
                    wrapMode: Text.WordWrap;
                    textMargin: 0
                    leftPadding: 0
                    topPadding: 0
                    text: qsTr("Uses a third-party server to connect to the Aeon network. Less secure, but easier on your computer.") + translationManager.emptyString
                    width: parent.width - (remoteNodeIcon.width + remoteNodeIcon.anchors.leftMargin + anchors.leftMargin)

                    // @TODO: Legacy. Remove after Qt 5.8.
                    // https://stackoverflow.com/questions/41990013
                    MouseArea {
                        anchors.fill: parent
                        enabled: false
                    }
                }

                MouseArea {
                    cursorShape: Qt.PointingHandCursor
                    anchors.fill: parent
                    onClicked: {
                        persistentSettings.useRemoteNode = true;
                        appWindow.connectRemoteNode();
                    }
                }
            }

            Rectangle {
                id: localNodeBottomDivider
                Layout.fillWidth: true
                anchors.topMargin: 0 * scaleRatio
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                height: 1
                color: MoneroComponents.Style.dividerColor
                opacity: MoneroComponents.Style.dividerOpacity
            }
        }

        ColumnLayout {
            id: remoteNodeLayout
            anchors.margins: 0
            spacing: 20 * scaleRatio
            Layout.fillWidth: true
            Layout.topMargin: 20
            visible: !isMobile && persistentSettings.useRemoteNode

            TextArea {
                color: MoneroComponents.Style.dimmedFontColor
                font.family: MoneroComponents.Style.fontRegular.name
                font.pixelSize: 15 * scaleRatio
                horizontalAlignment: TextInput.AlignLeft
                text: qsTr("To find a remote node, type 'Aeon remote node' into your favorite search engine. Please ensure the node is run by a trusted third party. For more details, view this tutorial.") + translationManager.emptyString
                width: parent.width - (remoteNodeIcon.width + remoteNodeIcon.anchors.leftMargin + anchors.leftMargin)
                activeFocusOnPress: false
                selectByMouse: false
                wrapMode: Text.WordWrap
                textMargin: 0
                leftPadding: 0
                topPadding: 0

                // @TODO: Legacy. Remove after Qt 5.8.
                // https://stackoverflow.com/questions/41990013
                MouseArea {
                    anchors.fill: parent
                    enabled: false
                }
            }

            MoneroComponents.RemoteNodeEdit {
                id: remoteNodeEdit
                Layout.minimumWidth: 100 * scaleRatio

                lineEditBackgroundColor: "transparent"
                lineEditFontColor: "white"
                lineEditFontBold: false
                lineEditBorderColor: Qt.rgba(255, 255, 255, 0.35)
                labelFontSize: 14 * scaleRatio
                placeholderFontSize: 15 * scaleRatio

                daemonAddrLabelText: qsTr("Address")
                daemonPortLabelText: qsTr("Port")

                property var rna: persistentSettings.remoteNodeAddress
                daemonAddrText: rna.search(":") != -1 ? rna.split(":")[0].trim() : ""
                daemonPortText: rna.search(":") != -1 ? (rna.split(":")[1].trim() == "") ? "11181" : rna.split(":")[1] : ""
                onEditingFinished: {
                    persistentSettings.remoteNodeAddress = remoteNodeEdit.getAddress();
                    console.log("setting remote node to " + persistentSettings.remoteNodeAddress)
                }
            }

            GridLayout {
                columns: (isMobile) ? 1 : 2
                columnSpacing: 32

                MoneroComponents.LineEdit {
                    id: daemonUsername
                    Layout.fillWidth: true
                    labelText: "Daemon username"
                    text: persistentSettings.daemonUsername
                    placeholderText: qsTr("(optional)") + translationManager.emptyString
                    placeholderFontSize: 15 * scaleRatio
                    labelFontSize: 14 * scaleRatio
                    fontSize: 15 * scaleRatio
                }

                MoneroComponents.LineEdit {
                    id: daemonPassword
                    Layout.fillWidth: true
                    labelText: "Daemon password"
                    text: persistentSettings.daemonPassword
                    placeholderText: qsTr("Password") + translationManager.emptyString
                    echoMode: TextInput.Password
                    placeholderFontSize: 15 * scaleRatio
                    labelFontSize: 14 * scaleRatio
                    fontSize: 15 * scaleRatio
                }
            }

            Rectangle {
                id: rectConnectRemote
                Layout.topMargin: 12 * scaleRatio
                color: MoneroComponents.Style.buttonBackgroundColorDisabled
                width: btnConnectRemote.width + 40
                height: 26
                radius: 2

                Text {
                    id: btnConnectRemote
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: MoneroComponents.Style.defaultFontColor
                    font.family: MoneroComponents.Style.fontRegular.name
                    font.pixelSize: 14 * scaleRatio
                    font.bold: true
                    text: qsTr("Connect") + translationManager.emptyString
                }

                MouseArea {
                    cursorShape: Qt.PointingHandCursor
                    anchors.fill: parent
                    onClicked: {
                        // Update daemon login
                        persistentSettings.remoteNodeAddress = remoteNodeEdit.getAddress();
                        persistentSettings.daemonUsername = daemonUsername.text;
                        persistentSettings.daemonPassword = daemonPassword.text;
                        persistentSettings.useRemoteNode = true
    
                        currentWallet.setDaemonLogin(persistentSettings.daemonUsername, persistentSettings.daemonPassword);
    
                        appWindow.connectRemoteNode()
                    }
                }
            }
        }

        ColumnLayout {
            id: localNodeLayout
            anchors.margins: 0
            spacing: 20 * scaleRatio
            Layout.topMargin: 40
            anchors.left: parent.left
            anchors.right: parent.right
            visible: !isMobile && !persistentSettings.useRemoteNode

            Rectangle {
                color: "transparent"
                Layout.topMargin: 0 * scaleRatio
                Layout.bottomMargin: 8 * scaleRatio
                Layout.preferredHeight: 24 * scaleRatio
                Layout.preferredWidth: parent.width

                Rectangle {
                    id: rectStopNode
                    color: MoneroComponents.Style.buttonBackgroundColorDisabled
                    width: btnStopNode.width + 40
                    height: 24
                    radius: 2

                    Text {
                        id: btnStopNode
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        color: MoneroComponents.Style.defaultFontColor
                        font.family: MoneroComponents.Style.fontRegular.name
                        font.pixelSize: 14 * scaleRatio
                        font.bold: true
                        text: qsTr("Stop local node") + translationManager.emptyString
                    }

                    MouseArea {
                        cursorShape: Qt.PointingHandCursor
                        anchors.fill: parent
                        onClicked: {
                            appWindow.stopDaemon();
                        }
                    }
                }
            }

            RowLayout {
                MoneroComponents.LineEditMulti {
                    id: blockchainFolder
                    Layout.preferredWidth: 200
                    Layout.fillWidth: true
                    fontSize: 15 * scaleRatio
                    labelFontSize: 14 * scaleRatio
                    property string style: "<style type='text/css'>a {cursor:pointer;text-decoration: none; color: #5FBCD3}</style>"
                    labelText: qsTr("Blockchain location") + style + qsTr(" <a href='#'> (change)</a>") + translationManager.emptyString
                    placeholderText: qsTr("(default)") + translationManager.emptyString
                    placeholderFontSize: 15 * scaleRatio
                    text: {
                        if(persistentSettings.blockchainDataDir.length > 0){
                            return persistentSettings.blockchainDataDir;
                        } else { return "" }
                    }
                    addressValidation: false
                    onInputLabelLinkActivated: {
                        //mouse.accepted = false
                        if(persistentSettings.blockchainDataDir !== ""){
                            blockchainFileDialog.folder = "file://" + persistentSettings.blockchainDataDir;
                        }
                        blockchainFileDialog.open();
                        blockchainFolder.focus = true;
                    }
                }
            }

            RowLayout {
                id: daemonFlagsRow

                MoneroComponents.LineEditMulti {
                    id: daemonFlags
                    Layout.preferredWidth:  200
                    Layout.fillWidth: true
                    labelFontSize: 14 * scaleRatio
                    fontSize: 15 * scaleRatio
                    labelText: qsTr("Daemon startup flags") + translationManager.emptyString
                    placeholderText: qsTr("(optional)") + translationManager.emptyString
                    placeholderFontSize: 15 * scaleRatio
                    text: appWindow.persistentSettings.daemonFlags
                    addressValidation: false
                }
            }

            RowLayout {
                visible: !isMobile && !persistentSettings.useRemoteNode

                ColumnLayout {
                    Layout.fillWidth: true

                    MoneroComponents.RemoteNodeEdit {
                        id: bootstrapNodeEdit
                        Layout.minimumWidth: 100 * scaleRatio
                        Layout.bottomMargin: 20 * scaleRatio
    
                        lineEditBackgroundColor: "transparent"
                        lineEditFontColor: "white"
                        lineEditBorderColor: MoneroComponents.Style.inputBorderColorActive
                        placeholderFontSize: 15 * scaleRatio
                        labelFontSize: 14 * scaleRatio
                        lineEditFontBold: false
                        lineEditFontSize: 15 * scaleRatio

                        daemonAddrLabelText: qsTr("Bootstrap Address")
                        daemonPortLabelText: qsTr("Bootstrap Port")
                        daemonAddrText: persistentSettings.bootstrapNodeAddress.split(":")[0].trim()
                        daemonPortText: {
                            var node_split = persistentSettings.bootstrapNodeAddress.split(":");
                            if(node_split.length == 2){
                                (node_split[1].trim() == "") ? "11181" : node_split[1];
                            } else {
                                return ""
                            }
                        }
                        onEditingFinished: {
                            persistentSettings.bootstrapNodeAddress = daemonAddrText ? bootstrapNodeEdit.getAddress() : "";
                            console.log("setting bootstrap node to " + persistentSettings.bootstrapNodeAddress)
                        }
                    }
                }
            }
        } 
    }
}
