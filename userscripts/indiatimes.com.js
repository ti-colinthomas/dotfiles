// ==UserScript==
// @name         Times of India Ad Blocker
// @namespace    http://tampermonkey.net/
// @version      1.0
// @description  Blocks new tab popups and redirects on indiatimes.com
// @author       You
// @match        *://indiatimes.com/*
// @match        *://timesofindia.indiatimes.com/*
// @match        *://*.indiatimes.com/*
// @match        https://timesofindia.indiatimes.com/
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
  const removeAdTargets = () => {
    document.querySelectorAll('a[target="_blank"]').forEach(link => {
        link.removeAttribute('target');
    });

    const adElements = [
      ".paisa-wrapper",
      ".main_paisa",
      "div.main_paisa + div"
    ]; 
    adElements.forEach(element => {
      document.querySelectorAll(element).forEach(div => {
        div.remove();
      });
    })
  };

  // Initial cleanup
  console.log("Initial cleanup");
  removeAdTargets();

  // 3. Re-run cleanup periodically in case links are added dynamically
  const observer = new MutationObserver(() => {
    console.log("Mutated cleanup");
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

})();

