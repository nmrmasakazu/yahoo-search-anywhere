document.addEventListener("DOMContentLoaded", function(event) {

});

let query = "aiu"

document.addEventListener("contextmenu", function (event) {
    safari.extension.setContextMenuEventUserInfo(event, { "query": query });
});

window.addEventListener("mouseup", function (event) {
    const selection = window.getSelection();
    if (!selection) return undefined;
    const text = selection.anchorNode.textContent;
    const baseOffset = selection.baseOffset;
    const extentOffset = selection.extentOffset;
    query = text.slice(baseOffset, extentOffset);
});

console.log("yahoo-search-anywhere loaded!");

