import Elm from '../src/Main.elm'

const div = document.getElementById("app");

window.main = Elm.Elm.Main.init({
    node: div
})