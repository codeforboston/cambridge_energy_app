/* @flow */
'use strict';

import React, {
    AppRegistry,
    Component,
    ListView,
    StyleSheet,
    TouchableHighlight,
    Text,
    View
} from "react-native";
import RNChart from "react-native-chart";

import * as TeamApi from "../teamApi.js";
import {styles} from "../styles.js";
import * as utils from "../utils.js";
import {TeamIcon} from "../components/teamIcon.js";



const cStyles = StyleSheet.create({
    container: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
        backgroundColor: 'white'
    },
    chart: {
        position: 'absolute', 
        top: 16, 
        left: 4, 
        bottom: 4,
        right: 16
    }
});

const chartData = [
    {
        name: 'BarChart',
        type: 'bar',
        color:'purple',
        widthPercent: 0.6,
        data: [30, 1, 1, 2, 3, 5, 21, 13, 21, 34, 55, 30]
    },
    {
        name: 'LineChart',
        color: 'gray',
        lineWidth: 2,
        highlightIndices: [1, 2],  // The data points at indexes 1 and 2 will be orange
        highlightColor: 'orange',
        showDataPoint: true,
        data: [10, 12, 14, 25, 31, 52, 41, 31, 52, 66, 22, 11]
    }
];

const xLabels = ['0','1','2','3','4','5','6','7','8','9','10','11'];

export class TeamChart extends Component {
    constructor(props) {
        super(props);
        this.state = {};
    }

    componentDidMount() {
        console.log(this.props.teamId);
        TeamApi.getTeam(this.props.teamId)
               .then((team) => {
                   console.log(team);
                   this.setState({team: team});
               },
                     (reason) => this.setState({error: reason}));
    }

    render() {
        return this.renderChart();
        if (this.state.team)
            return this.renderChart();

        if (this.state.error)
            return this.renderError();

        return (
            <Text>Loading...</Text>
        );
    }

    renderChart() {
        var data = [{
            name: "Electric Bill",
            color: "green",
            lineWidth: 2,
            showDataPoint: true,
            data: [50, 60, 70, 30]
        }],
            labels = ["Dec", "Jan", "Feb", "Mar"];

        var chartStyle = {
            width: 250,
            height: 150
        };

        return (
            <View style={cStyles.container}>
            <RNChart
            style={chartStyle}
            chartData={data}
            verticalGridStep={5}
            xLabels={labels}
            />
            </View>
        );
    }
}

AppRegistry.registerComponent("TeamChart", () => TeamChart);
