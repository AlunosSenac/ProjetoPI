const CACHE_NAME = 'my-flask-app-cache-v1';
const urlsToCache = [
  '/',
  '/static/css/style.css',
  '/static/img/logo.png',
  // Adicione mais URLs de recursos que você deseja armazenar em cache
];

self.addEventListener('install', function(event) {
  // Perform install steps
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then(function(cache) {
        console.log('Opened cache');
        return cache.addAll(urlsToCache);
      })
  );
});

self.addEventListener('fetch', function(event) {
  event.respondWith(
    caches.match(event.request)
      .then(function(response) {
        // Cache hit - return response
        if (response) {
          return response;
        }
        return fetch(event.request);
      }
    )
  );
});
