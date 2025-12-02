// Préférences Firefox équilibrées pour un profil quotidien de développement.
// À placer à la racine du profil, à côté de prefs.js.

// Sécurité et vie privée
user_pref("dom.security.https_only_mode", true);
user_pref("privacy.donottrackheader.enabled", true);
user_pref("privacy.globalprivacycontrol.enabled", true);
user_pref("privacy.trackingprotection.enabled", true);
user_pref("privacy.trackingprotection.pbmode.enabled", true);
user_pref("privacy.trackingprotection.emailtracking.enabled", true);
user_pref("privacy.query_stripping.enabled", true);
user_pref("privacy.query_stripping.enabled.pbmode", true);
user_pref("privacy.query_stripping.redirect", true);
user_pref("privacy.query_stripping.strip_on_share.enabled", true);

// Partitionner les cookies intersites au lieu de bloquer tous les cookies tiers.
user_pref("network.cookie.cookieBehavior", 5);
user_pref("network.cookie.cookieBehavior.pbmode", 5);

// Conserver les protections Safe Browsing.
user_pref("browser.safebrowsing.malware.enabled", true);
user_pref("browser.safebrowsing.phishing.enabled", true);

// Collecte de données
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("toolkit.telemetry.enabled", false);
user_pref("app.shield.optoutstudies.enabled", false);

// Interface
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
user_pref("browser.compactmode.show", true);
user_pref("browser.uidensity", 1);
user_pref("browser.tabs.drawInTitlebar", true);
user_pref("general.smoothScroll", true);

// Suggestions sponsorisées
user_pref("browser.newtabpage.activity-stream.showSponsored", false);
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);
user_pref("browser.urlbar.suggest.quicksuggest.sponsored", false);

// Outils de développement
user_pref("devtools.theme", "dark");
user_pref("devtools.toolbox.host", "bottom");
user_pref("devtools.inspector.showUserAgentStyles", true);
user_pref("devtools.webconsole.timestampMessages", true);
user_pref("devtools.editor.tabsize", 2);
user_pref("devtools.editor.expandtab", true);
user_pref("devtools.netmonitor.persistlog", true);
user_pref("devtools.webconsole.persistlog", true);
user_pref("devtools.debugger.source-maps-enabled", true);
