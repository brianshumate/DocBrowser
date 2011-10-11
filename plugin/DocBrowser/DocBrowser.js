/* MIT licensed */
// (c) 2010 Jesse MacFadyen, Nitobi

/*global PhoneGap */

function DocBrowser() {
  // Does nothing
}

// Callback when the location of the page changes
// called from native
DocBrowser._onLocationChange = function(newLoc)
{
  window.plugins.docBrowser.onLocationChange(newLoc);
};

// Callback when the user chooses the 'Done' button
// called from native
DocBrowser._onClose = function()
{
  window.plugins.docBrowser.onClose();
};

// Callback when the user chooses the 'open in Safari' button
// called from native
DocBrowser._onOpenExternal = function()
{
  window.plugins.docBrowser.onOpenExternal();
};

// Pages loaded into the DocBrowser can execute callback scripts, so be careful to
// check location, and make sure it is a location you trust.
// Warning ... don't exec arbitrary code, it's risky and could fuck up your app.
// called from native
DocBrowser._onJSCallback = function(js,loc)
{
  // Not Implemented
  //window.plugins.docBrowser.onJSCallback(js,loc);
};

/* The interface that you will use to access functionality */

// Show a webpage, will result in a callback to onLocationChange
DocBrowser.prototype.showWebPage = function(loc)
{
  PhoneGap.exec("DocBrowserCommand.showWebPage", loc);
};

// close the browser, will NOT result in close callback
DocBrowser.prototype.close = function()
{
  PhoneGap.exec("DocBrowserCommand.close");
};

// Not Implemented
DocBrowser.prototype.jsExec = function(jsString)
{
  // Not Implemented!!
  //PhoneGap.exec("DocBrowserCommand.jsExec",jsString);
};

// Note: this plugin does NOT install itself, call this method some time after deviceready to install it
// it will be returned, and also available globally from window.plugins.docBrowser
DocBrowser.install = function()
{
  if(!window.plugins) {
    window.plugins = {};
  }

  window.plugins.docBrowser = new DocBrowser();
  return window.plugins.docBrowser;
};