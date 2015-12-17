// Ionic Starter App

// angular.module is a global place for creating, registering and retrieving Angular modules
// 'starter' is the name of this angular module example (also set in a <body> attribute in index.html)
// the 2nd parameter is an array of 'requires'
angular.module('cambergy', ['ionic'])

    .run(function($ionicPlatform) {
        $ionicPlatform.ready(function() {
            if(window.cordova && window.cordova.plugins.Keyboard) {
                // Hide the accessory bar by default (remove this to show the accessory bar above the keyboard
                // for form inputs)
                cordova.plugins.Keyboard.hideKeyboardAccessoryBar(true);

                // Don't remove this line unless you know what you are doing. It stops the viewport
                // from snapping when text inputs are focused. Ionic handles this internally for
                // a much nicer keyboard experience.
                cordova.plugins.Keyboard.disableScroll(true);
            }
            if(window.StatusBar) {
                StatusBar.styleDefault();
            }
        });
    })

    .config(function($stateProvider, $urlRouterProvider) {
        $stateProvider
            .state('signup', {
                url: "/signup",
                abstract: true,
                controller: "SetupCtrl",
                controllerAs: "setupCtrl",
                templateUrl: 'templates/main.html'
            })

            .state('signup.steps', {
                url: '/:step',
                views: {
                    content: {
                        templateProvider: function($stateParams, $http, $templateCache, $q) {
                            var url = "templates/setup" + $stateParams.step + ".html",
                                resp = $http.get(url, {cache: $templateCache});

                            return $q(function(resolve, reject) {
                                resp.then(function(response) {
                                    resolve(response.data);
                                });
                            });
                        }
                    }
                }
            })

            .state("dashboard", {
                controller: 'DashboardCtrl',
                url: "/dashboard",
                templateUrl: "templates/dashboard.html"
            })
            .state("dashboard.profile", {
                url: "/me",
                views: {
                    profile: {
                        templateUrl: "templates/profile.html"
                    }
                }
            })
            .state("dashboard.apartment", {
                url: "/apartment",
                views: {
                    apartment: {
                        templateUrl: "templates/apartment.html"
                    }
                }
            })
            .state("dashboard.team", {
                url: "/team",
                views: {
                    team: {
                        templateUrl: "templates/team.html"
                    }
                }
            })
            .state("dashboard.community", {
                url: "/community",
                views: {
                    community: {
                        templateUrl: "templates/community.html"
                    }
                }
            })
        ;
    })

    .controller('DashboardCtrl', function($scope, $state) {
        try {
            $scope.login = JSON.parse(localStorage.getItem("login"));
        } catch (err) {
            $state.go("signup.steps", {step: 1});
            return;
        }
    })

    .controller('SetupCtrl', function($scope, $location, $state, $rootScope) {
        $rootScope.$on("$stateChangeSuccess", function(_1, _2, toParams) {
            $scope.displayedStep = parseInt(toParams.step) - 1;
        });

        $scope.displayedStep = parseInt($state.params.step) - 1;

        var login = localStorage.getItem("login");
        $scope.setup = (login ? JSON.parse(login) :
                        {
                            currentStep: 0,
                            steps: [
                                {name: "Register"},
                                {name: "Apartment"},
                                {name: "Team"},
                                {name: "Complete"}
                            ],
                            user: {}
                        });

        $scope.user = angular.copy($scope.setup.user);

        function doSave() {
            localStorage.setItem("login", JSON.stringify($scope.setup));
        }

        this.createUser = function(form, user) {
            if (form.$invalid) {

            } else {
                $scope.setup.user = angular.copy(user);
                $scope.setup.currentStep = 1;
                doSave();

                $state.go("signup.steps", {step: 2});
            }
        };

        this.saveApartment = function(apt) {
            $scope.setup.apt = angular.copy(apt);
            $scope.setup.currentStep = 2;
            doSave();

            $state.go("signup.steps", {step: 3});
        };

        this.chooseTeam = function(name) {
            $scope.setup.team = name;
            $scope.setup.currentStep = 3;
            doSave();

            $state.go("signup.steps", {step: 4});
        };

        $scope.teams = [
            {id: "", name: "Team Discovery Channel", building: "Anonyco Housing Complex A"},
            {name: "Team America", building: ""},
            {name: "A-Team", building: "Mysterious Holding Company, LLC"}
        ];

        $scope.start = function() {
            $state.go("dashboard.profile");
        };
    })
;
