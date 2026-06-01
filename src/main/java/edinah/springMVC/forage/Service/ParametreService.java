package edinah.springMVC.forage.Service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edinah.springMVC.forage.Model.Parametre;
import edinah.springMVC.forage.Repository.ParametreRepository;

@Service
public class ParametreService {

    @Autowired
    private ParametreRepository parametreRepository;

    public String trouverCouleur(Integer idStatus1, Integer idStatus2, Long duree) {
        if (idStatus1 == null || idStatus2 == null || duree == null) {
            return null;
        }

        List<Parametre> params = parametreRepository.findApplicableParams(idStatus1, idStatus2, duree);
        return params.isEmpty() ? null : params.get(0).getCouleur();
    }
}
