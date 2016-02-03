/* @flow */
'use strict';

import React, {
    AppRegistry,
    Component,
    ListView,
    TouchableHighlight,
    Text,
    StyleSheet,
    View
} from "react-native";

import * as TeamApi from "../teamApi.js";
import {styles} from "../styles.js";

import {UserIcon} from "../components/userIcon.js";
import {TeamChart} from "../components/teamChart.js";

export class TeamPage extends Component {
    constructor(props) {
        super(props);
        this.state = {};
    }

    componentDidMount() {
        var userId = this.props.userId;

        TeamApi.getUser(userId)
               .then((user) => {
                   this.setState({user: user});
                   return TeamApi.getTeam(user.teamId);
               },
                     (reason) => this.setState({error: reason}))
               .then((team) => this.setTeam(team),
                     (reason) => this.setState({error: reason}));
    }

    setTeam(team) {
        var datasource = new ListView.DataSource({
            rowHasChanged: (row1, row2) => row1 !== row2
        });
        this.setState({team: team});
    }

    renderLoading() {
        return (
            <View>
                <Text>Loading...</Text>
            </View>
        );
    }

    render() {
        if (this.state.user && this.state.team) {
            return this.renderPage();
        } else if (this.props.error) {
            return this.renderError(this.props.error);
        } else {
            return this.renderLoading();
        }
    }

    renderError(error) {
        return (
            <View style={styles.error}>
                <Text>Error Encountered:</Text>
                <Text>{error}</Text>
            </View>
        );
    }

    renderMembers() {
        var ids = this.state.team.memberIds.slice(0, 3);

        if (ids.length > 0) {
            var elements = ids.map(function(memberId) {
                return <UserIcon key={memberId} userId={memberId} />;
            });

            // TODO: Link to a full list of the team members
            /* if (ids.length > 3) {
               elements.append(
               
               );
               } */
            return elements;
        } else {
            return <Text>This team has no members!</Text>;
        }
    }

    renderPage() {
        var team = this.state.team;
        return (
            <View style={{flex: 1, flexDirection: "column"}}>
                <Text style={teamStyles.title}>{ team.name }</Text>
                <View style={{flex: 1, flexDirection: "row"}}>
                    {this.renderMembers()}
                </View>
                <TeamChart teamId={team.id} />
            </View>
        );
    }
}

AppRegistry.registerComponent("TeamPage", () => TeamPage);


const teamStyles = StyleSheet.create({
    title: {
        backgroundColor: "lightBlue",
        color: "white",
        fontSize: 20,
        paddingTop: 10,
        paddingBottom: 10,
        textAlign: "center"
    }
});
