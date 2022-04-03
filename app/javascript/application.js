// Entry point for the build script in your package.json

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import 'bootstrap'
import 'jquery'
import 'jquery-ujs'
import 'bootstrap/dist/js/bootstrap.bundle'

Rails.start()
Turbolinks.start()
ActiveStorage.start()

