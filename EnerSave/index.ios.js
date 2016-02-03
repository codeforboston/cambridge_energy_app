/* @flow */
'use strict';
import React, {
    AppRegistry,
    Component,
    Navigator,
    StyleSheet,
    TabBarIOS,
    Text,
    TextInput,
    View
} from 'react-native';

import {TeamPage} from "./pages/team.js";
import {TeamSelection} from "./components/teamSelection.js";
import {HomePage} from "./pages/home.js";
import {SignupForm} from "./pages/signup.js";

import * as TeamApi from "./teamApi.js";
import {styles} from "./styles.js";

var CURRENT_USER = {
    firstName: "Slappy",
    lastName: "White",
    setupStatus: 1,
    id: 1
};


class Dashboard extends Component {
    constructor(props) {
        var base64Icon = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEsAAABLCAQAAACSR7JhAAADtUlEQVR4Ac3YA2Bj6QLH0XPT1Fzbtm29tW3btm3bfLZtv7e2ObZnms7d8Uw098tuetPzrxv8wiISrtVudrG2JXQZ4VOv+qUfmqCGGl1mqLhoA52oZlb0mrjsnhKpgeUNEs91Z0pd1kvihA3ULGVHiQO2narKSHKkEMulm9VgUyE60s1aWoMQUbpZOWE+kaqs4eLEjdIlZTcFZB0ndc1+lhB1lZrIuk5P2aib1NBpZaL+JaOGIt0ls47SKzLC7CqrlGF6RZ09HGoNy1lYl2aRSWL5GuzqWU1KafRdoRp0iOQEiDzgZPnG6DbldcomadViflnl/cL93tOoVbsOLVM2jylvdWjXolWX1hmfZbGR/wjypDjFLSZIRov09BgYmtUqPQPlQrPapecLgTIy0jMgPKtTeob2zWtrGH3xvjUkPCtNg/tm1rjwrMa+mdUkPd3hWbH0jArPGiU9ufCsNNWFZ40wpwn+62/66R2RUtoso1OB34tnLOcy7YB1fUdc9e0q3yru8PGM773vXsuZ5YIZX+5xmHwHGVvlrGPN6ZSiP1smOsMMde40wKv2VmwPPVXNut4sVpUreZiLBHi0qln/VQeI/LTMYXpsJtFiclUN+5HVZazim+Ky+7sAvxWnvjXrJFneVtLWLyPJu9K3cXLWeOlbMTlrIelbMDlrLenrjEQOtIF+fuI9xRp9ZBFp6+b6WT8RrxEpdK64BuvHgDk+vUy+b5hYk6zfyfs051gRoNO1usU12WWRWL73/MMEy9pMi9qIrR4ZpV16Rrvduxazmy1FSvuFXRkqTnE7m2kdb5U8xGjLw/spRr1uTov4uOgQE+0N/DvFrG/Jt7i/FzwxbA9kDanhf2w+t4V97G8lrT7wc08aA2QNUkuTfW/KimT01wdlfK4yEw030VfT0RtZbzjeMprNq8m8tnSTASrTLti64oBNdpmMQm0eEwvfPwRbUBywG5TzjPCsdwk3IeAXjQblLCoXnDVeoAz6SfJNk5TTzytCNZk/POtTSV40NwOFWzw86wNJRpubpXsn60NJFlHeqlYRbslqZm2jnEZ3qcSKgm0kTli3zZVS7y/iivZTweYXJ26Y+RTbV1zh3hYkgyFGSTKPfRVbRqWWVReaxYeSLarYv1Qqsmh1s95S7G+eEWK0f3jYKTbV6bOwepjfhtafsvUsqrQvrGC8YhmnO9cSCk3yuY984F1vesdHYhWJ5FvASlacshUsajFt2mUM9pqzvKGcyNJW0arTKN1GGGzQlH0tXwLDgQTurS8eIQAAAABJRU5ErkJggg==';

        super(props);
        this.state = {
            loaded: false,
            selectedTab: "team"
        };

        this.tabIds = ["home", "team", "apt", "community"];
        this.tabs = {
            "home": {
                title: "Home",
                icon: base64Icon,
                componentClass: HomePage
            },
            "team": {
                title: "Team",
                icon: base64Icon,
                componentClass: TeamPage
            },
            "apt": {
                title: "Apartment",
                icon: base64Icon
            },
            "community": {
                title: "Community",
                icon: base64Icon
            },
            "rewards": {
                title: "Rewards",
                icon: base64Icon
            }
        };
    }

    componentDidMount() {
        if (!this.state.loaded && this.props.userId) {
            TeamApi.getUser(this.props.userId)
                   .then((user) => this.setState({user: user}),
                         (reason) => this.setState({error: reason}));
        }
    }

    render() {
        return (
            <Navigator
                initialRoute={{name: "Home", index: 0}}
                renderScene={(r, n) => this.renderScene(r, n)}/>
        );
    }

    renderScene(route, navigator) {
        var user = this.props.user,
            tab = this.tabs[this.state.selectedTab];

        return (
            <TabBarIOS
                name={route.name}
                tintColor="white"
                barTintColor="darkslateblue">
                {this.tabIds.map(function(tabId) {
                     var tab = this.tabs[tabId];
                     return (<TabBarIOS.Item
                        key={tabId}
                        title={tab.title}
                        icon={{uri: tab.icon, scale: 3}}
                        selected={this.state.selectedTab === tabId}
                        onPress={() => {
                                this.setState({
                                    selectedTab: tabId
                                });
                            }}>
                <View style={styles.container}>
                    {this.renderContent(this.state.selectedTab)}
                </View>
                     </TabBarIOS.Item>
                     );
                 }, this)}
            </TabBarIOS>
        );

    }

    renderContent(tabId: string) {
        var user = this.props.user,
            ComponentClass = this.tabs[tabId].componentClass;

        if (ComponentClass) {
            return React.createElement(ComponentClass,
                                       {userId: user.id,
                                        style: {flex: 1}});
        }

        return (
            <View style={styles.container}>
                <Text style={styles.welcome}>
                    Welcome back, {user.firstName}!
                    Showing: {tabId}
                </Text>
            </View>
        );
    }
}

class EnerSave extends Component {
    constructor(props) {
        super(props);
        this.state = {
            user: CURRENT_USER
        };
    }

  render() {
      var user = this.state.user;

      if (!user.setupStatus) {
          return this.renderSetup();
      } else {
          return this.renderDashboard();
      }
  }

    renderSetup() {
        return (
            <SignupForm></SignupForm>
        );
    }

    renderDashboard() {
        return (
            <Dashboard user={this.state.user}> </Dashboard>
        );
    }
  }

AppRegistry.registerComponent('EnerSave', () => EnerSave);
