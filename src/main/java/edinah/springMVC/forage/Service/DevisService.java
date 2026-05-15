package edinah.springMVC.forage.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edinah.springMVC.forage.Model.DemandeStatus;
import edinah.springMVC.forage.Model.DetailDevis;
import edinah.springMVC.forage.Model.Devis;
import edinah.springMVC.forage.Model.TypeDevis;
import edinah.springMVC.forage.Model.Utils;
import edinah.springMVC.forage.Repository.TypeDevisRepository;
import jakarta.transaction.Transactional;
import edinah.springMVC.forage.Repository.DevisRepository;
@Service
public class DevisService {
    @Autowired
    private DetailDevisService detailDevisService;

    @Autowired
    private TypeDevisRepository typeDevisRepository;

    @Autowired
    private DevisRepository devisRepository;

    @Autowired
    private DemandeStatusService demandeStatusService;

    public Devis saveDevis(Devis devis, int idDemande, int idTypeDevis) {
        devis.setIdDemande(idDemande);
        devis.setDateDevis(LocalDate.now());
        devis.setIdTypeDevis(idTypeDevis);
        return devisRepository.save(devis);
    }

    public Devis findById(int id) {
        return devisRepository.findById(id).orElse(null);
    }

    public List<Devis> findAll() {
        return devisRepository.findAll();
    }

    public void removeDevis(int id) {
        devisRepository.deleteById(id);
    }

    public List<TypeDevis> findAllTypeDevis() {
        return typeDevisRepository.findAll();
    }

    @Transactional
    public void saveAll(int idDemande, Devis devis, List<DetailDevis> details, TypeDevis typeDevis) {
        Devis savedDevis = saveDevis(devis, idDemande, typeDevis.getIdTypeDevis());

        for (DetailDevis detail : details) {
            detail.setId_devis(savedDevis.getIdDevis());
            detailDevisService.saveDetailDevis(detail);
        }

        Utils utils = new Utils();
        int idStatus = utils.ChercherIdStatus(typeDevis);

        DemandeStatus status = new DemandeStatus();
        status.setId_demande(idDemande);
        status.setId_status(idStatus);
        status.setDate_status(LocalDateTime.now());

        demandeStatusService.ajouterDemandeStatus(status);
    }
}
