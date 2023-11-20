
// Init static style
var styleElement = document.createElement("style");
var styles = `
  .quick-input-widget {
    top: 40px !important;
    width: calc(100% - 60px) !important;
    margin-left: 0 !important;
    left: 5px !important;
  }
`;
styleElement.textContent = styles;
document.head.appendChild(styleElement);
