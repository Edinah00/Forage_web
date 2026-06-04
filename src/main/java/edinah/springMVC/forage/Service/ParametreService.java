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

    public String trouverCouleur(Long duree) {
        if (duree == null) return null;
        List<Parametre> params = parametreRepository.findApplicableParams(duree);
        return params.isEmpty() ? null : params.get(0).getCouleur();
    }
}
