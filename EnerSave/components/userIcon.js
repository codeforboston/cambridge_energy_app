/* @flow */
'use strict';

import React, {
    AppRegistry,
    Component,
    Image,
    Text,
    View
} from "react-native";

import * as TeamApi from "../teamApi.js";
import {styles} from "../styles.js";

export class UserIcon extends Component {
    constructor(props) {
        super(props);
        this.state = {};
    }

    componentDidMount() {
        TeamApi.getUser(this.props.userId)
               .then((user) => this.setState({user: user}),
                     (reason) => this.setState({error: reason}));
    }

    render() {
        var user = this.state.user ||
                   {icon: "http://robohash.org/unknown.png",
                    firstName: "Loading",
                    lastName: "..."};
        
        return (
            <View style={styles.userIcon}>
                <Image
                    source={{uri: user.icon}}
                    style={styles.iconImage}
                />
                <Text
                    style={styles.userName}
                >
                    {user.firstName} {user.lastName}
                </Text>
            </View>
        );
    }
}

AppRegistry.registerComponent("UserIcon", () => UserIcon);
