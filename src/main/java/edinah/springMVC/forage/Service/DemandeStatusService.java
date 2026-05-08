package edinah.springMVC.forage.Service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edinah.springMVC.forage.Model.DemandeStatus;
import edinah.springMVC.forage.Model.DemandeStatusId;
import edinah.springMVC.forage.Repository.DemandeStatusRepository;
import jakarta.transaction.Transactional;

@Service
public class DemandeStatusService {
    
    @Autowired
    private DemandeStatusRepository demandeStatusRepository;

    @Transactional
    public int ajouterDemandeStatus(DemandeStatus d) {
        demandeStatusRepository.save(d);
        return d.getId_demande();
    }

    public List<DemandeStatus> listerDemandes() {
        return demandeStatusRepository.findAll();
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
    public int supprimerDemande(int idDemande, int idStatus) {
        demandeStatusRepository.deleteById(new DemandeStatusId(idDemande, idStatus));
        return idDemande;
    }
}
