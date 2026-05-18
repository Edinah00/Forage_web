package edinah.springMVC.forage.Service;
import edinah.springMVC.forage.Model.DemandeStatus;
import java.util.List;

import edinah.springMVC.forage.Model.Demande;

import edinah.springMVC.forage.Repository.DemandeRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import edinah.springMVC.forage.Service.DemandeStatusService;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;

@Service
public class DemandeService {

    @Autowired
    private DemandeRepository demandeRepository;

    @Autowired
    private DemandeStatusService dS;

    @Transactional
    public int ajouterDemande(Demande d) {
        Demande demandeEnregistree = demandeRepository.save(d);

        DemandeStatus status = new DemandeStatus();
        status.setId_demande(demandeEnregistree.getId_demande());
        status.setId_status(1);
        status.setDate_status(LocalDateTime.now());

        dS.ajouterDemandeStatus(status);

        return demandeEnregistree.getId_demande();
    }

    public List<Demande> listerDemandes() {
        return demandeRepository.findAll();
    }

    public Demande getDemande(int idDemande) {
        return demandeRepository.findById(idDemande).orElse(null);
    }

    public Demande getDemandeByRef(String refDemande) {
        return demandeRepository.findByRefDemande(refDemande).orElse(null);
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
    @Transactional
    public int validerDemande(int d) {
        //Demande demandeEnregistree = demandeRepository.save(d);
        
        DemandeStatus status = new DemandeStatus();
        status.setId_demande(d);
        status.setId_status(3);
        status.setDate_status(LocalDateTime.now());

        dS.ajouterDemandeStatus(status);

        return d;
    }
    
    @Transactional
    public int refuséDemande(int d) {
        //Demande demandeEnregistree = demandeRepository.save(d);

        DemandeStatus status = new DemandeStatus();
        status.setId_demande(d);
        status.setId_status(2);
        status.setDate_status(LocalDateTime.now());

        dS.ajouterDemandeStatus(status);

        return d;
    }
}
