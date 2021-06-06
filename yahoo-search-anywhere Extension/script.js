document.addEventListener("DOMContentLoaded", function(event) {

});

let query = ""

document.addEventListener("contextmenu", function (event) {
    safari.extension.setContextMenuEventUserInfo(event, { "query": query });
});

window.addEventListener("mouseup", function (event) {
    query = window.getSelection().toString();
});
