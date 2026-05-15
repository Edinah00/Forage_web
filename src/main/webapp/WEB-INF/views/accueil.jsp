<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<title>Forage Web — Accueil</title>
<style>
/* ─── Reset & base ─────────────────────────────────────────────────── */
*{box-sizing:border-box;margin:0;padding:0}
body{font-family:Arial,Helvetica,sans-serif;background:#f0f4fa;color:#1e293b;min-height:100vh}

/* ─── Navbar ────────────────────────────────────────────────────────── */
.navbar{
  background:linear-gradient(90deg,#0f172a 0%,#1e3a8a 100%);
  padding:0 32px;display:flex;align-items:center;justify-content:space-between;
  height:64px;box-shadow:0 2px 12px rgba(15,23,42,.25);
}
.navbar-brand{color:#fff;font-size:1.35rem;font-weight:700;letter-spacing:.02em;text-decoration:none}
.navbar-brand span{color:#60a5fa}
.navbar-links{display:flex;gap:8px}
.navbar-links a{
  color:#cbd5e1;text-decoration:none;padding:8px 14px;border-radius:8px;
  font-size:.95rem;transition:background .15s,color .15s;
}
.navbar-links a:hover{background:rgba(255,255,255,.1);color:#fff}

/* ─── Hero ──────────────────────────────────────────────────────────── */
.hero{
  background:linear-gradient(135deg,#1e3a8a 0%,#2563eb 50%,#1d4ed8 100%);
  color:#fff;text-align:center;padding:72px 24px 80px;
  clip-path:ellipse(110% 100% at 50% 0%);
}
.hero h1{font-size:2.5rem;margin-bottom:14px;letter-spacing:-.02em}
.hero p{font-size:1.15rem;color:#bfdbfe;max-width:560px;margin:0 auto 32px;line-height:1.7}
.hero-btns{display:flex;gap:12px;justify-content:center;flex-wrap:wrap}
.btn{
  display:inline-flex;align-items:center;gap:8px;padding:12px 22px;
  border-radius:10px;font-size:.98rem;font-weight:700;text-decoration:none;
  transition:transform .15s,box-shadow .15s,background .15s;cursor:pointer;border:0;
}
.btn-white{background:#fff;color:#1e3a8a;box-shadow:0 4px 16px rgba(0,0,0,.15)}
.btn-white:hover{transform:translateY(-2px);box-shadow:0 8px 24px rgba(0,0,0,.2)}
.btn-outline{background:transparent;color:#fff;border:2px solid rgba(255,255,255,.5)}
.btn-outline:hover{background:rgba(255,255,255,.1);border-color:#fff}

/* ─── Stats bar ─────────────────────────────────────────────────────── */
.stats{
  display:flex;justify-content:center;gap:0;max-width:700px;margin:-28px auto 0;
  background:#fff;border-radius:16px;box-shadow:0 8px 32px rgba(15,23,42,.1);overflow:hidden;
}
.stat{flex:1;text-align:center;padding:22px 12px;border-right:1px solid #e5e7eb}
.stat:last-child{border-right:0}
.stat-num{font-size:1.8rem;font-weight:800;color:#2563eb;line-height:1}
.stat-label{font-size:.82rem;color:#64748b;margin-top:4px}

/* ─── Modules grid ──────────────────────────────────────────────────── */
.section{max-width:1100px;margin:60px auto;padding:0 20px}
.section-title{font-size:1.4rem;font-weight:700;color:#0f172a;margin-bottom:24px;
  padding-bottom:12px;border-bottom:3px solid #2563eb;display:inline-block}
.modules{display:grid;grid-template-columns:repeat(auto-fit,minmax(260px,1fr));gap:20px}

.module-card{
  background:#fff;border-radius:16px;padding:24px;
  box-shadow:0 4px 20px rgba(15,23,42,.07);
  border-top:4px solid var(--accent,#2563eb);
  text-decoration:none;color:inherit;
  transition:transform .2s,box-shadow .2s;display:block;
}
.module-card:hover{transform:translateY(-4px);box-shadow:0 12px 36px rgba(15,23,42,.14)}
.module-icon{font-size:2.2rem;margin-bottom:12px}
.module-card h3{font-size:1.1rem;color:#0f172a;margin-bottom:6px}
.module-card p{font-size:.9rem;color:#64748b;line-height:1.6}
.module-links{margin-top:14px;display:flex;gap:8px;flex-wrap:wrap}
.chip{
  padding:5px 12px;border-radius:999px;font-size:.82rem;font-weight:600;
  text-decoration:none;background:#eff6ff;color:#2563eb;
  transition:background .15s,color .15s;
}
.chip:hover{background:#2563eb;color:#fff}
.chip-green{background:#f0fdf4;color:#16a34a}
.chip-green:hover{background:#16a34a;color:#fff}
.chip-amber{background:#fffbeb;color:#d97706}
.chip-amber:hover{background:#d97706;color:#fff}

/* ─── Footer ────────────────────────────────────────────────────────── */
footer{text-align:center;padding:28px;color:#94a3b8;font-size:.88rem;border-top:1px solid #e2e8f0;margin-top:40px}

@media(max-width:600px){
  .hero h1{font-size:1.7rem}
  .stats{flex-direction:column;margin-top:16px}
  .stat{border-right:0;border-bottom:1px solid #e5e7eb}
}
</style>
</head>
<body>

<!-- NAVBAR -->
<nav class="navbar">
  <a class="navbar-brand" href="${pageContext.request.contextPath}/accueil">Forage<span>Web</span></a>
  <div class="navbar-links">
    <a href="${pageContext.request.contextPath}/accueil">Accueil</a>
    <a href="${pageContext.request.contextPath}/formulaire">Demandes</a>
    <a href="${pageContext.request.contextPath}/devis">Devis</a>
  </div>
</nav>

<!-- HERO -->
<div class="hero">
  <h1>Gestion Forage</h1>
  <p>Plateforme centralisée pour la gestion des demandes de forage, des devis et du suivi des dossiers clients.</p>
  <div class="hero-btns">
    <a class="btn btn-white" href="${pageContext.request.contextPath}/formulaire">📋 Nouvelle demande</a>
    <a class="btn btn-outline" href="${pageContext.request.contextPath}/devis/nouveau">📄 Créer un devis</a>
  </div>
</div>

<!-- STATS -->
<div class="stats">
  <div class="stat">
    <div class="stat-num">${totalDemandes}</div>
    <div class="stat-label">Demandes totales</div>
  </div>
  <div class="stat">
    <div class="stat-num">${demandesAcceptees}</div>
    <div class="stat-label">Demandes acceptées</div>
  </div>
 
  <div class="stat">
    <div class="stat-num">${totalClients}</div>
    <div class="stat-label">Clients</div>
  </div>
</div>

<!-- MODULES -->
<section class="section">
  <span class="section-title">Modules</span>
  <div class="modules">

    <!-- Demandes -->
    <a class="module-card" href="${pageContext.request.contextPath}/formulaire" style="--accent:#2563eb">
      <div class="module-icon">📋</div>
      <h3>Demandes de forage</h3>
      <p>Enregistrez les demandes des clients, consultez la liste et gérez les statuts (accepter / refuser).</p>
      <div class="module-links" onclick="event.stopPropagation()">
        <a class="chip" href="${pageContext.request.contextPath}/formulaire">Ajouter</a>
        <a class="chip" href="${pageContext.request.contextPath}/demandes">Liste</a>
      </div>
    </a>

    <!-- Clients -->
    <a class="module-card" href="#" style="--accent:#d97706">
      <div class="module-icon">👤</div>
      <h3>Clients</h3>
      <p>Retrouvez les informations de contact de chaque client associé à une demande.</p>
      <div class="module-links" onclick="event.stopPropagation()">
        <a class="chip chip-amber" href="#">Voir clients</a>
      </div>
    </a>

  </div>
</section>

<footer>Forage Web &copy; 2025 &mdash; Système de gestion des demandes de forage</footer>

</body>
</html>
