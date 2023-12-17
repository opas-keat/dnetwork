'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter.js": "6fef97aeca90b426343ba6c5c9dc5d4a",
"manifest.json": "906fc433ff2f17c2c8af10ca573ca807",
"index.html": "e003aeb8971c58bea4702876fd3185dd",
"/": "e003aeb8971c58bea4702876fd3185dd",
"assets/AssetManifest.bin": "a3d922a0b0bb96200631d1d9f758ce7d",
"assets/images/seal/Seal_Bueng_Kan.png": "5bfd1163695155267013ec4c671daa50",
"assets/images/seal/Seal_Sakon_Nakhon.png": "1e28e6c8e56df94eeebdd69c7feef334",
"assets/images/seal/Seal_Phattalung.png": "aafb1d85e67f432ad9ffd32ef820352d",
"assets/images/seal/Seal_Nongbualamphu.png": "afa3e863e7055fbb6c08ba8663b73cd9",
"assets/images/seal/Seal_Sisaket.png": "2436700bf0868f78497d45d9031e8694",
"assets/images/seal/Seal_Phetchabun.png": "69443ae8e4eee5a759b44642cf01abcf",
"assets/images/seal/Seal_Udon_Thani.png": "3a5cbc5af5b0e8dd55088361084d7f50",
"assets/images/seal/Seal_Mae_Hong_Son.png": "091acae245d0581291c22aa106fb87cf",
"assets/images/seal/Seal_Nakhon_Pathom.png": "c8175b1adc3c8f01ad8446f7521e7dd7",
"assets/images/seal/Seal_Pathum_Thani.png": "5f3464f9416aaf7a1a93b08453f4807a",
"assets/images/seal/Seal_Prachuap_Khiri_Khan.png": "83ff1bbb7f6ea45e4ada86c769b1e86c",
"assets/images/seal/Seal_Songkhla.png": "60da0798cf1436ae3ebc017b3013df62",
"assets/images/seal/Seal_Phitsanulok.png": "0f1f47f8fa4858fa4ec4e19f49237a9d",
"assets/images/seal/Seal_Chachoengsao.png": "11e7e1feea231b9e040e8e15c6bcdbd8",
"assets/images/seal/Seal_Mokdahan.png": "51661d039617dbbd75c141ffecc96b5e",
"assets/images/seal/Seal_Phrae.png": "e430564a61bcde1df404e434c555080b",
"assets/images/seal/Seal_Chaiyaphum.png": "c4f5ddfa5487a84019d96011a4ff2c77",
"assets/images/seal/Seal_Lampang.png": "e9bccffcf49dbebdf04e31e036877e37",
"assets/images/seal/Seal_Nakhon_Nayok.png": "919d7194c9ef4e7074935d73ac1334b7",
"assets/images/seal/Seal_Samut_Sakhon.png": "e1fd59144eb12d740d4ad0bc61f355c5",
"assets/images/seal/Seal_Sing_Buri.png": "18bb6cde0ccc635ee4b45d338ad5eb38",
"assets/images/seal/Seal_Ang_Thong.png": "326ab9de588d447f2e3839add922d9ea",
"assets/images/seal/Seal_Roi_Et.jpg": "519d54f0ed9a2f3e458131e3ebad318a",
"assets/images/seal/Seal_Rayong.png": "350af5894e0894372a0f9c40d1c8e974",
"assets/images/seal/Seal_Suphanburi.png": "c6d2ef77b7ca2028a727c0efc2ceb38f",
"assets/images/seal/Untitled.svg": "af8dff8eda83f84196ab4d4b097720c5",
"assets/images/seal/Seal_Bangkok.png": "d4c1a1410f97e3d9da64544f22cb9ca0",
"assets/images/seal/Seal_Lamphun.png": "325faa36a2aa2887e3e58837e050bc58",
"assets/images/seal/Seal_Surin.png": "906714acf2b2d6cda7edec102a6b3ab4",
"assets/images/seal/Seal_Nakhon_Si_Thammarat.png": "d33927b6777c4cbdf2f06895ffd9368f",
"assets/images/seal/Seal_Sukhothai.png": "4a1fd9a6bfc2ad98320d99c45816d00b",
"assets/images/seal/Seal_Amnatcharoen.png": "0f26feedf41396eb06f8ab30534ec214",
"assets/images/seal/Seal_Khon_Kaen.png": "27fe51cd39fd5c975ac46214d55ddf69",
"assets/images/seal/Seal_Phayao.png": "30a761216d17274419a40f9a226b386a",
"assets/images/seal/Seal_Nong_Khai.png": "462bd022c0a1581e0ae74e904d6eda82",
"assets/images/seal/Seal_Yala.png": "2d5e48002b01fe44f59927380b2cfb0c",
"assets/images/seal/Seal_Chainat.png": "d31d90ef35750bdbab147a34cf933f87",
"assets/images/seal/Seal_Tak.png": "217232dd6803ca47aa13005f9c983b5d",
"assets/images/seal/Seal_Trang.png": "553730345cb1f3d87012acb0b1a80d49",
"assets/images/seal/Seal_Nakhon_Ratchasima.png": "540bfb104167a4eadbf600e3f9eccda0",
"assets/images/seal/Seal_Kalasin.png": "c9bda825966e8cd114c275b68bebcfed",
"assets/images/seal/Seal_Phetchaburi.png": "ae806e740fff06d63783dd1c1f833be9",
"assets/images/seal/Seal_Ratchaburi.png": "6ffa7a7833e1f2aacd14e5964f0d8dcf",
"assets/images/seal/Seal_Phuket.png": "253e9948c099b415399b4c9c0b60cab7",
"assets/images/seal/Seal_Chonburi.png": "4ce4a276d7f2fdcd0f21924ee779814c",
"assets/images/seal/Seal_Sakaeo.png": "6dca95aa222c54b9ebc63bc5c8439f5d",
"assets/images/seal/Seal_Krabi.png": "42fbf9949f8c288ff575b18f6b68c985",
"assets/images/seal/Seal_Narathiwat.png": "79e57c40e4aa422804d25697d9fb9006",
"assets/images/seal/Seal_Chiang_Rai.png": "dac8960d0ec148e9776320079612745f",
"assets/images/seal/Seal_Lopburi.png": "39ccafbaaa2b7fb2f5d70ac05593b427",
"assets/images/seal/Seal_Yasothon.png": "569ab94122258b9cdeb69a6a44b80f5c",
"assets/images/seal/Seal_Maha_Sarakham.png": "820aa3ec487ace93fac47f5bc7a0e8c2",
"assets/images/seal/Seal_Buriram.png": "da50f41e3cf2a532e2b2af3b34d2d13a",
"assets/images/seal/Seal_Pattani.png": "39c608bc56e2e81cddd441b85759b889",
"assets/images/seal/Seal_Kamphaeng_Phet.png": "af81b9cd9ece4b01dde93b61b2eb1f79",
"assets/images/seal/Seal_Ranong.png": "ffe78ebc7bf7ebdef08b917cd7c98283",
"assets/images/seal/Seal_Saraburi.png": "b70f2f17c1922db248933caeeb115466",
"assets/images/seal/Seal_Phichit.png": "e3f340ec07fa2ee3fc28c87a7a1da425",
"assets/images/seal/Seal_Trat.png": "d3e8c8e36cd48d5e9a248e83b54028a9",
"assets/images/seal/Seal_Chanthaburi.png": "7b2d483215e2c75536afaffa215f1d30",
"assets/images/seal/Seal_Nan.png": "acfa6babc086f124e7f908b1d8fae991",
"assets/images/seal/Seal_Samut_Songkhram.png": "d908cfe79d345fd14e9ab1876a802d16",
"assets/images/seal/Seal_Ayutthaya.png": "d8129ef38ab8f1202c2f9865597232a0",
"assets/images/seal/Seal_Uthaithani.png": "3d571127efa8f55472a51daa82fce03b",
"assets/images/seal/Seal_Nakhon_Phanom.png": "131211df6eeee9fc3e9facab72027a7e",
"assets/images/seal/Seal_Chumphon.png": "4b770ca6aef1d8324404967429408d6a",
"assets/images/seal/Seal_Samut_Prakan.png": "b43d504e208c47c03e377600c7cca8be",
"assets/images/seal/Seal_Nonthaburi.png": "7667ba2dfe98bfef3f161d2786eb314b",
"assets/images/seal/Seal_Ubon_Ratchathani.png": "d9de90fde1b55ed29f2fa8204129386e",
"assets/images/seal/Garuda_Emblem_of_Thailand.png": "9389e2a0734885e0e24f49faf6dfecda",
"assets/images/seal/Seal_Phang_Nga.png": "e3b6040887a6f1c841dd1eb8e15ae2cd",
"assets/images/seal/Seal_Kanchanaburi.png": "b6cef302da3d9af31b46a978e2230673",
"assets/images/seal/Seal_Satun.png": "c9864420b4a2de0674d8172ac34e9274",
"assets/images/seal/Seal_Nakhon_Sawan.png": "5715ab02dd668592d841828d28c83a0d",
"assets/images/seal/Seal_Surat_Thani.png": "c331f0ef095c6fa8d150c468d359dbe1",
"assets/images/seal/Seal_Uttaradit.png": "82af5dac5c146e030985e06d0dee6364",
"assets/images/seal/Seal_Prachinburi.png": "95eb980e3d99ee0d511b3d3e8b69d97f",
"assets/images/seal/Seal_Chiang_Mai.png": "527afad0a286a114d555eba9422e8e79",
"assets/images/seal/Seal_Loei.png": "ae8ebaf2ca3dac3e862a7e2f97b4f49e",
"assets/images/undraw_Add_files_re_v09g.png": "6209e0b4e0ef318a7783d01b2cc754a0",
"assets/images/404.png": "5b4567672b17c44f4e63eb35a9169cc0",
"assets/images/avatar.png": "770483b28ac05c681c4f8ab1c6359683",
"assets/fonts/MaterialIcons-Regular.otf": "f9f7fb3335c48b4e4072d3ee24ed665b",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"assets/NOTICES": "dd6c593826a1d979ccb16a36d841f4b6",
"assets/AssetManifest.json": "2efbb41d7877d10aac9d091f58ccd7b9",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "57d849d738900cfd590e9adc7e208250",
"assets/icons/logo-300x300.png": "a4957b1d9e75995dba0d16c252dc9dde",
"assets/icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"assets/icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"assets/icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"assets/icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"favicon.png": "0f6de93df1c66e76e8904ccc4fa716f4",
"main.dart.js": "14e65ad1785c5e06d1fd92ec6ac277ab",
"version.json": "2b521e10dfa0f067561de489a19d6620",
"canvaskit/canvaskit.wasm": "f48eaf57cada79163ec6dec7929486ea",
"canvaskit/skwasm.js": "1df4d741f441fa1a4d10530ced463ef8",
"canvaskit/skwasm.wasm": "6711032e17bf49924b2b001cef0d3ea3",
"canvaskit/skwasm.worker.js": "19659053a277272607529ef87acf9d8a",
"canvaskit/canvaskit.js": "76f7d822f42397160c5dfc69cbc9b2de",
"canvaskit/chromium/canvaskit.wasm": "fc18c3010856029414b70cae1afc5cd9",
"canvaskit/chromium/canvaskit.js": "8c8392ce4a4364cbb240aa09b5652e05"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
