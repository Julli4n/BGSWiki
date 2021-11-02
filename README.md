<div align="center">
    <br />
    <p>
        <b>BGSWiki</b>
        <br />
        The repository that holds the <i>open source</i> files of the custom <b>CSS</b> (in SASS), <b>JavaScript</b> (in TS/JS), <b>Lua Modules</b>, and <b>wikitext templates</b> for the <a href="//bubble-gum-simulator.fandom.com">Bubble Gum Simulator Wiki</a> on Fandom.
    </p>
    <p>
        <a href="//github.com/RumbleWikis/BGSWiki/blob/main/LICENSE"><image src="https://img.shields.io/github/license/RumbleWikis/BGSWiki" /></a>
        <a href="//github.com/RumbleWikis/BGSWiki/releases"><image src="https://img.shields.io/github/v/release/RumbleWikis/BGSWiki" /></a>
    </p>
</div>

## Reason of Existence
This repository exists solely to allow contributors to pull request, or occasionally create issues to contribute to protected pages on the Wiki.

## Dependencies
* [WikiPages](https://github.com/RumbleWikis/WikiPages)
  * Deployment to the wiki, and page resolution
* [WikiPages-SASS-Compiler-Middleware](https://github.com/RumbleWikis/WikiPages-Middleware)
  * Compiles SASS/SCSS for WikiPages
* [WikiPages-Deno-Bundlerr-Middleware](https://github.com/RumbleWikis/WikiPages-Middleware)
  * Bundles TS/TSX/JS/JSX for WikiPages

## Deployment
Upon the creation of a GitHub release, a private server will fetch the entire Git repository, and compile the files as needed, then saves the new content to the target pages with `<Client>.run(comment)`.

### File Types
Note that files such as ImportJS <b>do not</b> have their own extension.
* Scripts 
  * `.js`, `.jsx`, `.ts`, `.tsx`
* Stylesheets
  *  `.css`, `.scss`, `.sass`
* Modules
  * `.lua`
* Wikitext
  * `.wikitext`
    * Generally, `.wikitext` is not a valid extension and is only used for syntax highlighting for text editing
### Path Resolving
Please see [here](//github.com/RumbleWikis/WikiPages#path-resolving) for more information.

### Compilation
Scripts and style sheets will be compiled and renamed to their `.js` and `.css` extensions respectively.
* Scripts will be put through `deno bundle --unstable --no-check {fileName}` , and the output will be put through the [Babel transpiler](https://babeljs.io) for browser support.
* Stylesheets will only be put through the SASS compiler to be rendered.

## Contributing
All contributions are welcome, as long as they follow [Fandom's Terms of Use](https://www.fandom.com/terms-of-use), and [Bubble Gum Simulator Wiki's rules](https://bubble-gum-simulator.fandom.com/wiki/Community:Rules).

### Prerequisites for the WikiPages CLI
1. Install NodeJs (https://nodejs.org/en/)
2. Install @rumblewikis/wikipages-deno-bundler-middleware (`npm i @rumblewikis/wikipages-deno-bundler-middleware`)
3. Install @rumblewikis/wikipages-sass-compiler-middleware (`npm i @rumblewikis/wikipages-sass-compiler-middleware`)
4. Install dotenv (`npm i dotenv`)
4. Install the WikiPages CLI (`npm i -g @rumblewikis/wikipages`)
5. Try out the CLI `wikipages check`

### Recommended Visual Studio Code Extensions
* [Deno](https://marketplace.visualstudio.com/items?itemName=denoland.vscode-deno) by denoland
  * Deno support and lint
* [Wikitext](https://marketplace.visualstudio.com/items?itemName=RoweWilsonFrederiskHolme.wikitext) by Rowe Wilson Frederisk Holme
  * Wikitext syntax highlighting
* [SASS](https://marketplace.visualstudio.com/items?itemName=Syler.sass-indented) by Syler
  * SASS syntax highlighting
* ~~[vscode-stylelint](https://marketplace.visualstudio.com/items?itemName=stylelint.vscode-stylelint) by Stylelint~~
  * ~~Better style lint/validators~~
* [lua](https://marketplace.visualstudio.com/items?itemName=sumneko.lua) by sumneko
  * For everything cool in Lua
