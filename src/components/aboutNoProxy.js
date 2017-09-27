/*************************************************************************
 * Copyright (c) 2013, The Tor Project, Inc.
 * See LICENSE for licensing information.
 *
 * vim: set sw=2 sts=2 ts=8 et syntax=javascript:
 * 
 * about:tor component
 *************************************************************************/

// Module specific constants
const kMODULE_NAME = "about:noproxy";
const kMODULE_CONTRACTID = "@mozilla.org/network/protocol/about;1?what=noproxy";
const kMODULE_CID = Components.ID("bee9c190-729a-11e7-9598-0800200c9a66");

const kAboutNoProxyURL = "chrome://torbutton/content/aboutNoProxy/aboutNoProxy.xhtml";

const Cc = Components.classes;
const Ci = Components.interfaces;
const Cu = Components.utils;
 
Cu.import("resource://gre/modules/XPCOMUtils.jsm");
 
function AboutNoProxy()
{
}


AboutNoProxy.prototype =
{
  QueryInterface: XPCOMUtils.generateQI([Ci.nsIAboutModule]),

  // nsIClassInfo implementation:
  classDescription: kMODULE_NAME,
  classID: kMODULE_CID,
  contractID: kMODULE_CONTRACTID,

  // nsIAboutModule implementation:
  newChannel: function(aURI)
  {
    let ioSvc = Cc["@mozilla.org/network/io-service;1"]
                  .getService(Ci.nsIIOService);
    let channel = ioSvc.newChannel(kAboutNoProxyURL, null, null);
    channel.originalURI = aURI;

    return channel;
  },

  getURIFlags: function(aURI)
  {
    return Ci.nsIAboutModule.ALLOW_SCRIPT;
  }
};


const NSGetFactory = XPCOMUtils.generateNSGetFactory([AboutNoProxy]);
