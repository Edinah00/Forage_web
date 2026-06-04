<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<title>Forage Web — Accueil</title>
<style>
:root{
  --bg:#0d1117; --surface:#161b22; --surface2:#21262d;
  --border:#30363d; --border-light:#21262d;
  --primary:#2f81f7; --primary-dim:rgba(47,129,247,.15);
  --success:#3fb950; --success-dim:rgba(63,185,80,.15);
  --danger:#f85149; --danger-dim:rgba(248,81,73,.15);
  --warn:#d29922; --warn-dim:rgba(210,153,34,.15);
  --text:#e6edf3; --muted:#8b949e; --muted2:#6e7681;
  --radius:12px; --radius-sm:8px;
  --font-head:'Syne',sans-serif; --font-body:'DM Sans',sans-serif;
}
*{box-sizing:border-box;margin:0;padding:0}
html{scroll-behavior:smooth}
body{font-family:var(--font-body);background:var(--bg);color:var(--text);min-height:100vh;font-size:15px}
.page{max-width:1180px;margin:32px auto;padding:0 20px;display:flex;flex-direction:column;gap:24px}
.nav{position:sticky;top:0;z-index:100;background:rgba(13,17,23,.85);backdrop-filter:blur(16px);border-bottom:1px solid var(--border);padding:0 24px;height:56px;display:flex;align-items:center;justify-content:space-between}
.brand{font-family:var(--font-head);font-size:1.15rem;color:var(--text);text-decoration:none;letter-spacing:-.02em}
.brand em{color:var(--primary);font-style:normal}
.nav-links{display:flex;gap:4px}
.nav-links a{color:var(--muted);text-decoration:none;padding:6px 12px;border-radius:var(--radius-sm);font-size:.9rem;font-weight:500;transition:all .15s}
.nav-links a:hover{background:var(--surface2);color:var(--text)}
.nav-links a.active{background:var(--primary-dim);color:var(--primary)}
.hero{display:grid;grid-template-columns:1.35fr .85fr;gap:22px;align-items:stretch}
.hero-main,.hero-side,.stats,.module-card{background:var(--surface);border:1px solid var(--border);border-radius:24px;box-shadow:0 16px 40px rgba(0,0,0,.18)}
.hero-main{padding:36px;position:relative;overflow:hidden}
.hero-main:before{content:"";position:absolute;inset:auto -50px -80px auto;width:200px;height:200px;border-radius:50%;background:radial-gradient(circle, rgba(47,129,247,.18), rgba(47,129,247,0) 70%)}
.eyebrow{display:inline-flex;align-items:center;gap:8px;padding:8px 14px;border-radius:999px;background:rgba(47,129,247,.12);color:var(--primary);font-size:.88rem;font-weight:700;margin-bottom:18px}
.hero h1{font-family:var(--font-head);font-size:clamp(2rem,4vw,3.4rem);line-height:1.02;margin-bottom:18px;letter-spacing:-.04em}
.hero p{font-size:1rem;color:var(--muted);line-height:1.75;max-width:60ch}
.hero-btns{margin-top:28px;display:flex;gap:12px;flex-wrap:wrap}
.btn{display:inline-flex;align-items:center;justify-content:center;gap:8px;padding:12px 18px;border-radius:14px;text-decoration:none;font-weight:700;transition:transform .15s,box-shadow .15s,background .15s,border-color .15s}
.btn-primary{background:var(--primary);color:#fff;border:1px solid var(--primary)}
.btn-primary:hover{background:#388bfd;transform:translateY(-1px);box-shadow:0 10px 25px rgba(47,129,247,.24)}
.btn-ghost{background:transparent;color:var(--muted);border:1px solid var(--border)}
.btn-ghost:hover{background:var(--surface2);color:var(--text)}
.hero-side{padding:28px;display:flex;flex-direction:column;justify-content:space-between;gap:18px}
.side-title{font-size:1rem;font-weight:800;color:var(--text);margin-bottom:10px}
.side-list{list-style:none;display:grid;gap:12px}
.side-list li{display:flex;gap:14px;align-items:flex-start;padding:16px;border-radius:18px;background:var(--surface2);border:1px solid var(--border)}
.bullet{width:36px;height:36px;border-radius:12px;display:grid;place-items:center;background:rgba(47,129,247,.14);color:var(--primary);font-weight:800;flex:0 0 auto}
.side-list strong{display:block;margin-bottom:4px;color:var(--text)}
.side-list span{color:var(--muted);font-size:.94rem;line-height:1.6}
.stats{margin-top:22px;border-radius:24px;display:grid;grid-template-columns:repeat(3,1fr);overflow:hidden}
.stat{padding:22px 18px;text-align:center;border-right:1px solid var(--border)}
.stat:last-child{border-right:0}
.stat-num{font-family:var(--font-head);font-size:2rem;color:var(--primary);line-height:1}
.stat-label{margin-top:6px;color:var(--muted);font-size:.88rem}
.section{margin-top:34px}
.section-header{display:flex;align-items:end;justify-content:space-between;gap:16px;margin-bottom:16px}
.section-title{font-size:1.25rem;font-weight:800}
.section-subtitle{color:var(--muted);font-size:.96rem}
.modules{display:grid;grid-template-columns:repeat(auto-fit,minmax(280px,1fr));gap:18px}
.module-card{border-radius:24px;padding:24px;color:inherit;border-top:5px solid var(--primary);transition:transform .18s,box-shadow .18s,border-color .18s}
.module-card:hover{transform:translateY(-4px);box-shadow:0 24px 42px rgba(0,0,0,.18)}
.module-top{display:flex;align-items:center;justify-content:space-between;gap:12px;margin-bottom:18px}
.module-icon{width:54px;height:54px;border-radius:18px;display:grid;place-items:center;font-size:1.6rem;background:rgba(47,129,247,.14);color:var(--primary)}
.module-badge{padding:7px 12px;border-radius:999px;font-size:.8rem;font-weight:700;background:rgba(139,148,158,.12);color:var(--muted)}
.module-card h3{font-size:1.08rem;margin-bottom:8px}
.module-card p{color:var(--muted);line-height:1.65}
.module-links{margin-top:18px;display:flex;gap:10px;flex-wrap:wrap}
.chip{display:inline-flex;align-items:center;justify-content:center;padding:9px 14px;border-radius:999px;font-size:.84rem;font-weight:700;text-decoration:none;background:rgba(47,129,247,.12);color:var(--primary)}
.chip:hover{background:var(--primary);color:#fff}
.chip-muted{background:var(--surface2);color:var(--muted)}
.chip-muted:hover{background:var(--border);color:var(--text)}
footer{text-align:center;padding:28px 12px 8px;color:var(--muted);font-size:.9rem}
@media(max-width:900px){.hero{grid-template-columns:1fr}}
@media(max-width:640px){.page{padding:12px}.nav{padding:0 14px}.nav-links{gap:6px}.nav-links a{padding:8px 12px;font-size:.88rem}.hero-main,.hero-side{padding:22px;border-radius:22px}.stats{grid-template-columns:1fr}.stat{border-right:0;border-bottom:1px solid var(--border)}.stat:last-child{border-bottom:0}.section-header{align-items:flex-start;flex-direction:column}}
</style>
</head>
<body>

<div class="page">
  <nav class="nav">
    <a class="brand" href="${pageContext.request.contextPath}/accueil">Forage<em>Web</em></a>
    <div class="nav-links">
      <a href="${pageContext.request.contextPath}/accueil" class="active">Accueil</a>
      <a href="${pageContext.request.contextPath}/formulaire">Demandes</a>
      <a href="${pageContext.request.contextPath}/devis">Devis</a>
      <a href="${pageContext.request.contextPath}/form_demande_status">Statuts</a>
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
