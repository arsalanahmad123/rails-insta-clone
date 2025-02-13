// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

import FlashController from "./flash_controller"
application.register("flash", FlashController)

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import InfinitescrollController from "./infinitescroll_controller"
application.register("infinitescroll", InfinitescrollController)

import PostformController from "./postform_controller"
application.register("postform", PostformController)

import VideoController from "./video_controller"
application.register("video", VideoController)
