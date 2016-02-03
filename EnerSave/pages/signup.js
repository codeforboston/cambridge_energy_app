/* @flow */
'use strict';
import React, {
    AppRegistry,
    Component,
    Text,
    TextInput,
    View
} from 'react-native';

class SignupForm extends Component {
    constructor(props) {
        super(props);
        this.state = {
            text: "Hello, world!"
        };
    }

    render() {
        return (
                <View style={styles.container}>
                <Text>
                Sign up
            </Text>
                <TextInput
            style={{height: 40, borderColor: "gray", borderWidth: 1}}
            placeholder="Email Address"
            value=""
                />
                <TextInput
            style={{height: 40, borderColor: "gray", borderWidth: 1}}
            placeholder="Something" />

                </View>
        );
    }
}

AppRegistry.registerComponent("SignupForm", () => SignupForm);
