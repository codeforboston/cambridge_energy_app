/* @flow */
"use strict";

import React, {
    AppRegistry,
    Component,
    Image,
    Text,
    View
} from "react-native";

import * as TeamApi from "../teamApi.js";
import {styles} from "../styles.js";

export class TeamIcon extends Component {
    constructor(props) {
        super(props);
        this.state = {};
    }

    setTeamId(teamId: string) {
        TeamApi.getTeam(teamId)
               .then((team) => this.setState({team: team}),
                     (reason) => this.setState({error: reason}));
    }

    componentDidMount() {
        this.setTeamId(this.props.teamId);
    }

    componentWillReceiveProps(props) {
        this.setState({team: null});
        this.setTeamId(props.teamId);
    }

    render() {
        var team = this.state.team ||
                   {icon: "http://robohash.org/unknown.png",
                    name: "Loading...",
                    memberIds: []};
        console.log(team.icon);
        return (
            <View style={styles.teamIcon}>
            <Image
                source={{uri: team.icon}}
                style={styles.teamIconImage}
            />
            <View style={styles.teamIconInfo}>
                <Text style={styles.teamIconName}>{team.name}</Text>
                <Text style={styles.teamIconDetail}>{team.memberIds.length} members</Text>
            </View>
            </View>
        );
    }
}

AppRegistry.registerComponent("TeamIcon", () => TeamIcon);
