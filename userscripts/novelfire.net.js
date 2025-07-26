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

    console.log("🚫 Ads ");

    // 1. Remove ads from dom
    const removeAdTargets = () => {
      document.querySelectorAll('div.nf-ads').forEach(div => {
        div.style.display = 'none';
        div.remove();
      });
    };

    // Initial cleanup
    console.log("Removing ads initially");
    removeAdTargets();

    // 3. Re-run cleanup periodically in case links are added dynamically
    const observer = new MutationObserver(() => {
      console.log("Removing ads on page mutation");
      removeAdTargets();
    });
    observer.observe(document.body, { childList: true, subtree: true });
})();

