package edinah.springMVC.forage.Service;

import edinah.springMVC.forage.Model.Demande;
import edinah.springMVC.forage.Model.DemandeStatus;
import edinah.springMVC.forage.Repository.DemandeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

/**
 * CORRECTIONS :
 *  1. Génération automatique de ref_demande (format DEM-YYYYMMDD-XXXX)
 *  2. validerDemande  → id_status = 2 ("Demande Acceptée")  [était 3 = Refusée]
 *  3. refuserDemande  → id_status = 3 ("Demande Refusée")   [était 2 = Acceptée]
 *  4. Méthode listerDemandesAcceptees() pour le compteur du tableau de bord
 */
@Service
public class DemandeService {

    @Autowired private DemandeRepository    demandeRepository;
    @Autowired private DemandeStatusService demandeStatusService;

    private static final DateTimeFormatter FMT = DateTimeFormatter.ofPattern("yyyyMMdd");

    // ── CRUD ─────────────────────────────────────────────────────

    @Transactional
    public int ajouterDemande(Demande d) {
        // Génération de la référence si absente ou vide
        if (d.getRef_demande() == null || d.getRef_demande().isBlank()) {
            d.setRef_demande("DEM-TMP-" + System.currentTimeMillis());
        }
        Demande saved = demandeRepository.save(d);

        // Référence définitive avec l'id généré
        String ref = "DEM-" + LocalDateTime.now().format(FMT) + "-" + String.format("%04d", saved.getId_demande());
        saved.setRef_demande(ref);
        demandeRepository.save(saved);

        // Statut initial : 1 = Demande Créée
        DemandeStatus status = new DemandeStatus();
        status.setId_demande(saved.getId_demande());
        status.setId_status(1);
        status.setDate_status(LocalDateTime.now());
        demandeStatusService.ajouterDemandeStatus(status);

        return saved.getId_demande();
    }

    public List<Demande> listerDemandes() {
        return demandeRepository.findAll();
    }

    public long compterDemandesAcceptees() {
        return demandeRepository.countAcceptees();
    }

    public Demande getDemande(int idDemande) {
        return demandeRepository.findById(idDemande).orElse(null);
    }

    public Demande getDemandeByRef(String refDemande) {
        if (refDemande == null || refDemande.isBlank()) return null;
        return demandeRepository.findByRefDemande(refDemande.trim()).orElse(null);
    }

    @Transactional
    public int modifierDemande(Demande d) {
        return demandeRepository.save(d).getId_demande();
    }

    @Transactional
    public int supprimerDemande(int idDemande) {
        demandeRepository.deleteById(idDemande);
        return idDemande;
    }

    // ── Transitions de statut ────────────────────────────────────

    /**
     * CORRECTION : status 2 = "Demande Acceptée" (était 3 par erreur)
     */
    @Transactional
    public int validerDemande(int idDemande) {
        DemandeStatus status = new DemandeStatus();
        status.setId_demande(idDemande);
        status.setId_status(2); // ← CORRIGÉ (était 3)
        status.setDate_status(LocalDateTime.now());
        demandeStatusService.ajouterDemandeStatus(status);
        return idDemande;
    }

    /**
     * CORRECTION : status 3 = "Demande Refusée" (était 2 par erreur)
     */
    @Transactional
    public int refuserDemande(int idDemande) {
        DemandeStatus status = new DemandeStatus();
        status.setId_demande(idDemande);
        status.setId_status(3); // ← CORRIGÉ (était 2)
        status.setDate_status(LocalDateTime.now());
        demandeStatusService.ajouterDemandeStatus(status);
        return idDemande;
    }
}