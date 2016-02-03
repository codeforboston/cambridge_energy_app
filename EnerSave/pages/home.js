/* @flow */
"use strict";

import React, {
    AppRegistry,
    Component,
    Text
} from "react-native";

import {UserIcon} from "../components/userIcon.js";


export class HomePage extends Component {
    render() {
        return (
            <UserIcon userId="1" />
        );
    }
}

AppRegistry.registerComponent("HomePage", () => HomePage);
