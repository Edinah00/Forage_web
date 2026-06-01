package edinah.springMVC.forage.Service;

import java.time.DayOfWeek;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.temporal.ChronoUnit;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edinah.springMVC.forage.Model.DemandeStatus;
import edinah.springMVC.forage.Model.DemandeStatusId;
import edinah.springMVC.forage.Model.Utils;
import edinah.springMVC.forage.Repository.DemandeStatusRepository;
import jakarta.transaction.Transactional;

@Service
public class DemandeStatusService {
    
    @Autowired
    private DemandeStatusRepository demandeStatusRepository;
    @Autowired
    private ParametreService parametreService;

    @Transactional
    public int ajouterDemandeStatus(DemandeStatus d) {
        demandeStatusRepository.save(d);
        return d.getId_demande();
    }

    public List<DemandeStatus> listerDemandes() {
        return demandeStatusRepository.findAll();
    }

    public List<DemandeStatus> listerDemandesStatus() {
        List<DemandeStatus> statuses = demandeStatusRepository.findAllOrderByDemandeAndDate();
        appliquerDureesTravail(statuses);
        return statuses;
    }

    public List<DemandeStatus> findByDemande(int idDemande) {
        return demandeStatusRepository.findByDemandeId(idDemande);
    }

    public DemandeStatus getDemande(int idDemande, int idStatus) {
        return demandeStatusRepository.findById(new DemandeStatusId(idDemande, idStatus)).orElse(null);
    }

    @Transactional
    public int modifierDemande(DemandeStatus d) {
        demandeStatusRepository.save(d);
        return d.getId_demande();
    }

    @Transactional
    public int modifierDemandeStatus(DemandeStatus d) {
        demandeStatusRepository.save(d);
        return d.getId_demande();
    }

    @Transactional
    public int supprimerDemande(int idDemande, int idStatus) {
        demandeStatusRepository.deleteById(new DemandeStatusId(idDemande, idStatus));
        return idDemande;
    }

    public Utils getStatusMapper() {
        return new Utils();
    }

    private void appliquerDureesTravail(List<DemandeStatus> statuses) {
        Map<Integer, LocalDateTime> dernierStatutParDemande = new HashMap<>();
        Map<Integer, Integer> dernierIdStatusParDemande = new HashMap<>();
        for (DemandeStatus statut : statuses) {
            Integer idDemande = statut.getId_demande();
            LocalDateTime courant = statut.getDate_status();
            LocalDateTime precedent = dernierStatutParDemande.get(idDemande);
            Integer precedentIdStatus = dernierIdStatusParDemande.get(idDemande);
            if (precedent == null || courant == null) {
                statut.setDuree_travail_minutes(null);
                statut.setCouleur(null);
            } else {
                long duree = calculerMinutesOuvrees(precedent, courant);
                statut.setDuree_travail_minutes(duree);
                statut.setCouleur(parametreService.trouverCouleur(precedentIdStatus, statut.getId_status(), duree));
            }
            if (courant != null) {
                dernierStatutParDemande.put(idDemande, courant);
                dernierIdStatusParDemande.put(idDemande, statut.getId_status());
            }
        }
    }

    private long calculerMinutesOuvrees(LocalDateTime debut, LocalDateTime fin) {
        if (fin.isBefore(debut)) {
            return 0L;
        }

        LocalTime heureDebut = LocalTime.of(8, 0);
        LocalTime heureFin = LocalTime.of(16, 0);
        long totalMinutes = 0L;

        LocalDateTime courant = debut;
        while (courant.toLocalDate().isBefore(fin.toLocalDate()) || courant.toLocalDate().isEqual(fin.toLocalDate())) {
            if (estJourOuvre(courant)) {
                LocalDateTime debutJour = courant.toLocalDate().atTime(heureDebut);
                LocalDateTime finJour = courant.toLocalDate().atTime(heureFin);

                LocalDateTime debutCalcule = courant.isAfter(debutJour) ? courant : debutJour;
                LocalDateTime finCalcule = fin.isBefore(finJour) ? fin : finJour;

                if (finCalcule.isAfter(debutCalcule)) {
                    totalMinutes += ChronoUnit.MINUTES.between(debutCalcule, finCalcule);
                }
            }

            courant = courant.toLocalDate().plusDays(1).atTime(heureDebut);
        }

        return totalMinutes;
    }

    private boolean estJourOuvre(LocalDateTime dateTime) {
        DayOfWeek jour = dateTime.getDayOfWeek();
        return jour != DayOfWeek.SATURDAY && jour != DayOfWeek.SUNDAY;
    }
}
