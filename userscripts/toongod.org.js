// ==UserScript==
// @name         Toongod Popup Blocker
// @namespace    http://tampermonkey.net/
// @version      1.0
// @description  Blocks new tab popups and redirects on toongod.org
// @author       You
// @match        *://toongod.org/*
// @match        *://www.toongod.org/*
// @grant        none
// ==/UserScript==

(function() {
  'use strict';

  console.log("🚫 Ads & Popup Blocker Active");

  // 1. Override window.open
  window.open = function() {
    console.log("Blocked window.open attempt");
    return null;
  };

  Object.defineProperty(window, 'open', {
    configurable: true,
    enumerable: true,
    get: () => function() {
      console.log("Blocked window.open via getter");
      return null;
    },
    set: (val) => {
      console.log("Prevented overwrite of window.open");
    }
  });

  // 2. Remove ads from dom
  const elementsToBeRemoved = [
    "a[target='blank']",
    "p.chapter-noti",
    "div.ad",
    "div#manga-discussion",
    "div.manga-discussion",
    "div.related-manga",
    "div.share-buttons",
    "div.wp-manga-tags-wrapper"
  ]
  const removeAdTargets = () => {
    console.log("Removing ads");
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

  // 4. Optional: Remove sneaky onclick events
  document.addEventListener('click', function(e) {
    if (e.target && typeof e.target.onclick === 'function') {
      e.target.onclick = null;
      console.log("Removed suspicious onclick handler");
    }
  }, true);

  console.log("script loaded");
})();

