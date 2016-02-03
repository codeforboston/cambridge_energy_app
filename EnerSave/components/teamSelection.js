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
import {TeamIcon} from "../components/teamIcon.js";

export class TeamSelection extends Component {
    constructor(props) {
        super(props);

        var source = new ListView.DataSource({
            rowHasChanged: (r1, r2) => r1 !== r2
        });

        this.state = {
            source: source,
            selectedId: null
        };
    }

    componentDidMount() {
        var source = this.state.source;

        if (this.props.teamIds) {
            this.setState({
                source: source.cloneWithRows(this.props.teamIds)
            });
        } else {
            TeamApi.getTeamIds()
                   .then((ids) => this.setState({
                       source: source.cloneWithRows(ids)
                   }),
                         (reason) => this.setState({error: reason}));
        }
    }

    _selectRow(teamId) {
        this.state.selectedId = teamId;

        if (this.props.onSelection) {
            this.props.onSelection(teamId);
        }
    }

    renderTeam(teamId: string, sectionId, rowId, highlighted: bool): TouchableHighlight {
        return (
            <TouchableHighlight
                key={teamId}
                style={styles.row}
                underlayColor="blue"
                onPress={() => this._selectRow(teamId)}>
                <View style={{flex: 1}}>
                    <TeamIcon teamId={teamId} />
                </View>
            </TouchableHighlight>
        );
    }

    render() {
        return (
            <ListView
                dataSource={this.state.source}
                renderRow={(teamId) => this.renderTeam(teamId)}
                style={styles.listStyle}
            />
        );
    }
}
