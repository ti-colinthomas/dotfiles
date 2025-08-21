// ==UserScript==
// @name         Novelfire Ad blocker
// @namespace    http://tampermonkey.net/
// @version      1.0
// @description  Blocks ad elements from novelfire
// @author       You
// @match        *://novelfire.net/*
// @grant        none
// ==/UserScript==

(function() {
  'use strict';
  // 1. Remove ads from dom
  const elementsToBeRemoved = [
    "div.nf-ads",
    "div.chapter-comments",
    "div.box-notice",
    "div.report-container",
    "div.box-notification",
    "footer"
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

  // 3. Re-run cleanup periodically in case links are added dynamically
  const observer = new MutationObserver(() => {
    removeAdTargets();
  });
  observer.observe(document.body, { childList: true, subtree: true });
})();

