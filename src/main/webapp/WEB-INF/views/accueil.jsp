<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<title>Forage Web — Accueil</title>
<style>
*{box-sizing:border-box;margin:0;padding:0}
:root{
  --bg:#eef4ff;
  --bg-2:#f8fbff;
  --surface:#ffffff;
  --text:#0f172a;
  --muted:#64748b;
  --primary:#1d4ed8;
  --primary-2:#2563eb;
  --accent:#0ea5e9;
  --border:#dbe5f3;
  --shadow:0 18px 50px rgba(15,23,42,.12);
}
body{
  font-family:Segoe UI,Arial,Helvetica,sans-serif;
  background:
    radial-gradient(circle at top left, rgba(37,99,235,.16), transparent 28%),
    radial-gradient(circle at 85% 15%, rgba(14,165,233,.12), transparent 22%),
    linear-gradient(180deg,var(--bg) 0%,var(--bg-2) 100%);
  color:var(--text);
  min-height:100vh;
}
.page{
  max-width:1180px;
  margin:0 auto;
  padding:20px 20px 48px;
}
.navbar{
  background:rgba(15,23,42,.92);
  backdrop-filter:blur(14px);
  color:#fff;
  padding:16px 22px;
  display:flex;
  align-items:center;
  justify-content:space-between;
  border:1px solid rgba(255,255,255,.08);
  border-radius:20px;
  box-shadow:0 10px 30px rgba(15,23,42,.18);
}
.navbar-brand{
  color:#fff;
  font-size:1.25rem;
  font-weight:800;
  letter-spacing:.02em;
  text-decoration:none;
}
.navbar-brand span{color:#7dd3fc}
.navbar-links{display:flex;gap:10px;flex-wrap:wrap}
.navbar-links a{
  color:#dbeafe;
  text-decoration:none;
  padding:9px 14px;
  border-radius:999px;
  font-size:.94rem;
  transition:transform .15s,background .15s,color .15s;
}
.navbar-links a:hover{background:rgba(255,255,255,.1);color:#fff;transform:translateY(-1px)}
.hero{
  margin-top:22px;
  display:grid;
  grid-template-columns:1.3fr .9fr;
  gap:22px;
  align-items:stretch;
}
.hero-main,.hero-side,.stats,.module-card{
  background:var(--surface);
  border:1px solid rgba(219,229,243,.9);
  box-shadow:var(--shadow);
}
.hero-main{
  border-radius:28px;
  padding:40px;
  position:relative;
  overflow:hidden;
}
.hero-main:before{
  content:"";
  position:absolute;
  inset:auto -60px -80px auto;
  width:220px;
  height:220px;
  border-radius:50%;
  background:radial-gradient(circle, rgba(37,99,235,.18), rgba(37,99,235,0) 70%);
}
.eyebrow{
  display:inline-flex;
  align-items:center;
  gap:8px;
  padding:8px 14px;
  border-radius:999px;
  background:#eff6ff;
  color:var(--primary);
  font-size:.88rem;
  font-weight:700;
  margin-bottom:18px;
}
.hero h1{
  font-size:clamp(2rem,4vw,3.6rem);
  line-height:1.05;
  margin-bottom:16px;
  letter-spacing:-.04em;
}
.hero p{
  font-size:1.05rem;
  color:var(--muted);
  line-height:1.7;
  max-width:58ch;
}
.hero-btns{
  margin-top:28px;
  display:flex;
  gap:12px;
  flex-wrap:wrap;
}
.btn{
  display:inline-flex;
  align-items:center;
  justify-content:center;
  gap:8px;
  padding:12px 18px;
  border-radius:14px;
  text-decoration:none;
  font-weight:700;
  transition:transform .15s,box-shadow .15s,background .15s,border-color .15s;
}
.btn-primary{
  background:linear-gradient(135deg,var(--primary),var(--accent));
  color:#fff;
  box-shadow:0 12px 24px rgba(37,99,235,.24);
}
.btn-primary:hover,.btn-ghost:hover{transform:translateY(-2px)}
.btn-ghost{
  background:#fff;
  color:var(--primary);
  border:1px solid var(--border);
}
.hero-side{
  border-radius:28px;
  padding:28px;
  display:flex;
  flex-direction:column;
  justify-content:space-between;
  background:
    linear-gradient(180deg, rgba(29,78,216,.06), rgba(255,255,255,1) 55%),
    var(--surface);
}
.side-title{
  font-size:1rem;
  font-weight:800;
  color:var(--text);
  margin-bottom:12px;
}
.side-list{
  list-style:none;
  display:grid;
  gap:12px;
}
.side-list li{
  display:flex;
  gap:12px;
  align-items:flex-start;
  padding:14px;
  border-radius:16px;
  background:#f8fbff;
  border:1px solid #edf2fb;
}
.bullet{
  width:36px;
  height:36px;
  border-radius:12px;
  display:grid;
  place-items:center;
  background:#dbeafe;
  color:var(--primary);
  flex:0 0 auto;
  font-weight:800;
}
.side-list strong{display:block;margin-bottom:4px}
.side-list span{color:var(--muted);font-size:.94rem;line-height:1.5}
.stats{
  margin-top:22px;
  border-radius:24px;
  display:grid;
  grid-template-columns:repeat(3,1fr);
  overflow:hidden;
}
.stat{
  padding:22px 18px;
  text-align:center;
  border-right:1px solid var(--border);
}
.stat:last-child{border-right:0}
.stat-num{
  font-size:2rem;
  font-weight:900;
  color:var(--primary);
  line-height:1;
}
.stat-label{
  margin-top:6px;
  color:var(--muted);
  font-size:.88rem;
}
.section{
  margin-top:34px;
}
.section-header{
  display:flex;
  align-items:end;
  justify-content:space-between;
  gap:16px;
  margin-bottom:16px;
}
.section-title{
  font-size:1.25rem;
  font-weight:800;
}
.section-subtitle{
  color:var(--muted);
  font-size:.96rem;
}
.modules{
  display:grid;
  grid-template-columns:repeat(auto-fit,minmax(280px,1fr));
  gap:18px;
}
.module-card{
  border-radius:24px;
  padding:24px;
  text-decoration:none;
  color:inherit;
  border-top:5px solid var(--accent,#2563eb);
  transition:transform .18s,box-shadow .18s,border-color .18s;
}
.module-card:hover{
  transform:translateY(-4px);
  box-shadow:0 22px 42px rgba(15,23,42,.14);
}
.module-top{
  display:flex;
  align-items:center;
  justify-content:space-between;
  gap:12px;
  margin-bottom:18px;
}
.module-icon{
  width:54px;
  height:54px;
  border-radius:18px;
  display:grid;
  place-items:center;
  font-size:1.6rem;
  background:#eff6ff;
}
.module-badge{
  padding:7px 12px;
  border-radius:999px;
  font-size:.8rem;
  font-weight:700;
  background:#f8fafc;
  color:var(--muted);
}
.module-card h3{
  font-size:1.08rem;
  margin-bottom:8px;
}
.module-card p{
  color:var(--muted);
  line-height:1.65;
}
.module-links{
  margin-top:18px;
  display:flex;
  gap:10px;
  flex-wrap:wrap;
}
.chip{
  display:inline-flex;
  align-items:center;
  justify-content:center;
  padding:9px 14px;
  border-radius:999px;
  font-size:.84rem;
  font-weight:700;
  text-decoration:none;
  background:#eff6ff;
  color:var(--primary);
}
.chip:hover{background:var(--primary);color:#fff}
.chip-muted{background:#f8fafc;color:var(--muted)}
.chip-muted:hover{background:#334155;color:#fff}
footer{
  text-align:center;
  padding:28px 12px 8px;
  color:var(--muted);
  font-size:.9rem;
}
@media(max-width:900px){
  .hero{grid-template-columns:1fr}
}
@media(max-width:640px){
  .page{padding:12px}
  .navbar{padding:14px 16px;border-radius:18px}
  .navbar-links{gap:6px}
  .navbar-links a{padding:8px 12px;font-size:.88rem}
  .hero-main,.hero-side{padding:22px;border-radius:22px}
  .stats{grid-template-columns:1fr}
  .stat{border-right:0;border-bottom:1px solid var(--border)}
  .stat:last-child{border-bottom:0}
  .section-header{align-items:flex-start;flex-direction:column}
}
</style>
</head>
<body>

<div class="page">
  <nav class="navbar">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/accueil">Forage<span>Web</span></a>
    <div class="navbar-links">
      <a href="${pageContext.request.contextPath}/accueil">Accueil</a>
      <a href="${pageContext.request.contextPath}/formulaire">Demandes</a>
      <a href="${pageContext.request.contextPath}/devis">Devis</a>
    </div>
  </nav>

  <section class="hero">
    <div class="hero-main">
      <div class="eyebrow">Plateforme de gestion</div>
      <h1>Gérez vos demandes de forage et vos devis depuis un seul espace.</h1>
      <p>
        Suivez les dossiers clients, enregistrez les demandes, préparez les devis
        et gardez une vue claire sur l'avancement de l'activité.
      </p>
      <div class="hero-btns">
        <a class="btn btn-primary" href="${pageContext.request.contextPath}/formulaire">Nouvelle demande</a>
        <a class="btn btn-ghost" href="${pageContext.request.contextPath}/devis/nouveau">Créer un devis</a>
      </div>
    </div>

    <aside class="hero-side">
      <div>
        <div class="side-title">Accès rapide</div>
        <ul class="side-list">
          <li>
            <div class="bullet">1</div>
            <div>
              <strong>Demande client</strong>
              <span>Créer une demande complète en quelques secondes.</span>
            </div>
          </li>
          <li>
            <div class="bullet">2</div>
            <div>
              <strong>Suivi des devis</strong>
              <span>Préparer et consulter les devis liés à chaque demande.</span>
            </div>
          </li>
          <li>
            <div class="bullet">3</div>
            <div>
              <strong>État du dossier</strong>
              <span>Visualiser les demandes validées, refusées ou en attente.</span>
            </div>
          </li>
        </ul>
      </div>
    </aside>
  </section>

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

  <section class="section">
    <div class="section-header">
      <div>
        <div class="section-title">Modules principaux</div>
        <div class="section-subtitle">Les raccourcis les plus utilisés pour gérer l'application.</div>
      </div>
    </div>
    <div class="modules">
      <article class="module-card" style="--accent:#2563eb">
        <div class="module-top">
          <div class="module-icon">D</div>
          <div class="module-badge">Demandes</div>
        </div>
        <h3>Demandes de forage</h3>
        <p>Enregistrez les demandes des clients, consultez la liste et gérez les statuts.</p>
        <div class="module-links">
          <a class="chip" href="${pageContext.request.contextPath}/formulaire">Ajouter</a>
          <a class="chip chip-muted" href="${pageContext.request.contextPath}/demandes">Liste</a>
        </div>
      </article>

      <article class="module-card" style="--accent:#d97706">
        <div class="module-top">
          <div class="module-icon">C</div>
          <div class="module-badge">Clients</div>
        </div>
        <h3>Clients</h3>
        <p>Retrouvez les informations de contact associées à chaque demande enregistrée.</p>
        <div class="module-links">
          <a class="chip" href="${pageContext.request.contextPath}/formulaire">Voir les demandes</a>
        </div>
      </article>

      <article class="module-card" style="--accent:#0f766e">
        <div class="module-top">
          <div class="module-icon">V</div>
          <div class="module-badge">Devis</div>
        </div>
        <h3>Gestion des devis</h3>
        <p>Créez un devis, ajoutez les détails et suivez la progression du dossier.</p>
        <div class="module-links">
          <a class="chip" href="${pageContext.request.contextPath}/devis/nouveau">Nouveau devis</a>
          <a class="chip chip-muted" href="${pageContext.request.contextPath}/devis/liste">Liste devis</a>
        </div>
      </article>
    </div>
  </section>

  <footer>Forage Web &copy; 2025 - Systeme de gestion des demandes de forage</footer>
</div>

</body>
</html>
