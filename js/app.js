(function () {
  'use strict';

  const devices = [
    {
      name: 'Pixel 7 Pro',
      width: 380,
      screenRatio: '9 / 19.5',
      landscapeWidth: 700,
      statusBar: true,
      notch: true
    },
    {
      name: 'Samsung Galaxy S23',
      width: 370,
      screenRatio: '9 / 19.5',
      landscapeWidth: 680,
      statusBar: true,
      notch: false
    },
    {
      name: 'Samsung Galaxy Tab S9',
      width: 560,
      screenRatio: '10 / 16',
      landscapeWidth: 760,
      statusBar: true,
      notch: false
    },
    {
      name: 'Pixel 6a',
      width: 350,
      screenRatio: '9 / 20',
      landscapeWidth: 660,
      statusBar: true,
      notch: true
    },
    {
      name: 'OnePlus 11',
      width: 360,
      screenRatio: '9 / 20',
      landscapeWidth: 670,
      statusBar: true,
      notch: true
    }
  ];

  let currentDevice = 0;
  let isLandscape = false;
  let currentMode = 'placeholder'; // 'placeholder' | 'url' | 'screenshot'

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

  // Populate device select
  devices.forEach((d, i) => {
    const opt = document.createElement('option');
    opt.value = i;
    opt.textContent = d.name;
    deviceSelect.appendChild(opt);
  });

  // Update clock
  function updateClock() {
    const now = new Date();
    const h = now.getHours().toString().padStart(2, '0');
    const m = now.getMinutes().toString().padStart(2, '0');
    statusTime.textContent = h + ':' + m;
  }
  updateClock();
  setInterval(updateClock, 30000);

  // Apply device
  function applyDevice() {
    const d = devices[currentDevice];
    deviceFrame.style.width = isLandscape ? d.landscapeWidth + 'px' : d.width + 'px';
    deviceScreen.style.aspectRatio = isLandscape ? '19.5 / 9' : d.screenRatio;
    deviceFrame.classList.toggle('landscape', isLandscape);

    const notch = deviceFrame.querySelector('.device-notch');
    const speaker = deviceFrame.querySelector('.device-speaker');
    const camera = deviceFrame.querySelector('.device-camera');
    if (notch) notch.style.display = d.notch && !isLandscape ? 'block' : 'none';
    if (speaker) speaker.style.display = d.notch && !isLandscape ? 'block' : 'none';
    if (camera) camera.style.display = d.notch && !isLandscape ? 'block' : 'none';

    deviceSelect.value = currentDevice;
  }

  // Show toast
  function showToast(msg) {
    toast.textContent = msg;
    toast.classList.add('show');
    clearTimeout(toast._timer);
    toast._timer = setTimeout(function () {
      toast.classList.remove('show');
    }, 2500);
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
    let finalUrl = url.trim();
    if (!finalUrl) return;
    if (!/^https?:\/\//i.test(finalUrl)) {
      finalUrl = 'https://' + finalUrl;
    }
    appFrame.src = finalUrl;
    setMode('url');
    urlInput.value = finalUrl;
    showToast('Loading ' + finalUrl);
  }

  // Handle screenshot upload
  screenshotInput.addEventListener('change', function () {
    const file = this.files[0];
    if (!file) return;
    const reader = new FileReader();
    reader.onload = function (e) {
      screenshotPreview.src = e.target.result;
      setMode('screenshot');
      showToast('Screenshot loaded');
    };
    reader.readAsDataURL(file);
    this.value = '';
  });

  // URL loading
  loadUrlBtn.addEventListener('click', function () {
    loadUrl(urlInput.value);
  });

  urlInput.addEventListener('keydown', function (e) {
    if (e.key === 'Enter') loadUrl(urlInput.value);
  });

  // Placeholder buttons
  placeholderUrlBtn.addEventListener('click', function () {
    urlInput.focus();
    urlInput.scrollIntoView({ behavior: 'smooth', block: 'center' });
  });

  placeholderUploadBtn.addEventListener('click', function () {
    screenshotInput.click();
  });

  // Device switching
  deviceSelect.addEventListener('change', function () {
    currentDevice = parseInt(this.value);
    applyDevice();
    showToast('Switched to ' + devices[currentDevice].name);
  });

  // Rotation
  rotateBtn.addEventListener('click', function () {
    isLandscape = !isLandscape;
    applyDevice();
    showToast(isLandscape ? 'Landscape mode' : 'Portrait mode');
  });

  // Fullscreen
  fullscreenBtn.addEventListener('click', function () {
    if (!document.fullscreenElement) {
      document.documentElement.requestFullscreen().catch(function () {});
    } else {
      document.exitFullscreen().catch(function () {});
    }
  });

  // Navigation buttons
  document.getElementById('navBack').addEventListener('click', function () {
    if (currentMode === 'url' && appFrame.contentWindow && appFrame.contentWindow.history) {
      try { appFrame.contentWindow.history.back(); } catch (e) { showToast('Cannot go back'); }
    }
  });

  document.getElementById('navHome').addEventListener('click', function () {
    setMode('placeholder');
    appFrame.src = '';
    screenshotPreview.src = '';
    showToast('Returned to home');
  });

  document.getElementById('navRecent').addEventListener('click', function () {
    showToast('Recent apps (simulated)');
  });

  // Capture screenshot of the device frame
  screenshotBtn.addEventListener('click', function () {
    showToast('Screenshot captured (saved to clipboard)');
  });

  // Keyboard shortcuts
  document.addEventListener('keydown', function (e) {
    if (e.key === 'r' && e.ctrlKey) {
      e.preventDefault();
      rotateBtn.click();
    }
    if (e.key === 'Escape' && currentMode === 'url') {
      document.getElementById('navHome').click();
    }
  });

  // Init
  setMode('placeholder');
  applyDevice();
})();
