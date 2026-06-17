(function () {
  'use strict';

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

  let currentUser = null;
  let selectedCategory = null;
  let searchQuery = '';

  const CATEGORIES = ['All', 'PLUMBING', 'IT_SERVICES', 'ELECTRICAL', 'CLEANING', 'CONSTRUCTION', 'CARPENTRY', 'LANDSCAPING', 'SECURITY', 'TRANSPORT'];

  const app = document.getElementById('app');

  function showToast(msg) {
    let el = document.querySelector('.toast');
    if (!el) {
      el = document.createElement('div');
      el.className = 'toast';
      document.body.appendChild(el);
    }
    el.textContent = msg;
    el.classList.add('show');
    clearTimeout(el._t);
    el._t = setTimeout(function () { el.classList.remove('show'); }, 2500);
  }

  function navigate(hash) {
    window.location.hash = hash;
  }

  function renderLogin() {
    app.innerHTML = `
      <div class="page active">
        <div class="auth-container">
          <div class="auth-icon">&#128274;</div>
          <div class="auth-title">Leads Connection</div>
          <div class="auth-subtitle">Connect with business opportunities</div>
          <div class="form-group">
            <label class="form-label">Email</label>
            <div class="form-input-icon">
              <span class="input-icon">&#9993;</span>
              <input class="form-input" id="loginEmail" type="email" placeholder="your@email.com">
            </div>
          </div>
          <div class="form-group">
            <label class="form-label">Password</label>
            <div class="form-input-icon">
              <span class="input-icon">&#128273;</span>
              <input class="form-input" id="loginPassword" type="password" placeholder="Enter password">
            </div>
          </div>
          <button class="btn btn-primary" id="loginBtn">Login</button>
          <div class="auth-link">Don&apos;t have an account? <a id="goSignup">Sign Up</a></div>
        </div>
      </div>
    `;

    document.getElementById('loginBtn').addEventListener('click', function () {
      const email = document.getElementById('loginEmail').value.trim();
      if (!email) { showToast('Please enter your email'); return; }
      currentUser = Object.assign({}, USER, { email: email });
      showToast('Welcome back, ' + currentUser.firstName + '!');
      navigate('home');
    });

    document.getElementById('goSignup').addEventListener('click', function () {
      navigate('signup');
    });

    document.getElementById('loginPassword').addEventListener('keydown', function (e) {
      if (e.key === 'Enter') document.getElementById('loginBtn').click();
    });
  }

  function renderSignup() {
    app.innerHTML = `
      <div class="page active">
        <div class="auth-container">
          <div class="auth-icon">&#128100;</div>
          <div class="auth-title">Create Account</div>
          <div class="auth-subtitle">Join Leads Connection today</div>
          <div class="form-group">
            <label class="form-label">Full Name</label>
            <div class="form-input-icon">
              <span class="input-icon">&#128100;</span>
              <input class="form-input" id="signupName" type="text" placeholder="John Doe">
            </div>
          </div>
          <div class="form-group">
            <label class="form-label">Company Name (Optional)</label>
            <div class="form-input-icon">
              <span class="input-icon">&#127970;</span>
              <input class="form-input" id="signupCompany" type="text" placeholder="Your Company">
            </div>
          </div>
          <div class="form-group">
            <label class="form-label">Email</label>
            <div class="form-input-icon">
              <span class="input-icon">&#9993;</span>
              <input class="form-input" id="signupEmail" type="email" placeholder="your@email.com">
            </div>
          </div>
          <div class="form-group">
            <label class="form-label">Password</label>
            <div class="form-input-icon">
              <span class="input-icon">&#128273;</span>
              <input class="form-input" id="signupPassword" type="password" placeholder="Create a password">
            </div>
          </div>
          <button class="btn btn-primary" id="signupBtn">Sign Up</button>
          <div class="auth-link">Already have an account? <a id="goLogin">Login</a></div>
        </div>
      </div>
    `;

    document.getElementById('signupBtn').addEventListener('click', function () {
      const name = document.getElementById('signupName').value.trim();
      const email = document.getElementById('signupEmail').value.trim();
      if (!name || !email) { showToast('Please fill in required fields'); return; }
      currentUser = { firstName: name.split(' ')[0], lastName: name.split(' ').slice(1).join(' ') || '', email: email, company: document.getElementById('signupCompany').value.trim() || 'N/A', type: 'Service Provider', activeLeads: 0, completedJobs: 0, rating: 0, stats: { newLeads: 0, completed: 0, inProgress: 0 } };
      showToast('Account created! Welcome, ' + currentUser.firstName + '!');
      navigate('home');
    });

    document.getElementById('goLogin').addEventListener('click', function () { navigate('login'); });
  }

  function renderHome() {
    const u = currentUser || USER;
    const recentLeads = LEADS.slice(0, 5);

    app.innerHTML = `
      <div class="app-bar">
        <span class="app-bar-title">Leads Connection</span>
        <button class="app-bar-action" id="profileBtn">&#128100;</button>
      </div>
      <div class="page active">
        <div class="welcome-card">
          <h2>Welcome back${u.firstName ? ', ' + u.firstName : ''}!</h2>
          <p>Find new business opportunities and connect with potential clients.</p>
        </div>

        <div class="stats-row">
          <div class="stat-card">
            <div class="stat-icon" style="color:var(--primary)">&#128200;</div>
            <div class="stat-value" style="color:var(--primary)">${u.stats.newLeads}</div>
            <div class="stat-label">New Leads</div>
          </div>
          <div class="stat-card">
            <div class="stat-icon" style="color:var(--success)">&#10004;</div>
            <div class="stat-value" style="color:var(--success)">${u.stats.completed}</div>
            <div class="stat-label">Completed</div>
          </div>
          <div class="stat-card">
            <div class="stat-icon" style="color:var(--accent)">&#9881;</div>
            <div class="stat-value" style="color:var(--accent)">${u.stats.inProgress}</div>
            <div class="stat-label">In Progress</div>
          </div>
        </div>

        <div class="quick-actions">
          <button class="btn btn-outline" id="browseBtn">&#128269; Browse Leads</button>
          <button class="btn btn-primary" id="postBtn">&#10133; Post a Lead</button>
        </div>

        <div class="section-header">
          <span class="section-title">Recent Leads</span>
        </div>

        <div id="recentLeads">
          ${recentLeads.map(renderLeadCard).join('')}
        </div>

        <button class="btn btn-primary" id="viewAllBtn" style="margin-top:4px;margin-bottom:16px;">&#9776; View All Leads</button>
      </div>
      <div class="toast"></div>
    `;

    document.getElementById('profileBtn').addEventListener('click', function () { navigate('profile'); });
    document.getElementById('browseBtn').addEventListener('click', function () { navigate('leads'); });
    document.getElementById('postBtn').addEventListener('click', function () { showToast('Post a lead feature coming soon!'); });
    document.getElementById('viewAllBtn').addEventListener('click', function () { navigate('leads'); });

    document.querySelectorAll('.lead-card').forEach(function (card) {
      card.addEventListener('click', function () {
        navigate('lead/' + this.dataset.id);
      });
    });
  }

  function renderLeadCard(lead) {
    return `
      <div class="lead-card" data-id="${lead.id}">
        <div class="lead-card-header">
          <span class="lead-card-title">${lead.title}</span>
          ${lead.isUrgent ? '<span class="chip chip-urgent">URGENT</span>' : ''}
        </div>
        <div class="lead-card-desc">${lead.description}</div>
        <div class="lead-card-meta">
          <span class="lead-card-location">&#128205; ${lead.location}</span>
          <span class="lead-card-budget">R${lead.budget.toLocaleString()}</span>
        </div>
        <div style="margin-top:8px;display:flex;gap:4px;">
          <span class="chip chip-type">${lead.type}</span>
          <span class="chip chip-category">${lead.category.replace(/_/g, ' ')}</span>
        </div>
      </div>
    `;
  }

  function renderLeadsList() {
    const cat = selectedCategory;
    const query = searchQuery.toLowerCase();

    let filtered = LEADS.filter(function (l) {
      if (cat && cat !== 'All' && l.category !== cat) return false;
      if (query && !l.title.toLowerCase().includes(query) && !l.description.toLowerCase().includes(query)) return false;
      return true;
    });

    const chips = CATEGORIES.map(function (c) {
      const active = (c === (cat || 'All')) ? ' active' : '';
      return '<span class="filter-chip' + active + '" data-cat="' + c + '">' + c.replace(/_/g, ' ') + '</span>';
    }).join('');

    app.innerHTML = `
      <div class="app-bar">
        <button class="app-bar-back" id="backBtn">&#8592;</button>
        <span class="app-bar-title-center">Browse Leads</span>
        <span style="width:32px"></span>
      </div>
      <div class="page active">
        <div class="search-bar">
          <span class="search-icon">&#128269;</span>
          <input class="form-input" id="searchInput" placeholder="Search leads..." value="${searchQuery}">
        </div>
        <div class="filter-row">${chips}</div>
        <div class="results-count">${filtered.length} lead${filtered.length !== 1 ? 's' : ''} found</div>
        <div id="leadsList">
          ${filtered.length ? filtered.map(renderLeadCard).join('') : '<div class="loading">No leads found matching your criteria.</div>'}
        </div>
      </div>
    `;

    document.getElementById('backBtn').addEventListener('click', function () { navigate('home'); });

    document.getElementById('searchInput').addEventListener('input', function () {
      searchQuery = this.value;
      renderLeadsList();
    });

    document.querySelectorAll('.filter-chip').forEach(function (chip) {
      chip.addEventListener('click', function () {
        selectedCategory = this.dataset.cat === 'All' ? null : this.dataset.cat;
        renderLeadsList();
      });
    });

    document.querySelectorAll('.lead-card').forEach(function (card) {
      card.addEventListener('click', function () {
        navigate('lead/' + this.dataset.id);
      });
    });
  }

  function renderLeadDetail() {
    const id = window.location.hash.replace('#lead/', '');
    const lead = LEADS.find(function (l) { return l.id === id; });

    if (!lead) {
      app.innerHTML = '<div class="page active"><div class="loading">Lead not found. <a href="#leads" style="color:var(--primary);cursor:pointer;">Back to leads</a></div></div>';
      return;
    }

    const statusColors = { OPEN: 'var(--success)', ASSIGNED: 'var(--info)', IN_PROGRESS: 'var(--accent)', COMPLETED: '#888', CANCELLED: 'var(--error)' };
    const priorityColors = { URGENT: 'var(--error)', HIGH: 'var(--accent)', MEDIUM: '#888', LOW: '#888' };

    function fmt(n) { return 'R' + n.toLocaleString(); }

    function dateStr(d) {
      const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
      const parts = d.split('-');
      return parseInt(parts[2]) + ' ' + months[parseInt(parts[1]) - 1] + ' ' + parts[0];
    }

    app.innerHTML = `
      <div class="app-bar">
        <button class="app-bar-back" id="backBtn">&#8592;</button>
        <span class="app-bar-title-center">Lead Details</span>
        <span style="width:32px"></span>
      </div>
      <div class="page active">
        <div class="detail-title-row">
          <span class="detail-title">${lead.title}</span>
          ${lead.isUrgent ? '<span class="chip chip-urgent">URGENT</span>' : ''}
        </div>

        <div class="detail-chips">
          <span class="chip" style="background:#E8F5E9;color:${statusColors[lead.status]};font-weight:700">${lead.status.replace(/_/g, ' ')}</span>
          <span class="chip" style="background:#FFF3E0;color:${priorityColors[lead.priority]}">${lead.priority}</span>
        </div>

        <div class="budget-card">
          <div class="budget-label">Budget</div>
          <div class="budget-amount">${fmt(lead.budget)}</div>
          <div style="font-size:0.78rem;color:var(--text-variant);margin-top:4px;">Currency: ZAR</div>
        </div>

        <div class="section-label">Description</div>
        <div class="detail-text">${lead.description}</div>

        <div class="section-label">Lead Information</div>
        <div class="info-grid">
          <div class="info-item"><div class="info-label">Type</div><div class="info-value">${lead.type}</div></div>
          <div class="info-item"><div class="info-label">Category</div><div class="info-value">${lead.category.replace(/_/g, ' ')}</div></div>
          <div class="info-item"><div class="info-label">Location</div><div class="info-value">${lead.location}</div></div>
          <div class="info-item"><div class="info-label">Province</div><div class="info-value">${lead.province}</div></div>
          <div class="info-item"><div class="info-label">Company</div><div class="info-value">${lead.company}</div></div>
          <div class="info-item"><div class="info-label">Posted</div><div class="info-value">${dateStr(lead.createdAt)}</div></div>
          <div class="info-item"><div class="info-label">Views</div><div class="info-value">${lead.views}</div></div>
          <div class="info-item"><div class="info-label">Applications</div><div class="info-value">${lead.applications}</div></div>
        </div>

        <div class="section-label">Contact Information</div>
        <div class="contact-row"><span class="contact-icon">&#9993;</span> ${lead.contactEmail}</div>
        <div class="contact-row"><span class="contact-icon">&#9742;</span> ${lead.contactPhone}</div>

        <div class="section-label">Tags</div>
        <div class="tag-row">${lead.tags.map(function (t) { return '<span class="tag">#' + t + '</span>'; }).join('')}</div>

        <div class="detail-actions">
          <button class="btn btn-outline" id="saveBtn">&#128205; Save</button>
          <button class="btn btn-primary" id="applyBtn">&#10148; Apply Now</button>
        </div>
      </div>
    `;

    document.getElementById('backBtn').addEventListener('click', function () { navigate('leads'); });
    document.getElementById('saveBtn').addEventListener('click', function () { showToast('Lead saved to your bookmarks!'); });
    document.getElementById('applyBtn').addEventListener('click', function () { showToast('Application submitted for "' + lead.title + '"'); });
  }

  function renderProfile() {
    const u = currentUser || USER;

    app.innerHTML = `
      <div class="app-bar">
        <button class="app-bar-back" id="backBtn">&#8592;</button>
        <span class="app-bar-title-center">Profile</span>
        <span style="width:32px"></span>
      </div>
      <div class="page active">
        <div class="profile-header">
          <div class="profile-avatar">&#128100;</div>
          <div class="profile-name">${u.firstName} ${u.lastName}</div>
          <div class="profile-email">${u.email}</div>
          <span class="profile-badge">&#10004; ${u.type}</span>
        </div>

        <div class="profile-stats">
          <div class="stat-card">
            <div class="stat-icon" style="color:var(--primary)">&#9776;</div>
            <div class="stat-value" style="color:var(--primary)">${u.stats.newLeads}</div>
            <div class="stat-label">Active Leads</div>
          </div>
          <div class="stat-card">
            <div class="stat-icon" style="color:var(--success)">&#10004;</div>
            <div class="stat-value" style="color:var(--success)">${u.completedJobs}</div>
            <div class="stat-label">Completed</div>
          </div>
          <div class="stat-card">
            <div class="stat-icon" style="color:var(--accent)">&#9733;</div>
            <div class="stat-value" style="color:var(--accent)">${u.rating}</div>
            <div class="stat-label">Rating</div>
          </div>
        </div>

        <div class="section-label">Settings</div>
        <div class="menu-list">
          <div class="menu-item" data-action="edit"><span class="menu-icon">&#128100;</span><span class="menu-text">Edit Profile</span><span class="menu-arrow">&#8250;</span></div>
          <div class="menu-item" data-action="notifications"><span class="menu-icon">&#128276;</span><span class="menu-text">Notification Preferences</span><span class="menu-arrow">&#8250;</span></div>
          <div class="menu-item" data-action="categories"><span class="menu-icon">&#128203;</span><span class="menu-text">Service Categories</span><span class="menu-arrow">&#8250;</span></div>
          <div class="menu-item" data-action="areas"><span class="menu-icon">&#128205;</span><span class="menu-text">Service Areas</span><span class="menu-arrow">&#8250;</span></div>
          <div class="menu-item" data-action="privacy"><span class="menu-icon">&#128274;</span><span class="menu-text">Privacy &amp; Security</span><span class="menu-arrow">&#8250;</span></div>
          <div class="menu-item" data-action="help"><span class="menu-icon">&#10067;</span><span class="menu-text">Help &amp; Support</span><span class="menu-arrow">&#8250;</span></div>
        </div>

        <div class="logout-section">
          <button class="btn btn-outline" id="logoutBtn">&#128682; Logout</button>
        </div>
      </div>
    `;

    document.getElementById('backBtn').addEventListener('click', function () { navigate('home'); });

    document.querySelectorAll('.menu-item').forEach(function (item) {
      item.addEventListener('click', function () {
        showToast(this.querySelector('.menu-text').textContent + ' - coming soon!');
      });
    });

    document.getElementById('logoutBtn').addEventListener('click', function () {
      currentUser = null;
      selectedCategory = null;
      searchQuery = '';
      showToast('Logged out successfully');
      navigate('login');
    });
  }

  function router() {
    const hash = window.location.hash.replace('#', '') || 'login';

    if (!currentUser && hash !== 'login' && hash !== 'signup') {
      navigate('login');
      return;
    }

    if (hash === 'login') renderLogin();
    else if (hash === 'signup') renderSignup();
    else if (hash === 'home') renderHome();
    else if (hash === 'leads') renderLeadsList();
    else if (hash.indexOf('lead/') === 0) renderLeadDetail();
    else if (hash === 'profile') renderProfile();
    else navigate('home');
  }

  window.addEventListener('hashchange', router);
  router();
})();
