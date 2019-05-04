var sass = require('node-sass');
var fs = require("fs-extra");

sass.render(
  {
    file: "../app/web/scss/style.scss"
  },
  function(err, result) {
      fs.writeFile("./html5/style.css", result.css, function(err) {
        if (!err) {
        }
      });
  }
);

fs.copy("../app/web/assets", "./html5/assets");