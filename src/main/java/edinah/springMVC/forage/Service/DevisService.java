package edinah.springMVC.forage.Service;

import edinah.springMVC.forage.Model.*;
import edinah.springMVC.forage.Repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class DevisService {

    @Autowired private DevisRepository            devisRepo;
    @Autowired private DetailDevisRepository      detailRepo;
    @Autowired private DevisStatusRepository      devisStatusRepo;
    @Autowired private DemandeStatusRepository    demandeStatusRepo;

    // ── Vérification : la demande est-elle acceptée (status 3) ? ─────────────
    public boolean demandeEstAcceptee(int idDemande) {
        return demandeStatusRepo.findAll().stream()
               .anyMatch(ds -> ds.getId_demande() == idDemande && ds.getId_status() == 3);
    }

    // ── Créer un devis (+ statut initial Brouillon=1) ─────────────────────────
    @Transactional
    public int creerDevis(Devis devis, List<DetailDevis> details) {
        Devis saved = devisRepo.save(devis);
        int idDevis = saved.getId_devis();

        // Enregistrer les lignes de détail
        for (DetailDevis d : details) {
            d.setId_devis(idDevis);
            detailRepo.save(d);
        }

        // Statut initial = 1 (Brouillon)
        DevisStatus st = new DevisStatus(idDevis, 1, LocalDateTime.now());
        devisStatusRepo.save(st);

        return idDevis;
    }

    // ── Lister tous les devis ─────────────────────────────────────────────────
    public List<Devis> listerDevis() {
        return devisRepo.findAll();
    }

    // ── Devis par demande ─────────────────────────────────────────────────────
    public List<Devis> devisByDemande(int idDemande) {
        return devisRepo.findAll().stream()
               .filter(d -> d.getId_demande() == idDemande)
               .toList();
    }

    // ── Récupérer un devis par id ─────────────────────────────────────────────
    public Devis getDevis(int id) {
        return devisRepo.findById(id).orElse(null);
    }

    // ── Récupérer les détails d'un devis ─────────────────────────────────────
    public List<DetailDevis> getDetails(int idDevis) {
        return detailRepo.findByIdDevis(idDevis);
    }

    // ── Calculer le total d'un devis ──────────────────────────────────────────
    public BigDecimal getTotalDevis(int idDevis) {
        return detailRepo.findByIdDevis(idDevis).stream()
               .map(DetailDevis::getMontantCalcule)
               .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    // ── Modifier un devis (en-tête + détails) ────────────────────────────────
    @Transactional
    public int modifierDevis(Devis devis, List<DetailDevis> details) {
        devisRepo.save(devis);
        detailRepo.deleteByIdDevis(devis.getId_devis());
        for (DetailDevis d : details) {
            d.setId_devis(devis.getId_devis());
            d.setId_detail(0); // forcer INSERT
            detailRepo.save(d);
        }
        return devis.getId_devis();
    }

    // ── Supprimer un devis (+ ses détails en cascade) ─────────────────────────
    @Transactional
    public void supprimerDevis(int id) {
        devisRepo.deleteById(id);
    }

    // ── Changer le statut d'un devis ─────────────────────────────────────────
    @Transactional
    public void changerStatut(int idDevis, int idStatut) {
        DevisStatus st = new DevisStatus(idDevis, idStatut, LocalDateTime.now());
        devisStatusRepo.save(st);
    }

    // ── Dernier statut d'un devis ─────────────────────────────────────────────
    public Optional<DevisStatus> getDernierStatut(int idDevis) {
        return devisStatusRepo.findTopByIdIdDevisOrderByDateStatusDesc(idDevis);
    }

    // ── Historique des statuts d'un devis ─────────────────────────────────────
    public List<DevisStatus> getHistoriqueStatuts(int idDevis) {
        return devisStatusRepo.findByIdIdDevis(idDevis);
    }

    // ── Modifier un seul détail ───────────────────────────────────────────────
    @Transactional
    public void modifierDetail(DetailDevis detail) {
        detailRepo.save(detail);
    }

    // ── Supprimer un seul détail ──────────────────────────────────────────────
    @Transactional
    public void supprimerDetail(int idDetail) {
        detailRepo.deleteById(idDetail);
    }
}
