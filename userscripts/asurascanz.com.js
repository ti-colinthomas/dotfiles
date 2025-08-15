// ==UserScript==
// @name         Toongod Popup Blocker
// @namespace    http://tampermonkey.net/
// @version      1.0
// @description  Blocks new tab popups and redirects on asurascanz.com
// @author       You
// @match        *://*.asurascanz.com/*
// @match        *://asurascanz.com/*
// @grant        none
// ==/UserScript==

(function() {
  'use strict';
  const elementsToBeRemoved = [
    "div.code-block",
    "div.chapterbody div.bixbox",
    "div.chaptertags",
    "div#footer"
  ]
  const removeUnwantedElements = () => {
    elementsToBeRemoved.forEach(e => {
      document.querySelectorAll(e).forEach(div => {
        div.remove();
      });
    });
  };

  // 1. Initial cleanup
  removeUnwantedElements();

  // 2. Re-run cleanup periodically in case links are added dynamically
  const observer = new MutationObserver(() => {
    removeUnwantedElements();
  });
  observer.observe(document.body, { childList: true, subtree: true });

  // 3. Add click handler for previous and next
  document.addEventListener("keydown", (event) => {
    if (event.key === "ArrowRight") {
      document.querySelector("div.chnav a.ch-next-btn").click();
    } else if (event.key === "ArrowLeft") {
      document.querySelector("div.chnav a.ch-prev-btn").click();
    }
  });
})();
