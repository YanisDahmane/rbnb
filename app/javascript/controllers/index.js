// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import HelloController from "./hello_controller"
import RoomsController from "./rooms_controller"
import SearchController from "./search_controller"

application.register("hello", HelloController)
application.register("rooms", RoomsController)
application.register("search", SearchController)
