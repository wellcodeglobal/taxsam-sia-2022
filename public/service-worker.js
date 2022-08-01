var CACHE_VERSION = 'v1';
var CACHE_NAME = CACHE_VERSION + ':mtu-sw-cache-';

function onInstall(event) {
  console.log('[Serviceworker]', "Installing!", event);
  event.waitUntil(
    caches.open(CACHE_NAME).then(function prefill(cache) {
      return cache.addAll([

        // make sure serviceworker.js is not required by application.js
        // if you want to reference application.js from here
        // '/offline.html',
      ]);
    })
  );
}

function onActivate(event) {
  console.log('[Serviceworker]', "Activating!", event);
  event.waitUntil(
    caches.keys().then(function(cacheNames) {
      return Promise.all(
        cacheNames.filter(function(cacheName) {
          // Return true if you want to remove this cache,
          // but remember that caches are shared across
          // the whole origin
          return cacheName.indexOf(CACHE_VERSION) !== 0;
        }).map(function(cacheName) {
          return caches.delete(cacheName);
        })
      );
    })
  );
}

// Borrowed from https://github.com/TalAter/UpUp
function onFetch(event) {
  event.respondWith(
    // try to return untouched request from network first
    fetch(event.request).catch(function() {
      // if it fails, try to return request from the cache
      return caches.match(event.request).then(function(response) {
        if (response) {
          return response;
        }
        // if not found in cache, return default offline content for navigate requests
        if (event.request.mode === 'navigate' ||
          (event.request.method === 'GET' && event.request.headers.get('accept').includes('text/html'))) {
          console.log('[Serviceworker]', "Fetching offline content", event);
          return caches.match('/offline.html');
        }
      })
    })
  );
}


function onPush(event){
  try {
    var parsedData = JSON.parse(event.data.text());
    var title = parsedData.title;
    delete parsedData.title;

    event.waitUntil(
      self.registration.showNotification(
        title,
        parsedData
      )
    );
  } catch(e){
    var options = {
      body: 'Yay it works.',
    };

    event.waitUntil(
      self.registration.showNotification(
        "Congratulations, You've got a notification!",
        options
      )
    );
  }
}

function onNotificationClick(event){
  console.log('[Service Worker] Notification click Received.', event);
  event.notification.close();
  if(!event.notification.data || !event.notification.data.path){
    return;
  }

  var path = event.notification.data.path
  event.waitUntil(async function() {
    var allClients = await clients.matchAll({
      includeUncontrolled: true
    });

    var desiredClient;
    var desiredClientPattern = new RegExp("^"+path);
    // Let's see if we already have a chat window open:
    for (var client of allClients) {
      var url = new URL(client.url);

      if (url.pathname.match(desiredClientPattern)) {
        // Excellent, let's use it!
        client.focus();
        desiredClient = client;
        break;
      }
    }

    // If we didn't find an existing chat window,
    // open a new one:
    if (!desiredClient) {
      desiredClient = await clients.openWindow(path);
    }

    // Message the client:
    desiredClient.postMessage("New chat messages!");
  }());
}

self.addEventListener('install', onInstall);
self.addEventListener('activate', onActivate);
self.addEventListener('fetch', onFetch);
self.addEventListener('push', onPush);
self.addEventListener('notificationclick', onNotificationClick);