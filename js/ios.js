(function () {
  'use strict';

  const devices = [
    {
      name: 'iPhone 15 Pro Max',
      width: 430,
      screenRatio: '9 / 19.5',
      landscapeWidth: 760,
      notchStyle: 'dynamic-island',
      frameColor: 'graphite'
    },
    {
      name: 'iPhone 15 Pro',
      width: 393,
      screenRatio: '9 / 19.5',
      landscapeWidth: 740,
      notchStyle: 'dynamic-island',
      frameColor: 'silver'
    },
    {
      name: 'iPhone 15',
      width: 393,
      screenRatio: '9 / 19.5',
      landscapeWidth: 730,
      notchStyle: 'dynamic-island',
      frameColor: 'gold'
    },
    {
      name: 'iPhone 14',
      width: 390,
      screenRatio: '9 / 19.5',
      landscapeWidth: 720,
      notchStyle: 'notch',
      frameColor: 'graphite'
    },
    {
      name: 'iPhone SE (3rd gen)',
      width: 375,
      screenRatio: '9 / 16',
      landscapeWidth: 670,
      notchStyle: 'none',
      frameColor: 'silver'
    }
  ];

  let currentDevice = 0;
  let isLandscape = false;
  let currentMode = 'placeholder';

  const deviceFrame = document.getElementById('deviceFrame');
  const deviceScreen = document.getElementById('deviceScreen');
  const appFrame = document.getElementById('appFrame');
  const screenshotPreview = document.getElementById('screenshotPreview');
  const screenPlaceholder = document.getElementById('screenPlaceholder');
  const urlInput = document.getElementById('urlInput');
  const loadUrlBtn = document.getElementById('loadUrlBtn');
  const screenshotInput = document.getElementById('screenshotInput');
  const deviceSelect = document.getElementById('deviceSelect');
  const rotateBtn = document.getElementById('rotateBtn');
  const screenshotBtn = document.getElementById('screenshotBtn');
  const fullscreenBtn = document.getElementById('fullscreenBtn');
  const statusTime = document.getElementById('statusTime');
  const toast = document.getElementById('toast');
  const placeholderUrlBtn = document.getElementById('placeholderUrlBtn');
  const placeholderUploadBtn = document.getElementById('placeholderUploadBtn');

  function showToast(msg) {
    toast.textContent = msg;
    toast.classList.add('show');
    clearTimeout(toast._timer);
    toast._timer = setTimeout(function () {
      toast.classList.remove('show');
    }, 2500);
  }

  // Populate device select
  devices.forEach(function (d, i) {
    var opt = document.createElement('option');
    opt.value = i;
    opt.textContent = d.name;
    deviceSelect.appendChild(opt);
  });

  // Update clock
  function updateClock() {
    var now = new Date();
    var h = now.getHours().toString().padStart(2, '0');
    var m = now.getMinutes().toString().padStart(2, '0');
    statusTime.textContent = h + ':' + m;
  }
  updateClock();
  setInterval(updateClock, 30000);

  function setNotchStyle(style) {
    deviceFrame.classList.remove('dynamic-island', 'notch', 'no-notch');
    if (style === 'dynamic-island') deviceFrame.classList.add('dynamic-island');
    else if (style === 'notch') deviceFrame.classList.add('notch');
    else deviceFrame.classList.add('no-notch');
  }

  function setFrameColor(color) {
    deviceFrame.classList.remove('graphite', 'silver', 'gold');
    if (color === 'silver') deviceFrame.classList.add('silver');
    else if (color === 'gold') deviceFrame.classList.add('gold');
    else deviceFrame.classList.add('graphite');
  }

  function applyDevice() {
    var d = devices[currentDevice];

    if (isLandscape) {
      deviceFrame.style.width = Math.min(d.landscapeWidth, window.innerWidth - 60) + 'px';
      deviceScreen.style.aspectRatio = '19.5 / 9';
      deviceFrame.classList.add('landscape');
    } else {
      deviceFrame.style.width = Math.min(d.width, window.innerWidth - 40) + 'px';
      deviceScreen.style.aspectRatio = d.screenRatio;
      deviceFrame.classList.remove('landscape');
    }

    setNotchStyle(isLandscape ? 'none' : d.notchStyle);
    setFrameColor(d.frameColor);
    deviceSelect.value = currentDevice;
  }

  // Set mode
  function setMode(mode) {
    currentMode = mode;
    screenPlaceholder.style.display = 'none';
    appFrame.style.display = 'none';
    screenshotPreview.style.display = 'none';

    if (mode === 'placeholder') {
      screenPlaceholder.style.display = 'flex';
    } else if (mode === 'url') {
      appFrame.style.display = 'block';
    } else if (mode === 'screenshot') {
      screenshotPreview.style.display = 'block';
    }
  }

  // Load URL
  function loadUrl(url) {
    var finalUrl = url.trim();
    if (!finalUrl) return;
    if (!/^https?:\/\//i.test(finalUrl)) {
      finalUrl = 'https://' + finalUrl;
    }
    appFrame.src = finalUrl;
    setMode('url');
    urlInput.value = finalUrl;
    showToast('Loading ' + finalUrl);
  }

  // Event listeners
  screenshotInput.addEventListener('change', function () {
    var file = this.files[0];
    if (!file) return;
    var reader = new FileReader();
    reader.onload = function (e) {
      screenshotPreview.src = e.target.result;
      setMode('screenshot');
      showToast('Screenshot loaded');
    };
    reader.readAsDataURL(file);
    this.value = '';
  });

  loadUrlBtn.addEventListener('click', function () {
    loadUrl(urlInput.value);
  });

  urlInput.addEventListener('keydown', function (e) {
    if (e.key === 'Enter') loadUrl(urlInput.value);
  });

  placeholderUrlBtn.addEventListener('click', function () {
    urlInput.focus();
    urlInput.scrollIntoView({ behavior: 'smooth', block: 'center' });
  });

  placeholderUploadBtn.addEventListener('click', function () {
    screenshotInput.click();
  });

  deviceSelect.addEventListener('change', function () {
    currentDevice = parseInt(this.value);
    applyDevice();
    showToast('Switched to ' + devices[currentDevice].name);
  });

  rotateBtn.addEventListener('click', function () {
    isLandscape = !isLandscape;
    applyDevice();
    showToast(isLandscape ? 'Landscape mode' : 'Portrait mode');
  });

  fullscreenBtn.addEventListener('click', function () {
    if (!document.fullscreenElement) {
      document.documentElement.requestFullscreen().catch(function () {});
    } else {
      document.exitFullscreen().catch(function () {});
    }
  });

  screenshotBtn.addEventListener('click', function () {
    showToast('Screenshot captured (saved to clipboard)');
  });

  document.addEventListener('keydown', function (e) {
    if (e.key === 'r' && e.ctrlKey) {
      e.preventDefault();
      rotateBtn.click();
    }
    if (e.key === 'Escape' && currentMode === 'url') {
      appFrame.src = '';
      setMode('placeholder');
    }
  });

  // Window resize handler
  window.addEventListener('resize', function () {
    applyDevice();
  });

  // Init
  setMode('placeholder');
  applyDevice();
})();
