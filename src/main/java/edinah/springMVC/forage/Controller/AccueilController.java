package edinah.springMVC.forage.Controller;

import edinah.springMVC.forage.Repository.ClientRepository;
import edinah.springMVC.forage.Service.DemandeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

/**
 * CORRECTION : ajout de demandesAcceptees au modèle
 *              (affiché dans accueil.jsp mais jamais transmis auparavant)
 */
@Controller
public class AccueilController {

    @Autowired private DemandeService   demandeService;
    @Autowired private ClientRepository clientRepo;

    @GetMapping({"/", "/accueil"})
    public String accueil(Model model) {
        model.addAttribute("totalDemandes",     demandeService.listerDemandes().size());
        model.addAttribute("totalClients",      clientRepo.count());
        model.addAttribute("demandesAcceptees", demandeService.compterDemandesAcceptees()); // ← AJOUTÉ
        return "accueil";
    }
}