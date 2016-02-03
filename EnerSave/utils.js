/* @flow */

"use strict";

export function sum(values) {
    return values.reduce(function(a, b) { return a+b; });
}

export function simpleMean(values) {
    return sum(values)/values.length;
}

function len(a) { return a.length; }

function get(i) {
    return function(a) { return a[i]; };
};

export function mapAcross(fn, arrays) {
    var results = [],
        l = Math.min.apply(this, arrays.map(len)),
        i = -1;

    while ((++i < l)) {
        results.push(fn(arrays.map(get(i))));
    }

    return results;
}
