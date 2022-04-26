// Entry point for the build script in your package.json

import "@hotwired/turbo-rails"
import "./controllers"
import * as ActiveStorage from "@rails/activestorage"

import 'bootstrap'
import 'bootstrap/dist/js/bootstrap.bundle'
import 'bootstrap/js/dist/dropdown'

import "trix"
import "@rails/actiontext"
ActiveStorage.start()
