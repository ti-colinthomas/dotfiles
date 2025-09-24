// ==UserScript==
// @name         Lumostories rework
// @namespace    http://tampermonkey.net/
// @version      1.0
// @description  Moving some elements on the page
// @author       You
// @match        *://lumostories.com/*
// @match        *://*.lumostories.com/*
// @match        *://www.lumostories.com/*
// @grant        none
// ==/UserScript==

(function() {
  'use strict';
  console.log("Loading userscript");
  // 1. Remove ads from dom
  const elementsToBeRemoved = [
  ]
  const removeAdTargets = () => {
    elementsToBeRemoved.forEach(e => {
      document.querySelectorAll(e).forEach(div => {
        div.remove();
      });
    });
  };

  // Initial cleanup
  removeAdTargets();

  const moveElements = () => {
    const readerButton = document.querySelector(".floating-reader-button-container");
    const audioButton = document.querySelector(".floating-audio-button-container");

    readerButton.style.position = "absolute";
    readerButton.style.top = "100px";

    audioButton.style.position = "absolute";
    audioButton.style.top = "180px";
    console.log("Moved buttons")
  };

  // Re-run cleanup periodically in case links are added dynamically
  const observer = new MutationObserver(() => {
    removeAdTargets();
    moveElements();
  });
  observer.observe(document.body, { childList: true, subtree: true });

  // From chatgpt.
  // Enables double click to select text
  (function(){var s=document.createElement('style');s.textContent='*{user-select:text !important;-webkit-user-select:text !important;-moz-user-select:text !important;}';document.head.appendChild(s);document.querySelectorAll('*').forEach(function(el){el.onmousedown=null;el.onselectstart=null;el.ondblclick=null;});})();

})();

