/* @flow */
'use strict';

import React, {
    AppRegistry,
    Component,
    ListView,
    TouchableHighlight,
    Text,
    View
} from "react-native";

import * as TeamApi from "../teamApi.js";
import {styles} from "../styles.js";
import {UserIcon} from "../components/userIcon.js";

export class UserSelection extends Component {
    constructor(props) {
        super(props);

        var source = new ListView.DataSource({
            rowHasChanged: (r1, r2) => r1 !== r2
        });

        this.state = {
            source: source.cloneWithRows([1, 2, 3]),
            selectedId: null
        };
    }

    _selectRow(userId) {
        this.state.selectedId = userId;

        if (this.props.onSelection) {
            this.props.onSelection(userId);
        }
    }

    renderUser(userId, sectionId, rowId, highlighted) {
        var style = highlighted ? styles.highlightedRow :
                    userId === this.state.selectedId ?
                    styles.selectedRow :
                    styles.row;
        return (
            <TouchableHighlight
                key={userId}
                style={{flex: 1}}
                onPress={() => this._selectRow(userId)}>
                <View style={{flex: 1}}>
                    <UserIcon userId={userId} />
                </View>
            </TouchableHighlight>
        );
    }

    render() {
        return (
            <ListView
                dataSource={this.state.source}
                renderRow={(userId) => this.renderTeam(userId)}
                style={styles.listStyle}
            />
        );
    }
}
