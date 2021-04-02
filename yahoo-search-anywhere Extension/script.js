document.addEventListener("DOMContentLoaded", function(event) {

});

let query = "Yahoo!"

document.addEventListener("contextmenu", function (event) {
    safari.extension.setContextMenuEventUserInfo(event, { "query": query });
});

window.addEventListener("mouseup", function (event) {
    const selection = window.getSelection();
    if (!selection) return undefined;
    const text = selection.anchorNode.textContent;
    const baseOffset = selection.baseOffset;
    const extentOffset = selection.extentOffset;
    if (baseOffset < extentOffset) {
        query = text.slice(baseOffset, extentOffset);
    } else {
        query = text.slice(extentOffset, baseOffset);
    }
});
