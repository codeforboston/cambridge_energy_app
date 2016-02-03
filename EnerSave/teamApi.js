/* @flow */
'use strict';

// This module will expose an asynchronous, promise-based API for interacting
// with the database.  Other parts of the application should assume that the
// module takes care of details like caching and query batching.

// Test data:
var Teams = {
    "discovery_channel": {
        icon: "http://img3.wikia.nocookie.net/__cb20130406223801/simpsons/pt/images/4/46/Martin_Prince.png",
        name: "Team Discovery Channel",
        memberIds: [1, 2, 3]
    },
    "usa": {
        icon: "http://cdn.bleedingcool.net/wp-content/uploads/2014/12/team-america-jpg.jpg",
        name: "Team America",
        memberIds: []
    },
    "3": {
        icon: "http://robohash.org/cantabrigia.png",
        name: "Team Cantabrigia",
        memberIds: []
    }
};

var Users = {
    1: {
        firstName: "Slappy",
        lastName: "White",
        teamId: "discovery_channel",
        icon: "https://robohash.org/Slappy%20White.png",
        measurements: [
            71, 73, 90, 85, 63
        ]
    },
    2: {
        firstName: "Martin",
        lastName: "Prince",
        teamId: "discovery_channel",
        icon: "https://robohash.org/martin-prince.png",
        measurements: [
            66, 75, 79, 77, 71
        ]
    },
    3: {
        firstName: "Nelson",
        lastName: "Muntz",
        teamId: "discovery_channel",
        icon: "https://robohash.org/nelzon-muntz.png",
        measurements: [
            100, 85, 80, 80, 75
        ]
    }
};

export function getUser(id: string) {
    return new Promise(function(resolve, reject) {
        var user = Users[id];

        if (user) {
            resolve(user);
        } else {
            reject("Invalid user id");
        }
    });
}

export function getUsers(ids, fields=null) {
    return new Promise(function(resolve, reject) {
        resolve(ids.map(function(userId) {
            return Users[userId];
        }));
    });
}

export function getTeam(id: string, include_members: Boolean = false) {
    return new Promise(function(resolve, reject) {
        var team = Teams[id];

        if (team) {
            var members = team.memberIds.map((id) => Users[id]);
            resolve(Object.assign({id: id, members: members}, team));
        } else {
            reject("No team exists with that id.");
        }
    });
}


export function getTeamIds(page: number=1) {
    return new Promise(function(resolve, reject) {
        resolve(Object.keys(Teams));
    });
}


export function getTeamPerformance(teamId) {
    return new Promise(function(resolve, reject) {
        
        resolve();
    });
}
