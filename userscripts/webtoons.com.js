// ==UserScript==
// @name         Toongod Popup Blocker
// @namespace    http://tampermonkey.net/
// @version      1.0
// @description  Blocks new tab popups and redirects on toongod.org
// @author       You
// @match        *://www.webtoons.com/*
// @grant        none
// ==/UserScript==

(function() {
  'use strict';
  // 1. Remove ads from dom
  const removeUnwantedElements = () => {
    document.querySelectorAll('div#_bottomDisplay').forEach(div => {
      div.remove();
    });
    document.querySelectorAll('div#_challengeRoundUp').forEach(div => {
      div.remove();
    });
    document.querySelectorAll('div.notice_area').forEach(div => {
      div.remove();
    });
    document.querySelectorAll('p.dsc_encourage').forEach(div => {
      div.remove();
    });
    document.querySelectorAll('ul.spi_area').forEach(div => {
      div.remove();
    });
    document.querySelectorAll('div.foot_app').forEach(div => {
      div.remove();
    });
    document.querySelectorAll('footer#footer').forEach(div => {
      div.remove();
    });
  };

  // Initial cleanup
  removeUnwantedElements();

  // 2. Re-run cleanup periodically in case links are added dynamically
  const observer = new MutationObserver(() => {
    removeUnwantedElements();
  });
  observer.observe(document.body, { childList: true, subtree: true });

  // 3. Add click handler for previous and next
  document.addEventListener("keydown", (event) => {
    if (event.key === "ArrowRight") {
      document.querySelector("#toolbar a.pg_next").click();
    } else if (event.key === "ArrowLeft") {
      document.querySelector("#toolbar a.pg_prev").click();
    }
  });
})();
