<div align="center">
    <br />
    <p>
        <img src="https://cdn.discordapp.com/icons/516008063791136769/702aaa89cd3f9d0bf5dc36c8b4dddbbe.webp" width="40" alt="Rumble Studio Wikis"/>
        <br />
        <b>BGSWiki</b>
        <br />
        The repository that holds the <i>open source</i> files of the custom <b>CSS</b> (in SASS), <b>JavaScript</b> (in TS/JS), <b>Lua Modules</b>, and <b>wikitext templates</b> for the <a href="//bubble-gum-simulator.fandom.com">Bubble Gum Simulator Wiki</a> on Fandom.
    </p>
    <p>
        <a href="//github.com/Julli4n/BGSWiki/blob/main/LICENSE"><image src="https://img.shields.io/github/license/Julli4n/BGSWiki" /></a>
        <a href="//github.com/Julli4n/BGSWiki/releases"><image src="https://img.shields.io/github/v/release/Julli4n/BGSWiki" /></a>
    </p>
</div>

## Reason of Existence
This repository exists solely to allow contributors to pull request, or occasionally create issues to contribute to protected pages on the Wiki.

## Dependencies
* [Deno runtime](https://deno.land)
  * Bundler, better for the web
* [Babel transpiler](https://babeljs.io)
  * Compatibility for browsers
* [SASS compiler](https://sass-lang.com)
  * SASS to CSS compiler

## Deployment
Upon the creation of a GitHub release, a private server will fetch the entire Git repository, and compile the files as needed, then saves the new content to the target pages.

### File Types
Note that files such as ImportJS <b>do not</b> have their own extension.
* Scripts 
  * `.js`, `.jsx`, `.ts`, `.tsx`
* Stylesheets
  *  `.css`, `.sass`
* Modules
  * `.lua`
* Wikitext
  * `.wikitext`
    * Generally, `.wikitext` is not a valid extension and is only used for syntax highlighting for text editing
### Path Resolving
MediaWiki's URL paths are not delightful to look at, this repository will <b>not</b> handle it the same way. (i.e:  MediaWiki's used format allows for `Module:Test` and `Module:Test/doc` to exist simultaneously as files).
* Only files read recursively from `./src/pages/` will be considered and read.
* The highest ancestor of a file will determine the namespace it will be located at (i.e: `./src/pages/Module/Test.lua` will be located at `Module:Test`)
* The extension of all files will be removed from the filename except for the `.js` and `.css` extensions.
* If the highest ancestor is "Main", it will be considered to be in the main namespace (i.e: `./src/pages/Main/Doggy.wikiteext` will be located at `Doggy`).
* If a file's basename is "index", it will be considered to have the path of its directory (i.e: `./src/pages/Module/Test/index.lua` will be located at `Module:Test`).

### Compilation
Scripts and style sheets will be compiled and renamed to their `.js` and `.css` extensions respectively.
* Scripts will be put through `deno bundle --unstable --no-check {fileName}` , and the output will be put through the [Babel transpiler](https://babeljs.io) for browser support.
* Stylesheets will only be put through the SASS compiler to be rendered.

## Contributing
All contributions are welcome, as long as they follow [Fandom's Terms of Use](https://www.fandom.com/terms-of-use), and [Bubble Gum Simulator Wiki's rules](https://bubble-gum-simulator.fandom.com/wiki/Community:Rules).

### Recommended Visual Studio Code Extensions
* [Deno](https://marketplace.visualstudio.com/items?itemName=denoland.vscode-deno) by denoland
  * Deno support and lint
* [Wikitext](https://marketplace.visualstudio.com/items?itemName=RoweWilsonFrederiskHolme.wikitext) by Rowe Wilson Frederisk Holme
  * Wikitext syntax highlighting
* [SASS](https://marketplace.visualstudio.com/items?itemName=Syler.sass-indented) by Syler
  * SASS syntax highlighting
* [vscode-lua](https://marketplace.visualstudio.com/items?itemName=trixnz.vscode-lua) by trixnz
  * Lua lint and intellisense
