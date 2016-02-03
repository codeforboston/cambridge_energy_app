/* @flow */
"use strict";

import {
    StyleSheet
} from "react-native";

export var styles = StyleSheet.create({
    iconImage: {
        height: 50,
        width: 50
    },
    userName: {
        padding: 2,
        textAlign: "center"
    },
    userIcon: {
        alignItems: "flex-start",
        flexDirection: "column",
        alignItems: "center"
    },

    teamIcon: {
        flexDirection: "row"
    },

    teamIconImage: {
        height: 50,
        width: 40
    },

    teamIconInfo: {
        padding: 5,
        flexDirection: "column"
    },
    teamIconName: {
        fontWeight: "500"
    },
    teamIconDetail: {
        color: "#aaaaaa"
    },
    container: {
        flex: 1,
        flexDirection: "column",
        justifyContent: "space-around",
        padding: 5,
        paddingTop: 20,
        backgroundColor: '#F5FCFF'
    },
    welcome: {
        fontSize: 20,
        textAlign: 'center',
        margin: 10
    },
    instructions: {
        textAlign: 'center',
        color: '#333333',
        marginBottom: 5
    },
    header: {
        backgroundColor: "lightblue",
        textAlign: "center",
        color: "white",
        padding: 5,
        paddingTop: 10,
        fontSize: 30
    },
    row: {
        flex: 1
    },
    listStyle: {
        flex: 1
    }
});
