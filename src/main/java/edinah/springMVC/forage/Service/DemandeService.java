package edinah.springMVC.forage.Service;

import java.util.List;

import edinah.springMVC.forage.Model.Demande;
import edinah.springMVC.forage.Repository.DemandeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DemandeService {

    @Autowired
    private DemandeRepository demandeRepository;

    public int ajouterDemande(Demande d) {
        return demandeRepository.save(d);
    }

    public List<Demande> listerDemandes() {
        return demandeRepository.findAll();
    }

    public Demande getDemande(int idDemande) {
        return demandeRepository.findById(idDemande);
    }

    public int modifierDemande(Demande d) {
        return demandeRepository.update(d);
    }

    public int supprimerDemande(int idDemande) {
        return demandeRepository.delete(idDemande);
    }
}
