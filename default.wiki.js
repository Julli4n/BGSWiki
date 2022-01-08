// deno-lint-ignore-file
const process = require("process");
const sassCompilerMiddleware = require("@rumblewikis/wikipages-sass-compiler-middleware").default;
const denoBundlerMiddleware = require("@rumblewikis/wikipages-deno-bundler-middleware").default;

require("dotenv").config();

module.exports = {
  credentials: {
    username: process.env.username,
    password: process.env.password,
    apiUrl: "https://bubble-gum-simulator.fandom.com/api.php"
  },
  path: {
    srcDirectory: "src/pages",
    cacheFile: "bgs-cache.json"
  },
  middlewares: [denoBundlerMiddleware, sassCompilerMiddleware, {
    // TO-DO: Implement this in main WikiPages package, under something like "ignoreRegex", then we can add the RegExp to ignore files ending with _DEPRECATED
    type: "Page",
    execute: (page) => {
      if (page.path.endsWith("_DEPRECATED")) {
        page.change({ shouldCommit: false });
      }

      return page;
    }
  }],
  middlewareSettings: {
    denoBundler: {
      useBabel: true,
      parameters: ["--no-check", "--config=tsconfig.json"] // use --no-check here because Deno does not like the DOM types
    }
  }
}
