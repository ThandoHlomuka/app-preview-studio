(function () {
  'use strict';

  /* ─── DATA ─── */
  const LEADS = [
    { id: '1', title: 'Plumbing Work Needed in Sandton', description: 'Looking for an experienced plumber to fix leaking pipes and install new fittings in a residential property in Sandton. Must be certified and have at least 5 years experience.', budget: 5000, location: 'Sandton', province: 'Gauteng', category: 'PLUMBING', type: 'SERVICE', status: 'OPEN', priority: 'URGENT', isUrgent: true, createdAt: '2026-06-10', views: 45, applications: 3, company: 'Sandton Properties', contactEmail: 'info@sandtonprops.co.za', contactPhone: '011 234 5678', tags: ['plumbing', 'residential', 'urgent'] },
    { id: '2', title: 'Website Development for Restaurant', description: 'We need a modern, responsive website for our new restaurant in Cape Town. Should include menu, online reservations, and gallery features.', budget: 15000, location: 'Cape Town', province: 'Western Cape', category: 'IT_SERVICES', type: 'SERVICE', status: 'OPEN', priority: 'MEDIUM', isUrgent: false, createdAt: '2026-06-08', views: 32, applications: 5, company: 'Bella Vita Restaurant', contactEmail: 'info@bellavita.co.za', contactPhone: '021 987 6543', tags: ['web development', 'restaurant', 'responsive'] },
    { id: '3', title: 'Electrical Installation for Office', description: 'Complete electrical rewiring and installation for a new office space in Midrand. Must comply with SANS 10142 standards.', budget: 35000, location: 'Midrand', province: 'Gauteng', category: 'ELECTRICAL', type: 'SERVICE', status: 'ASSIGNED', priority: 'HIGH', isUrgent: false, createdAt: '2026-06-05', views: 28, applications: 7, company: 'TechHub Offices', contactEmail: 'facilities@techhub.co.za', contactPhone: '010 555 1234', tags: ['electrical', 'office', 'SANS compliance'] },
    { id: '4', title: 'Business Partnership Opportunity', description: 'Established cleaning company looking for a strategic partner to expand into the Johannesburg market. Revenue share model with growth potential.', budget: 50000, location: 'Johannesburg', province: 'Gauteng', category: 'CLEANING', type: 'BUSINESS', status: 'OPEN', priority: 'MEDIUM', isUrgent: false, createdAt: '2026-06-03', views: 67, applications: 10, company: 'CleanPro Solutions', contactEmail: 'info@cleanpro.co.za', contactPhone: '011 333 4444', tags: ['partnership', 'cleaning', 'expansion'] },
    { id: '5', title: 'Funding Available for Construction', description: 'Funding available for large-scale construction projects nationwide. Minimum project value R500,000. Must have approved building plans and environmental clearance.', budget: 500000, location: 'Nationwide', province: 'All', category: 'CONSTRUCTION', type: 'FUNDING', status: 'OPEN', priority: 'URGENT', isUrgent: true, createdAt: '2026-06-01', views: 120, applications: 15, company: 'Growth Capital SA', contactEmail: 'funding@growthcapital.co.za', contactPhone: '012 345 6789', tags: ['funding', 'construction', 'infrastructure'] },
    { id: '6', title: 'Carpentry Work for New Housing', description: 'Need skilled carpenters for kitchen cabinet installation and built-in cupboards for 12 new housing units in Soweto.', budget: 85000, location: 'Soweto', province: 'Gauteng', category: 'CARPENTRY', type: 'SUBCONTRACT', status: 'OPEN', priority: 'HIGH', isUrgent: false, createdAt: '2026-05-28', views: 55, applications: 8, company: 'Urban Development Corp', contactEmail: 'procurement@udc.co.za', contactPhone: '011 777 8888', tags: ['carpentry', 'housing', 'installation'] },
    { id: '7', title: 'Landscaping for Shopping Centre', description: 'Commercial landscaping project including irrigation, paving, and indigenous planting for a new shopping centre in Durban.', budget: 120000, location: 'Durban', province: 'KwaZulu-Natal', category: 'LANDSCAPING', type: 'TENDER', status: 'OPEN', priority: 'MEDIUM', isUrgent: false, createdAt: '2026-05-25', views: 41, applications: 6, company: 'Coastal Malls', contactEmail: 'projects@coastalmalls.co.za', contactPhone: '031 222 3333', tags: ['landscaping', 'commercial', 'irrigation'] },
    { id: '8', title: 'Security System Installation', description: 'CCTV and access control installation for a warehouse in Springs. Must include 16 cameras, biometric access, and remote monitoring.', budget: 45000, location: 'Springs', province: 'Gauteng', category: 'SECURITY', type: 'RFQ', status: 'IN_PROGRESS', priority: 'HIGH', isUrgent: false, createdAt: '2026-05-20', views: 38, applications: 4, company: 'LogiStore Warehousing', contactEmail: 'security@logistore.co.za', contactPhone: '011 444 5555', tags: ['security', 'CCTV', 'access control'] },
    { id: '9', title: 'IT Support Contract Available', description: 'Monthly IT support contract for a law firm with 30 users. Must provide remote and on-site support, server maintenance, and cybersecurity.', budget: 18000, location: 'Pretoria', province: 'Gauteng', category: 'IT_SERVICES', type: 'SERVICE', status: 'OPEN', priority: 'MEDIUM', isUrgent: false, createdAt: '2026-05-18', views: 73, applications: 12, company: 'LegalTech Associates', contactEmail: 'it@legaltech.co.za', contactPhone: '012 666 7777', tags: ['IT support', 'law firm', 'maintenance'] },
    { id: '10', title: 'Transport Services for Mining', description: 'Need reliable transport providers for hauling equipment and materials to mining sites in the Northern Cape. Long-term contract available.', budget: 250000, location: 'Northern Cape', province: 'Northern Cape', category: 'TRANSPORT', type: 'SUPPLY', status: 'OPEN', priority: 'HIGH', isUrgent: false, createdAt: '2026-05-15', views: 89, applications: 9, company: 'Northern Mining Corp', contactEmail: 'logistics@nmc.co.za', contactPhone: '053 888 9999', tags: ['transport', 'mining', 'logistics'] }
  ];

  const USER = {
    firstName: 'John',
    lastName: 'Doe',
    email: 'john.doe@email.com',
    company: 'Doe Enterprises',
    type: 'Service Provider',
    activeLeads: 15,
    completedJobs: 42,
    rating: 4.8,
    stats: { newLeads: 24, completed: 12, inProgress: 8 }
  };

  const CATEGORIES = ['All', 'PLUMBING', 'IT_SERVICES', 'ELECTRICAL', 'CLEANING', 'CONSTRUCTION', 'CARPENTRY', 'LANDSCAPING', 'SECURITY', 'TRANSPORT'];

  let currentUser = null;
  let selectedCategory = null;
  let searchQuery = '';
  let currentPage = 'login';

  const app = document.getElementById('app');

  function esc(s) {
    if (typeof s !== 'string') return s;
    return s.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');
  }

  function showToast(msg) {
    var el = document.querySelector('.toast');
    if (!el) {
      el = document.createElement('div');
      el.className = 'toast';
      document.body.appendChild(el);
    }
    el.textContent = msg;
    el.classList.add('show');
    clearTimeout(el._timer);
    el._timer = setTimeout(function () { el.classList.remove('show'); }, 2500);
  }

  function navigate(hash) {
    window.location.hash = hash;
  }

  function navBar(page) {
    return '' +
      '<div class="bottom-nav" id="bottomNav">' +
        '<button class="nav-item' + (page === 'home' ? ' active' : '') + '" data-nav="home"><svg viewBox="0 0 24 24"><path d="M10 20v-6h4v6h5v-8h3L12 3 2 12h3v8z"/></svg><span>Home</span></button>' +
        '<button class="nav-item' + (page === 'leads' ? ' active' : '') + '" data-nav="leads"><svg viewBox="0 0 24 24"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-1 17.93c-3.95-.49-7-3.85-7-7.93 0-.62.08-1.21.21-1.79L9 15v1c0 1.1.9 2 2 2v1.93zm6.9-2.54c-.26-.81-1-1.39-1.9-1.39h-1v-3c0-.55-.45-1-1-1H8v-2h2c.55 0 1-.45 1-1V7h2c1.1 0 2-.9 2-2v-.41c2.93 1.19 5 4.06 5 7.41 0 2.08-.8 3.97-2.1 5.39z"/></svg><span>Leads</span></button>' +
        '<button class="nav-item' + (page === 'profile' ? ' active' : '') + '" data-nav="profile"><svg viewBox="0 0 24 24"><path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z"/></svg><span>Profile</span></button>' +
      '</div>';
  }

  function header(title, opts) {
    opts = opts || {};
    var back = opts.back ? '<button class="bar-back" id="barBackBtn">\u2039</button>' : '';
    var action = opts.action || '<span style="width:40px"></span>';
    var cls = opts.centered ? ' centered' : '';
    return '<div class="top-app-bar">' + back + '<span class="bar-title' + cls + '">' + title + '</span>' + action + '</div>';
  }

  function frame(html, page) {
    return '<div class="app-scroll"><div class="page active">' + html + '</div></div>' + navBar(page);
  }

  /* ─── PAGES ─── */
  function renderLogin() {
    currentPage = 'login';
    app.innerHTML = '' +
      '<div class="app-scroll">' +
        '<div class="page active">' +
          '<div class="auth-container">' +
            '<div class="auth-logo"><svg viewBox="0 0 24 24"><path d="M12 1L3 5v6c0 5.55 3.84 10.74 9 12 5.16-1.26 9-6.45 9-12V5l-9-4zm0 10.99h7c-.53 4.12-3.28 7.79-7 8.94V12H5V6.3l7-3.11v8.8z"/></svg></div>' +
            '<div class="auth-title">Leads Connection</div>' +
            '<div class="auth-subtitle">Connect with business opportunities</div>' +
            '<div class="form-group"><label class="form-label">Email</label><input class="form-input" id="loginEmail" type="email" placeholder="you@email.com" autocomplete="email"></div>' +
            '<div class="form-group"><label class="form-label">Password</label><input class="form-input" id="loginPassword" type="password" placeholder="Enter password" autocomplete="current-password"></div>' +
            '<button class="btn btn-primary" id="loginBtn">Login</button>' +
            '<div class="auth-link">Don\'t have an account? <a id="goSignup">Sign Up</a></div>' +
          '</div>' +
        '</div>' +
      '</div>';

    var btn = document.getElementById('loginBtn');
    var signup = document.getElementById('goSignup');
    var pw = document.getElementById('loginPassword');
    if (btn) btn.addEventListener('click', function () {
      var email = document.getElementById('loginEmail');
      if (!email || !email.value.trim()) { showToast('Please enter your email'); return; }
      currentUser = Object.assign({}, USER, { email: email.value.trim() });
      showToast('Welcome back, ' + currentUser.firstName + '!');
      navigate('home');
    });
    if (signup) signup.addEventListener('click', function () { navigate('signup'); });
    if (pw) pw.addEventListener('keydown', function (e) {
      if (e.key === 'Enter') { var b = document.getElementById('loginBtn'); if (b) b.click(); }
    });
  }

  function renderSignup() {
    currentPage = 'signup';
    app.innerHTML = '' +
      '<div class="app-scroll">' +
        '<div class="page active">' +
          '<div class="auth-container">' +
            '<div class="auth-logo"><svg viewBox="0 0 24 24"><path d="M15 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm-9-2V7H4v3H1v2h3v3h2v-3h3v-2H6zm9 4c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z"/></svg></div>' +
            '<div class="auth-title">Create Account</div>' +
            '<div class="auth-subtitle">Join Leads Connection today</div>' +
            '<div class="form-group"><label class="form-label">Full Name</label><input class="form-input" id="signupName" type="text" placeholder="John Doe"></div>' +
            '<div class="form-group"><label class="form-label">Company (Optional)</label><input class="form-input" id="signupCompany" type="text" placeholder="Your Company"></div>' +
            '<div class="form-group"><label class="form-label">Email</label><input class="form-input" id="signupEmail" type="email" placeholder="you@email.com"></div>' +
            '<div class="form-group"><label class="form-label">Password</label><input class="form-input" id="signupPassword" type="password" placeholder="Create a password"></div>' +
            '<button class="btn btn-primary" id="signupBtn">Sign Up</button>' +
            '<div class="auth-link">Already have an account? <a id="goLogin">Login</a></div>' +
          '</div>' +
        '</div>' +
      '</div>';

    var btn = document.getElementById('signupBtn');
    var login = document.getElementById('goLogin');
    if (btn) btn.addEventListener('click', function () {
      var name = document.getElementById('signupName');
      var email = document.getElementById('signupEmail');
      if (!name || !email || !name.value.trim() || !email.value.trim()) { showToast('Please fill in required fields'); return; }
      currentUser = {
        firstName: name.value.trim().split(' ')[0],
        lastName: name.value.trim().split(' ').slice(1).join(' ') || '',
        email: email.value.trim(),
        company: (document.getElementById('signupCompany') ? document.getElementById('signupCompany').value.trim() : '') || 'N/A',
        type: 'Service Provider',
        activeLeads: 0, completedJobs: 0, rating: 0,
        stats: { newLeads: 0, completed: 0, inProgress: 0 }
      };
      showToast('Account created! Welcome, ' + currentUser.firstName + '!');
      navigate('home');
    });
    if (login) login.addEventListener('click', function () { navigate('login'); });
  }

  function renderHome() {
    currentPage = 'home';
    var u = currentUser || USER;
    var cards = LEADS.slice(0, 5).map(card).join('');
    app.innerHTML = header('Leads Connection', { action: '<button class="bar-action" id="barActionBtn">\u{1F464}</button>' }) +
      frame('' +
        '<div class="welcome-card"><h2>Welcome back' + (u.firstName ? ', ' + u.firstName : '') + '!</h2><p>Find new business opportunities and connect with potential clients.</p></div>' +
        '<div class="stats-row">' +
          '<div class="stat-card"><div class="stat-value" style="color:var(--primary-light)">' + u.stats.newLeads + '</div><div class="stat-label">New Leads</div></div>' +
          '<div class="stat-card"><div class="stat-value" style="color:#1B5E20">' + u.stats.completed + '</div><div class="stat-label">Completed</div></div>' +
          '<div class="stat-card"><div class="stat-value" style="color:#E65100">' + u.stats.inProgress + '</div><div class="stat-label">In Progress</div></div>' +
        '</div>' +
        '<div class="quick-actions"><button class="btn btn-outline" id="browseBtn">Browse Leads</button><button class="btn btn-primary" id="postBtn">Post a Lead</button></div>' +
        '<div class="section-header"><span class="section-title">Recent Leads</span></div>' +
        cards +
        '<div style="padding:4px 16px 16px"><button class="btn btn-outline" id="viewAllBtn">View All Leads</button></div>',
      'home');

    var a = document.getElementById('barActionBtn');
    var b = document.getElementById('browseBtn');
    var p = document.getElementById('postBtn');
    var v = document.getElementById('viewAllBtn');
    if (a) a.addEventListener('click', function () { navigate('profile'); });
    if (b) b.addEventListener('click', function () { navigate('leads'); });
    if (p) p.addEventListener('click', function () { showToast('Post a lead - coming soon!'); });
    if (v) v.addEventListener('click', function () { navigate('leads'); });
    wireCards();
    wireNav();
  }

  function card(lead) {
    return '<div class="lead-card" data-id="' + lead.id + '">' +
      '<div class="lead-card-header"><span class="lead-card-title">' + esc(lead.title) + '</span>' + (lead.isUrgent ? '<span class="chip chip-urgent">URGENT</span>' : '') + '</div>' +
      '<div class="lead-card-desc">' + esc(lead.description) + '</div>' +
      '<div class="lead-card-meta"><span class="lead-card-location">\u{1F4CD} ' + esc(lead.location) + '</span><span class="lead-card-budget">R' + lead.budget.toLocaleString() + '</span></div>' +
      '<div style="margin-top:8px;display:flex;gap:4px;"><span class="chip chip-type">' + lead.type + '</span><span class="chip chip-category">' + lead.category.replace(/_/g, ' ') + '</span></div>' +
    '</div>';
  }

  function renderLeadsList() {
    currentPage = 'leads';
    var cat = selectedCategory;
    var query = searchQuery.toLowerCase();
    var filtered = LEADS.filter(function (l) {
      if (cat && cat !== 'All' && l.category !== cat) return false;
      if (query && l.title.toLowerCase().indexOf(query) === -1 && l.description.toLowerCase().indexOf(query) === -1) return false;
      return true;
    });

    var chips = CATEGORIES.map(function (c) {
      var a = (c === (cat || 'All')) ? ' active' : '';
      return '<span class="filter-chip' + a + '" data-cat="' + c + '">' + c.replace(/_/g, ' ') + '</span>';
    }).join('');

    var list = filtered.length
      ? filtered.map(card).join('')
      : '<div class="empty-state"><svg viewBox="0 0 24 24"><path d="M15.5 14h-.79l-.28-.27C15.41 12.59 16 11.11 16 9.5 16 5.91 13.09 3 9.5 3S3 5.91 3 9.5 5.91 16 9.5 16c1.61 0 3.09-.59 4.23-1.57l.27.28v.79l5 4.99L20.49 19l-4.99-5zm-6 0C7.01 14 5 11.99 5 9.5S7.01 5 9.5 5 14 7.01 14 9.5 11.99 14 9.5 14z"/></svg><h3>No leads found</h3><p>Try adjusting your search or filters</p></div>';

    app.innerHTML = header('Browse Leads', { back: true, centered: true }) +
      frame('' +
        '<div class="search-bar"><span class="search-icon"><svg viewBox="0 0 24 24"><path d="M15.5 14h-.79l-.28-.27C15.41 12.59 16 11.11 16 9.5 16 5.91 13.09 3 9.5 3S3 5.91 3 9.5 5.91 16 9.5 16c1.61 0 3.09-.59 4.23-1.57l.27.28v.79l5 4.99L20.49 19l-4.99-5zm-6 0C7.01 14 5 11.99 5 9.5S7.01 5 9.5 5 14 7.01 14 9.5 11.99 14 9.5 14z"/></svg></span><input class="form-input" id="searchInput" placeholder="Search leads..." value="' + esc(searchQuery) + '"></div>' +
        '<div class="filter-row">' + chips + '</div>' +
        '<div class="results-count">' + filtered.length + ' lead' + (filtered.length !== 1 ? 's' : '') + ' found</div>' +
        list,
      'leads');

    var back = document.getElementById('barBackBtn');
    var search = document.getElementById('searchInput');
    if (back) back.addEventListener('click', function () { navigate('home'); });
    if (search) search.addEventListener('input', function () { searchQuery = this.value; renderLeadsList(); });

    app.querySelectorAll('.filter-chip').forEach(function (el) {
      el.addEventListener('click', function () {
        selectedCategory = this.dataset.cat === 'All' ? null : this.dataset.cat;
        renderLeadsList();
      });
    });
    wireCards();
    wireNav();
  }

  function renderLeadDetail() {
    currentPage = 'detail';
    var id = window.location.hash.replace('#lead/', '');
    var lead = LEADS.find(function (l) { return l.id === id; });

    if (!lead) {
      app.innerHTML = header('Lead Details', { back: true, centered: true }) +
        '<div class="app-scroll"><div class="page active"><div class="empty-state"><h3>Lead not found</h3><p><a href="#leads" style="color:var(--primary-light);cursor:pointer;">Back to leads</a></p></div></div></div>';
      var back = document.getElementById('barBackBtn');
      if (back) back.addEventListener('click', function () { navigate('leads'); });
      return;
    }

    var statusColors = { OPEN: '#1B5E20', ASSIGNED: '#1565C0', IN_PROGRESS: '#E65100', COMPLETED: '#666', CANCELLED: 'var(--error)' };
    var priorityColors = { URGENT: 'var(--error)', HIGH: '#E65100', MEDIUM: '#666', LOW: '#888' };
    function fmt(n) { return 'R' + n.toLocaleString(); }
    function dateStr(d) {
      if (!d) return '';
      var months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
      var parts = d.split('-');
      return parseInt(parts[2]) + ' ' + months[parseInt(parts[1]) - 1] + ' ' + parts[0];
    }

    var tags = lead.tags.map(function (t) { return '<span class="tag">#' + esc(t) + '</span>'; }).join('');

    app.innerHTML = header('Lead Details', { back: true, centered: true }) +
      '<div class="app-scroll"><div class="page active"><div class="detail-content">' +
        '<div class="detail-title-row"><span class="detail-title">' + esc(lead.title) + '</span>' + (lead.isUrgent ? '<span class="chip chip-urgent">URGENT</span>' : '') + '</div>' +
        '<div class="detail-chips"><span class="chip" style="background:#E8F5E9;color:' + statusColors[lead.status] + ';font-weight:600">' + lead.status.replace(/_/g, ' ') + '</span><span class="chip" style="background:#FFF3E0;color:' + priorityColors[lead.priority] + '">' + lead.priority + '</span></div>' +
        '<div class="budget-card"><div class="budget-label">Budget</div><div class="budget-amount">' + fmt(lead.budget) + '</div></div>' +
        '<div class="section-label">Description</div><div class="detail-text">' + esc(lead.description) + '</div>' +
        '<div class="section-label">Lead Information</div>' +
        '<div class="info-grid">' +
          '<div class="info-item"><div class="info-label">Type</div><div class="info-value">' + lead.type + '</div></div>' +
          '<div class="info-item"><div class="info-label">Category</div><div class="info-value">' + lead.category.replace(/_/g, ' ') + '</div></div>' +
          '<div class="info-item"><div class="info-label">Location</div><div class="info-value">' + esc(lead.location) + '</div></div>' +
          '<div class="info-item"><div class="info-label">Province</div><div class="info-value">' + esc(lead.province) + '</div></div>' +
          '<div class="info-item"><div class="info-label">Company</div><div class="info-value">' + esc(lead.company) + '</div></div>' +
          '<div class="info-item"><div class="info-label">Posted</div><div class="info-value">' + dateStr(lead.createdAt) + '</div></div>' +
          '<div class="info-item"><div class="info-label">Views</div><div class="info-value">' + lead.views + '</div></div>' +
          '<div class="info-item"><div class="info-label">Applications</div><div class="info-value">' + lead.applications + '</div></div>' +
        '</div>' +
        '<div class="section-label">Contact</div>' +
        '<div class="contact-row"><svg viewBox="0 0 24 24"><path d="M20 4H4c-1.1 0-1.99.9-1.99 2L2 18c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V6c0-1.1-.9-2-2-2zm0 4l-8 5-8-5V6l8 5 8-5v2z"/></svg>' + esc(lead.contactEmail) + '</div>' +
        '<div class="contact-row"><svg viewBox="0 0 24 24"><path d="M6.62 10.79c1.44 2.83 3.76 5.14 6.59 6.59l2.2-2.2c.27-.27.67-.36 1.02-.24 1.12.37 2.33.57 3.57.57.55 0 1 .45 1 1V20c0 .55-.45 1-1 1-9.39 0-17-7.61-17-17 0-.55.45-1 1-1h3.5c.55 0 1 .45 1 1 0 1.25.2 2.45.57 3.57.11.35.03.74-.25 1.02l-2.2 2.2z"/></svg>' + esc(lead.contactPhone) + '</div>' +
        '<div class="section-label">Tags</div><div class="tag-row">' + tags + '</div>' +
        '<div class="detail-actions"><button class="btn btn-outline" id="saveBtn">Save</button><button class="btn btn-primary" id="applyBtn">Apply Now</button></div>' +
      '</div></div></div>';

    var back = document.getElementById('barBackBtn');
    var save = document.getElementById('saveBtn');
    var apply = document.getElementById('applyBtn');
    if (back) back.addEventListener('click', function () { navigate('leads'); });
    if (save) save.addEventListener('click', function () { showToast('Lead saved to your bookmarks!'); });
    if (apply) apply.addEventListener('click', function () { showToast('Application submitted for "' + lead.title + '"'); });
  }

  function renderProfile() {
    currentPage = 'profile';
    var u = currentUser || USER;

    var items = [
      { i: 'account', l: 'Edit Profile' },
      { i: 'notifications', l: 'Notification Preferences' },
      { i: 'grid', l: 'Service Categories' },
      { i: 'location', l: 'Service Areas' },
      { i: 'lock', l: 'Privacy & Security' },
      { i: 'help', l: 'Help & Support' }
    ];

    var icons = {
      account: '<svg viewBox="0 0 24 24"><path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z"/></svg>',
      notifications: '<svg viewBox="0 0 24 24"><path d="M12 22c1.1 0 2-.9 2-2h-4c0 1.1.89 2 2 2zm6-6v-5c0-3.07-1.64-5.64-4.5-6.32V4c0-.83-.67-1.5-1.5-1.5s-1.5.67-1.5 1.5v.68C7.63 5.36 6 7.92 6 11v5l-2 2v1h16v-1l-2-2z"/></svg>',
      grid: '<svg viewBox="0 0 24 24"><path d="M3 13h8V3H3v10zm0 8h8v-6H3v6zm10 0h8V11h-8v10zm0-18v6h8V3h-8z"/></svg>',
      location: '<svg viewBox="0 0 24 24"><path d="M12 2C8.13 2 5 5.13 5 9c0 5.25 7 13 7 13s7-7.75 7-13c0-3.87-3.13-7-7-7zm0 9.5c-1.38 0-2.5-1.12-2.5-2.5s1.12-2.5 2.5-2.5 2.5 1.12 2.5 2.5-1.12 2.5-2.5 2.5z"/></svg>',
      lock: '<svg viewBox="0 0 24 24"><path d="M18 8h-1V6c0-2.76-2.24-5-5-5S7 3.24 7 6v2H6c-1.1 0-2 .9-2 2v10c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V10c0-1.1-.9-2-2-2zm-6 9c-1.1 0-2-.9-2-2s.9-2 2-2 2 .9 2 2-.9 2-2 2zm3.1-9H8.9V6c0-1.71 1.39-3.1 3.1-3.1 1.71 0 3.1 1.39 3.1 3.1v2z"/></svg>',
      help: '<svg viewBox="0 0 24 24"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm1 17h-2v-2h2v2zm2.07-7.75l-.9.92C13.45 12.9 13 13.5 13 15h-2v-.5c0-1.1.45-2.1 1.17-2.83l1.24-1.26c.37-.36.59-.86.59-1.41 0-1.1-.9-2-2-2s-2 .9-2 2H8c0-2.21 1.79-4 4-4s4 1.79 4 4c0 .88-.36 1.68-.93 2.25z"/></svg>'
    };

    var menu = items.map(function (m) {
      return '<div class="menu-item" data-action="' + m.l + '">' + (icons[m.i] || icons.account) + '<span class="menu-text">' + m.l + '</span><span class="menu-arrow">\u203A</span></div>';
    }).join('');

    app.innerHTML = header('Profile', { back: true, centered: true }) +
      frame('' +
        '<div class="profile-header">' +
          '<div class="profile-avatar">\u{1F464}</div>' +
          '<div class="profile-name">' + esc(u.firstName + ' ' + u.lastName) + '</div>' +
          '<div class="profile-email">' + esc(u.email) + '</div>' +
          '<span class="profile-badge">\u2714 ' + u.type + '</span>' +
        '</div>' +
        '<div class="profile-stats">' +
          '<div class="stat-card"><div class="stat-value" style="color:var(--primary-light)">' + u.stats.newLeads + '</div><div class="stat-label">Active</div></div>' +
          '<div class="stat-card"><div class="stat-value" style="color:#1B5E20">' + u.completedJobs + '</div><div class="stat-label">Completed</div></div>' +
          '<div class="stat-card"><div class="stat-value" style="color:var(--warning)">' + u.rating + '</div><div class="stat-label">Rating</div></div>' +
        '</div>' +
        '<div class="section-label" style="padding-left:16px;">Settings</div>' +
        '<div class="menu-list">' + menu + '</div>' +
        '<div class="logout-section"><button class="btn btn-outline" id="logoutBtn">Logout</button></div>',
      'profile');

    var back = document.getElementById('barBackBtn');
    var logout = document.getElementById('logoutBtn');
    if (back) back.addEventListener('click', function () { navigate('home'); });
    if (logout) logout.addEventListener('click', function () {
      currentUser = null; selectedCategory = null; searchQuery = '';
      showToast('Logged out successfully');
      navigate('login');
    });
    app.querySelectorAll('.menu-item').forEach(function (el) {
      el.addEventListener('click', function () {
        showToast(this.querySelector('.menu-text').textContent + ' - coming soon!');
      });
    });
    wireNav();
  }

  function wireCards() {
    app.querySelectorAll('.lead-card').forEach(function (el) {
      el.addEventListener('click', function () { navigate('lead/' + this.dataset.id); });
    });
  }

  function wireNav() {
    var nav = document.getElementById('bottomNav');
    if (!nav) return;
    nav.querySelectorAll('.nav-item').forEach(function (el) {
      el.addEventListener('click', function () { var p = this.dataset.nav; if (p) navigate(p); });
    });
  }

  /* ─── ROUTER ─── */
  function router() {
    try {
      var hash = window.location.hash.replace('#', '') || 'login';
      if (!currentUser && hash !== 'login' && hash !== 'signup') { navigate('login'); return; }
      if (hash === 'login') renderLogin();
      else if (hash === 'signup') renderSignup();
      else if (hash === 'home') renderHome();
      else if (hash === 'leads') renderLeadsList();
      else if (hash.indexOf('lead/') === 0) renderLeadDetail();
      else if (hash === 'profile') renderProfile();
      else navigate('home');
    } catch (e) {
      app.innerHTML = '<div class="app-scroll"><div class="page active"><div class="empty-state"><h3>Something went wrong</h3><p>' + esc(e.message) + '</p><button class="btn btn-primary" id="reloadBtn" style="margin-top:16px">Reload</button></div></div></div>';
      var r = document.getElementById('reloadBtn');
      if (r) r.addEventListener('click', function () { window.location.reload(); });
    }
  }

  window.addEventListener('hashchange', router);
  router();
})();
